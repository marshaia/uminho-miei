# **Experimentação em Engenharia de Software**



### **Autores (Grupo 8):**

- PG50180 - Ana Catarina
- PG50457 - Joana Alves
- PG50379 - Francisco Toldy

## **Performance de Algoritmos de Ordenação**

Neste trabalho temos como objetivo medir a performance de três algoritmos de ordenação (_heap sort_, _quick sort_ e _merge sort_), utilizando para isso implementações similares dos mesmos em duas linguagens de programação (_Python_ e _C_).

Para além disto, cada algoritmo foi ainda implementado em três versões dependendo do seu tamanho de input: pequeno (1K elementos), médio (5K elementos) e, por fim, grande (10K elementos). É também de notar que todos os inputs do mesmo tamanho são iguais em si e não contêm elementos repetidos.





### __Utilização:__
No ficheiro `merged.csv` encontram-se os resultados obtidos pelo grupo que foram utilizados para a análise estatística efetuada.

Para correr todos os algoritmos, basta executar:
```sh
$ make all
```