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
  
  ![1NN](https://pp.userapi.com/c847021/v847021209/1340ed/HXK78j3JD2A.jpg)
  
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
 
 ![KNN](https://user-images.githubusercontent.com/44859059/48863749-79177000-eddb-11e8-9967-8fc145049c53.png)
 
   

