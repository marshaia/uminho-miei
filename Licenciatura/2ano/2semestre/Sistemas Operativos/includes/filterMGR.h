/**
 * Data de Criação: 27/05/2021
 * Autor: Vicente Moreira
 * 
 * Api do filter Manager. 
 * Este é responsável por ler a configuração inicial dos filtros e indicar
 * se os vários requests são válidos.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct filterl *FilterList;

/**
 * Carrega os filtros de um ficheiro
 */
FilterList fL_load_FilterList_fromFile(char* filepath);

/**
 * Define o path dos filtros
 */
void fL_set_filterFolder(FilterList target,char* path);

/**
 * Get o códgio do filtro
 */
char* fL_get_filterCode(FilterList target,char* name);

/**
 * Get Path dos filtros
 */
char* fL_get_filterFolder(FilterList target);

/**
 * Com o nome do filtro devolve o path para a sua execução
 */
char* fL_get_filterExec(FilterList target,char* name);

/**
 * Função principal do Módulo. Dependendo do "Mode" faz ações diferentes
 * 0 - Verifica se os filtros existem na máquina. (Devolve "bool")
 * 1 - Verifica se os filtros estão disponíveis   (Devolve "bool")
 * 2 - Ocupa os filtros 
 * 3 - Liberta os filtros
 */
int fL_filters_action(FilterList target,char* filters,int mode);

/**
 * Função toString
 */
char* fL_toString(FilterList target);

/**
 * Liberta a lista
 */
void free_FilterList(FilterList target);
