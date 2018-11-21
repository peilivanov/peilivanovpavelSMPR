# Метрические классификаторы

## Алгоритм ближайшего соседа
 ТЕОРИЯ:
 
1NN(Алгоритм ближайшего соседа) - относит классифицируемый объект и принадлжит <a href="https://www.codecogs.com/eqnedit.php?latex=X^{l}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?X^{l}" title="X^{l}" /></a> к тому  классу, к которому приналежит его ближайший сосед :
 <a href="https://www.codecogs.com/eqnedit.php?latex=w(i,x)&space;=&space;[i\leq&space;1]" target="_blank"><img src="https://latex.codecogs.com/gif.latex?w(i,x)&space;=&space;[i\leq&space;1]" title="w(i,x) = [i\leq 1]" /></a>
    
    
  Преимущества метода :
     - Простота реализации
     
  Недостатки метода :
      - Неустойчивость к погрешностям
      - Отсутсвие параметров, которые можно было бы настраивать по выборке. Алгоритм полностью зависит от того, насколько удачно            выбранна метрика p.
      - Низкое качество классификации.
      

