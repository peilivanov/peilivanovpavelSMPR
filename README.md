## Навигация

- [Метрические классификаторы](#Метрические-классификаторы)
  - [Алгоритм ближайшего соседа](#Алгоритм-ближайшего-соседа)
  - [Алгоритм K ближайших соседей](#Алгоритм-K-ближайших-соседей)
  - [Алгоритм k взвешнных ближайших соседей](#Алгоритм-k-взвешнных-ближайших-соседей)
  - [Парзеновское окно (PW)](#Парзеновское-окно-pw)

- [Байесовские классификаторы](#Байесовские-классификаторы)
  - [Линии уровня нормального распределения](#Линии-уровня-нормального-распределения)
  - [Наивный нормальный байесовский классификатор](#Наивный-нормальный-байесовский-классификатор)
  - [Подстановочный алгоритм (Plug-in)](#Подстановочный-алгоритм-plug-in)
  - [Линейный дискриминант Фишера (ЛДФ)](#Линейный-дискриминант-Фишера-ЛДФ)
- [Линейные классификаторы](#Линейные-классификаторы)


# Метрические классификаторы

## Алгоритм ближайшего соседа
 **ТЕОРИЯ:**
 
1NN(Алгоритм ближайшего соседа) - относит классифицируемый объект к тому  классу, к которому приналежит его ближайший сосед :
 
 <a href="https://www.codecogs.com/eqnedit.php?latex=w(i,x)&space;=&space;[i\leq&space;1]" target="_blank"><img src="https://latex.codecogs.com/gif.latex?w(i,x)&space;=&space;[i\leq&space;1]" title="w(i,x) = [i\leq 1]" /></a>
    
    
  Преимущества метода :
  
   - Простота реализации
   - O(1) - время обучения
     
  Недостатки метода :
  
   - Неустойчивость к погрешностям
   - Отсутсвие параметров, которые можно было бы настраивать по выборке. Алгоритм полностью зависит от того, насколько удачно выбранна метрика p.
   - Низкое качество классификации.
      
 
 **Практическая реализация кода ( decoding ) :**
 
   Вначале задаем метрику. Метрика - это такая функция, которая измеряет меру близости.
    После этого мы задаем функцию nn, которая принимает  объект u, множество объектов xl, метрику и возвращает наиболее близкий объект из множества xl к объекту u. Далее рисуется выборка. После этого надо классифицировать всю плоскость процедурой замощения.
   
   
  **Результат**
  
  ![1NN](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA2345.PNG)
  
  ## Алгоритм K ближайших соседей
   **ТЕОРИЯ:**
   
   KNN(Алгоритм K ближайших соседей) - относит объект u к тому классу элементов, которого больше среди k ближайших соседедей.
      
      **Attention** (опирается на ранг соседа!)
      
   <a href="https://www.codecogs.com/eqnedit.php?latex=$$w(i,x)&space;=&space;[i&space;\leq&space;k]$$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$$w(i,x)&space;=&space;[i&space;\leq&space;k]$$" title="$$w(i,x) = [i \leq k]$$" /></a> - метод KNN
      
      
   **Практическая реализация кода ( decoding ) :**
   
   Вначале задаем метрику. 
   Сортируем объекты согласно расстояния до объекта z. Далее создаем матрицу расстояний -> сортируем нашу выборку. 
     
   Применяем метод kNN и сортируем выборку согласно классифицируемого объектаю
   Получаем классы первых k соседей ->  составляем таблицу встречаемости каждого класса -> находим класс, который доминирует среди первых k соседей. Рисуем выборку. Далее идет классификация одного заданного объекта.
   
   
 **Результат**
 
 ![KNN](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/knnPic.PNG)
 
 ## Выбор параметра k с помощью LOO
 На практике оптимальное k подбирается по критерию скользящего контроля LOO (Leave One Out)
 
 <a href="https://www.codecogs.com/eqnedit.php?latex=LOO(k,&space;X^l&space;)=&space;\sum_{i=1}^{l}&space;\left&space;[&space;a(x_i;&space;X^l\setminus&space;\lbrace&space;x_i&space;\rbrace&space;,&space;k)&space;\neq&space;y_i&space;\right&space;]&space;\rightarrow&space;\min_k&space;." target="_blank"><img src="https://latex.codecogs.com/gif.latex?LOO(k,&space;X^l&space;)=&space;\sum_{i=1}^{l}&space;\left&space;[&space;a(x_i;&space;X^l\setminus&space;\lbrace&space;x_i&space;\rbrace&space;,&space;k)&space;\neq&space;y_i&space;\right&space;]&space;\rightarrow&space;\min_k&space;." title="LOO(k, X^l )= \sum_{i=1}^{l} \left [ a(x_i; X^l\setminus \lbrace x_i \rbrace , k) \neq y_i \right ] \rightarrow \min_k ." /></a>
 
 **Описание**
 
 LOO проверяет алгоритмы на точность. Сначала исключаются по очереди по 1 элементу из выборки -> алгоритм обучается на оставшихся алгоритмах выборки -> извлеченныый элемент классифицируется ->  его ( элемент ) надо вернуть -> далее извлекается следующий и так далее со всеми элементами выборки => после всех проделанных действий можно заметить, где алгоритм ошибается.
 
 
 **Результат**
 
 ![LOO](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/looPic.PNG)
 
 ## Алгоритм k взвешнных ближайших соседей
 
 **Теория:**
 

 В каждом классе выбирается k ближайших к U объектов, и объект u относится к тому классу, для которого среднее расстояние до k ближайших соседей минимально.
 
 <a href="https://www.codecogs.com/eqnedit.php?latex=$w(i,x)&space;=&space;[i&space;\leq&space;k]w_i$" target="_blank"><img src="https://latex.codecogs.com/gif.latex?$w(i,x)&space;=&space;[i&space;\leq&space;k]w_i$" title="$w(i,x) = [i \leq k]w_i$" /></a> - метод k взвешнных ближайших соседей.
 
 w(i) - строго убывающая последовательность вещественных весов, задающая вклад i-го ссоседа при классификации объекта u.
 
 **Преимущества:**
 
  Главный плюс метода заключается в том, что учитывается степень близости объекта.
  
  **Результат:**
  
  ![kWNN](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/KWNNpic.png)
  
  ## Парзеновское окно (PW)

Для оценки близости объекта _u_ к классу _y_ алгоритм использует следующую
функцию:

![](http://latex.codecogs.com/svg.latex?%5Clarge%20W%28i%2C%20u%29%20%3D%20K%28%5Cfrac%7B%5Crho%28u%2C%20x%5Ei_u%29%7D%7Bh%7D%29)
, где 
![](http://latex.codecogs.com/svg.latex?%5Clarge%20K%28z%29) — функция ядра.

Чаще всего применяются 5 типов ядер:
- Прямоугольное ![](http://latex.codecogs.com/svg.latex?%5Clarge%20R%28z%29%20%3D%20%5Cfrac%7B1%7D%7B2%7D%20%5B%7Cz%7C%20%5Cleq%201%5D)
- Треугольное ![](http://latex.codecogs.com/svg.latex?%5Clarge%20T%28z%29%20%3D%20%281%20-%20%7Cz%7C%29%20%5Ccdot%20%5B%7Cz%7C%20%5Cleq%201%5D)
- Квартическое ![](http://latex.codecogs.com/svg.latex?%5Clarge%20Q%28z%29%20%3D%20%5Cfrac%7B15%7D%7B16%7D%20%281%20-%20z%5E2%29%5E2%20%5Ccdot%20%5B%7Cz%7C%20%5Cleq%201%5D)
- Епанечниково ![](http://latex.codecogs.com/svg.latex?%5Clarge%20E%28z%29%20%3D%20%5Cfrac%7B3%7D%7B4%7D%20%281%20-%20z%5E2%29%20%5Ccdot%20%5B%7Cz%7C%20%5Cleq%201%5D)
- Гауссовское (нормальное распределение)

Программная реализация ядер:
```
mc.kernel.R = function(r) 0.5 * (abs(r) <= 1) #прямоугольное
mc.kernel.T = function(r)(1 - abs(r)) * (abs(r) <= 1) #треугольное
mc.kernel.Q = function(r)(15 / 16) * (1 - r ^ 2) ^ 2 * (abs(r) <= 1) #квартическое
mc.kernel.E = function(r)(3 / 4) * (1 - r ^ 2) * (abs(r) <= 1) #епанечниково
mc.kernel.G = function(r) dnorm(r) #гауссовское
```
Шаги алгоритма парзеновского окна очень схожи с алгоритмом kwNN, отличаются они различными функциями ядра и наличием такой переменной, как ширина окна.
В программе ядра будут применяться поочередно.
Однако на разницу в качестве классификации они влияют слабо.
Выделяется лишь _гауссовское ядро_.

Карта классификации метода парзеновского окна с использованием квадрического ядра. 

![pw_map](https://user-images.githubusercontent.com/44859059/49109338-7e713080-f29b-11e8-8468-5ab70f77f3ab.png)

Loo для треугольного ядра:


![loopw](https://user-images.githubusercontent.com/44859059/50244640-837c5800-03e1-11e9-91e9-aff25ad3c53b.png)


Loo для Епанечникова ядра:


![loopwep](https://user-images.githubusercontent.com/44859059/50244692-a3138080-03e1-11e9-877f-9660b000c3d1.png)

Плюсы:
- прост в реализации
- хорошее качество классификации при правильно подобраном _h_
- все точки с одинаковым расстоянием будут учитаны

__Минусы:__
- необходимо хранить всю выборку целиком
- бедный набор параметров
- в случае одинаковых весов классов алгоритм выбирает любой
- диапазон параметра h необходимо подбирать самостоятельно, учитывая
плотность расположения точек
  
# Баейсовские классификаторы
  
  **Баейсовский классификатор** — широкий класс алгоритмов классификации, основанный на принципе максимума апостериорной вероятности. Для классифицируемого объекта вычисляются функции правдоподобия каждого из классов, по ним вычисляются апостериорные вероятности классов. Объект относится к тому классу, для которого апостериорная вероятность максимальна. 
  Байесовский подход к классификации основан на теореме, утверждающей, что если плотности распределения каждого из классов известны, то искомый алгоритм можно выписать в явном аналитическом виде. Более того, этот алгоритм оптимален, то есть обладает минимальной вероятностью ошибок.

На практике плотности распределения классов, как правило, не известны. Их приходится оценивать (восстанавливать) по обучающей выборке. В результате байесовский алгоритм перестаёт быть оптимальным, так как восстановить плотность по выборке можно только с некоторой погрешностью. Чем короче выборка, тем выше шансы подогнать распределение под конкретные данные и столкнуться с эффектом переобучения.

Байесовский подход к классификации является одним из старейших, но до сих пор сохраняет прочные позиции в теории распознавания. Он лежит в основе многих достаточно удачных алгоритмов классификации. 

## Линии уровня нормального распределения

 НОРМАЛЬНОЕ РАСПРЕДЕЛЕНИЕ - математическая модель, описывающая распределение случайных (независимых) величин; оно непрерывно, унимодально и симметрично и характеризуется тем, что, по мере удаления от среднего (максимального) значения, частота появления случайной величины падает. При известных параметрах эта модель хорошо апроксимирует статистические данные при достаточно большом объеме (выборке), несмотря на отдельные отклоне.
 
Рассмотрим многомерное нормальное распределение. Пусть <a href="https://www.codecogs.com/eqnedit.php?latex=x\epsilon&space;\mathbb{R}^{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x\epsilon&space;\mathbb{R}^{n}" title="x\epsilon \mathbb{R}^{n}" /></a> вероятностное распределение с плотностью
 
 ![](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/Bayes/z1.PNG)
 
 называется n-мерным многомерным нормальным (гауссовским) распределением с математическим ожиданием (центром) n и ковариационной матрицей <a href="https://www.codecogs.com/eqnedit.php?latex=\mu&space;\epsilon&space;\mathbb{R}^{n}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mu&space;\epsilon&space;\mathbb{R}^{n}" title="\mu \epsilon \mathbb{R}^{n}" /></a>, которая является симметричной, невырожденной и положительно определенная.
 
 <a href="https://peilivanov.shinyapps.io/LineLevels/">Реализация программы в ShinyAPP</a>
 
 **Пример:**
 ![](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/Bayes/linelev.PNG)
 
 
 ## Наивный нормальный байесовский классификатор
 
 Наивный байесовский алгоритм – это алгоритм классификации, основанный на теореме Байеса с допущением о независимости признаков. Другими словами, НБА предполагает, что наличие какого-либо признака в классе не связано с наличием какого-либо другого признака. Например, фрукт может считаться яблоком, если он красный, круглый и его диаметр составляет порядка 8 сантиметров. Даже если эти признаки зависят друг от друга или от других признаков, в любом случае они вносят независимый вклад в вероятность того, что этот фрукт является яблоком. В связи с таким допущением алгоритм называется «наивным».

Модели на основе НБА достаточно просты и крайне полезны при работе с очень большими наборами данных. При своей простоте НБА способен превзойти даже некоторые сложные алгоритмы классификации.

Теорема Байеса позволяет рассчитать апостериорную вероятность P(c|x) на основе P(c), P(x) и P(x|c).


<a href="https://www.codecogs.com/eqnedit.php?latex=P(c|x)=\frac{P(x|c)P(c))}{P(x)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(c|x)=\frac{P(x|c)P(c))}{P(x)}" title="P(c|x)=\frac{P(x|c)P(c))}{P(x)}" /></a>
 
 
 На рисунке выше:

P(c|x) – апостериорная вероятность данного класса c (т.е. данного значения целевой переменной) при данном значении признака x.
P(c) – априорная вероятность данного класса.
P(x|c) – правдоподобие, т.е. вероятность данного значения признака при данном классе.
P(x) – априорная вероятность данного значения признака.

**Как работает наивный байесовский алгоритм?**

Ниже представлен обучающий набор данных, содержащий один признак «Погодные условия» (weather) и целевую переменную «Игра» (play), которая обозначает возможность проведения матча. На основе погодных условий мы должны определить, состоится ли матч. Чтобы сделать это, необходимо выполнить следующие шаги.


Шаг 1. Преобразуем набор данных в частотную таблицу (frequency table).


Шаг 2. Создадим таблицу правдоподобия (likelihood table), рассчитав соответствующие вероятности. Например, вероятность облачной погоды (overcast) составляет 0,29, а вероятность того, что матч состоится (yes) – 0,64.


Шаг 3. С помощью теоремы Байеса рассчитаем апостериорную вероятность для каждого класса при данных погодных условиях. Класс с наибольшей апостериорной вероятностью будет результатом прогноза.


![](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/Bayes/Bayes_41.png)

Sunny – Солнечная погода
Rainy – Дождливая погода
Overcast – Облачная погода

**Пример вывода в програмной реализации:**

![](https://github.com/peilivanov/peilivanovpavelSMPR/blob/master/Bayes/naiv.PNG)

   
## Подстановочный алгоритм (Plug-in)
