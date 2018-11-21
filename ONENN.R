eucl_metrics <- function(x, y) {
   sqrt(sum((x - y)^2)) 
}


nn <- function(u, xl, metrics=eucl_metrics) {
    ell <- nrow(xl)
    n <- ncol(xl)-1
    dists <- c()
    for (i in 1:ell) 
        dists <- c(dists, metrics(xl[i, 1:n], u))
    class <- xl[order(dists)[1], n+1]
    return(class)  
} 

main <- function() {

	colors <- c("sentosa" = "red", "versicolor" = "green3", "virginica" = "blue")
	plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)


	for(x in seq(0,7,by=0.1)){
		for(y in seq(0,3,by=0.1)){
			z <- c(x, y)
    			xl <- iris[, 3:5]
    			class <- nn(z, xl)
    			points(z[1], z[2], pch = 1,col= colors[class], asp = 1)
		}
	}
 
	

}


main()