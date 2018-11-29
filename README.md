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
 
   

