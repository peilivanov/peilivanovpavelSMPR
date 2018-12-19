library(shiny)
library(MASS)
library(car)

estimateMu <- function(objects)
{
  ## mu = 1 / m * sum_{i=1}^m(objects_i)
  rows <- dim(objects)[1]
  cols <- dim(objects)[2]
  
  mu <- matrix(NA, 1, cols)
  for (col in 1:cols)
  {
    print(col)
    mu[1, col] = mean(objects[,col])
  }
  
  return(mu)
} 

estimateCovarianceMatrix <- function(objects, mu)
{
  rows <- dim(objects)[1]
  cols <- dim(objects)[2]
  sigma <- matrix(0, cols, cols)
  
  for (i in 1:rows)
  {
    sigma <- sigma + (t(objects[i,] - mu) %*% (objects[i,] - mu)) / (rows - 1)
  }
  
  return (sigma)
}

getPlugInDiskriminantCoeffs <- function(mu1, sigma1, mu2, sigma2)
{
  ## Line equation: a*x1^2 + b*x1*x2 + c*x2 + d*x1 + e*x2 + f = 0
  invSigma1 <- solve(sigma1)
  invSigma2 <- solve(sigma2)
  
  f <- log(abs(det(sigma1))) - log(abs(det(sigma2))) + mu1 %*%
    invSigma1 %*% t(mu1) - mu2 %*% invSigma2 %*% t(mu2);
  
  alpha <- invSigma1 - invSigma2
  
  a <- alpha[1, 1]
  b <- 2 * alpha[1, 2]
  c <- alpha[2, 2]
  
  beta <- invSigma1 %*% t(mu1) - invSigma2 %*% t(mu2)
  d <- -2 * beta[1, 1]
  e <- -2 * beta[2, 1]
  return (c("x^2" = a, "xy" = b, "y^2" = c, "x" = d, "y" = e, "1" = f))
} 

Normal_Distribution <- function(x, mu, sigma)
{
  n <- length(x)
  return ((1.0 / ((2*pi)^(n/2))) * exp(-0.5*t(x-mu) %*% solve(sigma) %*% (x-mu)))
}

Draw_Level_Lines <- function(mu, sigma, borders, h, lwd)
{
  minx <- borders[1] - 2
  maxx <- borders[2] + 2
  miny <- borders[3]
  maxy <- borders[4]
  
  x <- seq(from = minx, to = maxx, by = ((maxx - minx)/((maxx - minx)/h)))
  y <- seq(from = miny, to = maxy, by = ((maxy - miny)/((maxy - miny)/h)))
  
  z = matrix(nrow = length(x), ncol = length(y))
  
  for (i in 1:length(x))
  {
    for (j in 1:length(y))
    {
      z[i, j] = Normal_Distribution(c(x[i], y[j]), mu, sigma)
    }
  }
  
  print(z)
  
  contour(x, y, z, nlevels = 10, xlim = range(x, finite = TRUE),
          ylim = range(y, finite = TRUE),
          zlim = range(z, finite = TRUE), add = TRUE, lwd = lwd)
}

Draw_Gradient_Plot <- function(mu, sigma, borders, h, color, coeffs)
{
  minx <- borders[1] - 2
  maxx <- borders[2] + 1
  miny <- borders[3]
  maxy <- borders[4]
  
  print(borders)
  
  x <- minx
  while (x <= maxx)
  {
    y <- miny
    while (y <= maxy)
    {
      p <- Normal_Distribution(c(x, y), mu, sigma)
      
      print("p:")
      print(p)

      z <- coeffs["x^2"]*x^2 + coeffs["xy"]*x*y + coeffs["y^2"]*y^2 + coeffs["x"]*x + coeffs["y"]*y + coeffs["1"]
      print(z)
      
      if (color == "blue" && z < 0) 
      {
        cur_color <- rgb((0.16 - p) * 6.25, (0.16 - p) * 6.25, 1.0)                   
        points(x, y, col = cur_color, pch = 16)
      }
      if (color == "green" && z > 0)
      {
        cur_color <- rgb((0.16 - p) * 6.25, 1.0, (0.16 - p) * 6.25)
        points(x, y, col = cur_color, pch = 16)
      }
      
      y <- y + h
    }
    x <- x + h
  }
  return ()
}

Classification_by_Naive_Normal_Bayes <- function(z, mu, sigma)
{
  number_of_features <- length(z)
  number_of_classes <- dim(mu)[1]
  
  p <- matrix(c(0, 0, 0, 0), nrow = number_of_classes, ncol = number_of_features)
  
  for (j in 1:number_of_features)
  {
    for (i in 1:number_of_classes)
    {
      p[i, j] <- 1.0/(sqrt(sigma[i, j])*sqrt(2*pi)) * exp(-((z[j] - mu[i, j])^2)/(2.0 * sigma[i, j]))   #j+2 ??.??. ???????????????????? ???????????????? ?????????????? ???????????????? (??.??. ???????????????????? ???????????? ???????????????? 3 ?? 4 ?????? ???????????????????? ?????????? ??????????????????????????)
    }
  }
  
  Py = rep(1.0, number_of_classes)
  for (i in 1:number_of_classes)
  {
    for (j in 1:number_of_features)
    {
      Py[i] <- Py[i] * p[i, j]  
    }
  }
  
  index_of_class <- which.max(Py)
  
  return (index_of_class)
}

shinyServer(function(input, output, session) {
  ObjectsCountOfEachClas <- reactive({})
    Mu1x <- reactive({})
    Mu1y <- reactive({})
    Mu2x <- reactive({})
    Mu2y <- reactive({})
    
    S1_11 <- reactive({})
    S1_12 <- reactive({})
    S1_21 <- reactive({})
    S1_22 <- reactive({})
    
    S2_11 <- reactive({})
    S2_12 <- reactive({})
    S2_21 <- reactive({})
    S2_22 <- reactive({})
    
    output$Plot <- renderPlot({
      Sigma1 <- matrix(c(input$S1_11, input$S1_12, input$S1_21, input$S1_22), 2, 2)
      Sigma2 <- matrix(c(input$S2_11, input$S2_12, input$S2_21, input$S2_22), 2, 2)
      
      Mu1 <- c(input$Mu1x, input$Mu1y)
      Mu2 <- c(input$Mu2x, input$Mu2y)
      
      xy1 <- mvrnorm(n=input$ObjectsCountOfEachClass, Mu1, Sigma1)
      xy2 <- mvrnorm(n=input$ObjectsCountOfEachClass, Mu2, Sigma2)
      
      xl <- rbind(cbind(xy1, 1), cbind(xy2, 2))
      
      colors <- c(rgb(0/255, 162/255, 232/255), rgb(0/255, 200/255, 0/255))
      plot(xl[,1], xl[,2], pch = 21, bg = colors[xl[,3]], asp = 1, xlab = "x", ylab = "y")

  
     
      objectsOfFirstClass <- xl[xl[,3] == 1, 1:2]
      objectsOfSecondClass <- xl[xl[,3] == 2, 1:2]
      mu1 <- estimateMu(objectsOfFirstClass)
      mu2 <- estimateMu(objectsOfSecondClass)
      sigma1 <- estimateCovarianceMatrix(objectsOfFirstClass, mu1)
      sigma2 <- estimateCovarianceMatrix(objectsOfSecondClass, mu2)
      coeffs <- getPlugInDiskriminantCoeffs(mu1, sigma1, mu2, sigma2)
      
      x <- y <- seq(-40, 60, len = 500) 
      
      
      type_of_plot <- input$type_of_plot
      
      borders = c(min(xl[, 1]), max(xl[, 1]), min(xl[, 2]), max(xl[, 2]))
      legend(borders[1], borders[3]+3, c("Naive Normal Bayes", "Plug-in"), col = c("orange", "red"),text.col = "black", pch = c(15, 15, 15, 15), bg = "lightblue")
      
      # if (type_of_plot == "level_lines")
      # {
      #   Draw_Level_Lines(mu = Mu1, sigma = Sigma1, borders, h = 0.2, lwd = 1)
      #   Draw_Level_Lines(mu = Mu2, sigma = Sigma2, borders, h = 0.2, lwd = 1)
      # }
      # if (type_of_plot == "gradient")
      # {
      #   Draw_Gradient_Plot(mu = Mu1, sigma = Sigma1, borders, h = 0.1, color = "blue", coeffs = coeffs)
      #   Draw_Gradient_Plot(mu = Mu2, sigma = Sigma2, borders, h = 0.1, color = "green", coeffs = coeffs)
      #   
      #   for (i in 1:dim(xl)[1])
      #   {
      #     points(xl[i, 1], xl[i, 2], pch = 21, bg = colors[xl[i,3]])
      #   }  
      # }
      # 
      z <- outer(x, y, function(x, y) coeffs["x^2"]*x^2 + coeffs["xy"]*x*y + coeffs["y^2"]*y^2 + coeffs["x"]*x + coeffs["y"]*y + coeffs["1"])
      contour(x, y, z, levels = 0, drawlabels = FALSE, lwd = 3, col = "red", add = TRUE)
      
      mu <- matrix(data = c(mu1[1], mu1[2], mu2[1], mu2[2]), ncol = 2, nrow = 2, byrow = TRUE)
      sigma <- matrix(data = c(sigma1[1, 1], sigma1[2, 2], sigma2[1, 1], sigma2[2, 2]), ncol = 2, nrow = 2, byrow = TRUE)
      
      #  step_on_the_map <- 0.1
      #  
      #  x1 <- borders[1]
      #  while (x1 <= borders[2])
      #  {
      #   x2 <- borders[3]
      #   while (x2 <= borders[4])
      #   {
      #     p <- c(x1, x2)
      #     class <- Classification_by_Naive_Normal_Bayes(p, mu, sigma)
      # 
      #     cur_col <- 0
      # 
      #     if (class == 1)
      #     {
      #       cur_col <- "blue"
      #     }
      #     else
      #     {
      #       cur_col <- "green"
      #     }
      # 
      #     points(x1, x2, col = cur_col, pch = 3)
      # 
      #     x2 <- x2 + step_on_the_map
      #   }
      #   x1 <- x1 + step_on_the_map
      # }
      # 
      # for (i in 1:dim(xl)[1])
      # {
      #   if (xl[i, 3] == 1) cur_col <- "blue"
      #   if (xl[i, 3] == 2) cur_col <- "green"
      #   points(xl[i, 1], xl[i,2], col = cur_col, pch = 19)
      # }
       
       
      
      
      ly <- input$ObjectsCountOfEachClass
      ls <- ly

      sum_of_ln_sigma_y <- 0
      sum_of_ln_sigma_s <- 0
      for (i in 1:2)
      {
        sum_of_ln_sigma_y <- sum_of_ln_sigma_y + log(sqrt(sigma1[i, i]), base = exp(1))
      }
      for (i in 1:2)
      {
        sum_of_ln_sigma_s <- sum_of_ln_sigma_s + log(sqrt(sigma2[i, i]), base = exp(1))
      }
      M <- log(ly, base = exp(1)) - log(ls, base = exp(1)) - sum_of_ln_sigma_y + sum_of_ln_sigma_s 
      
      sum_mu_sqr_div_dispertion_y <- 0
      sum_mu_sqr_div_dispertion_s <- 0
      
      for (i in 1:2)
      {
        sum_mu_sqr_div_dispertion_y <- sum_mu_sqr_div_dispertion_y + (mu1[i]*mu1[i]/sigma1[i, i])
      }
      for (i in 1:2)
      {
        sum_mu_sqr_div_dispertion_s <- sum_mu_sqr_div_dispertion_s + (mu2[i]*mu2[i]/sigma2[i, i])
      }
      
      C <- -sum_mu_sqr_div_dispertion_y + sum_mu_sqr_div_dispertion_s + 2.0*M
      
      z <- outer(x, y, function(x1, x2) ((-1.0/sigma1[1, 1] + 1.0/sigma2[1, 1])*x1^2 + (-1.0/sigma1[2, 2] + 1.0/sigma2[2, 2])*x2^2 + 2.0*(mu1[1]/sigma1[1, 1] - mu2[1]/sigma2[1, 1])*x1 + 2.0*(mu1[2]/sigma1[2, 2] - mu2[2]/sigma2[2, 2])*x2))
      contour(x, y, z, levels = -C, drawlabels = FALSE, lwd = 3, col = "orange", add = TRUE)
    })
})