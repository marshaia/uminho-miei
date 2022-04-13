/**
 * Data de Criação: 27/05/2021
 * Autor: Vicente Moreira
 * 
 * Código do Filter Manager. 
 * Este é responsável por ler a configuração inicial dos filtros e indicar
 * se os vários requests são válidos
 */

#include "../includes/filterMGR.h"

#define LINE_SIZE 64

typedef struct filter
{
    char* codigo;
    char* nome;
    int utilizados;
    int max;
}*Filter;

struct filterl
{
    int capacity;
    int size;
    char* filterFolder;
    Filter* list;
};

FilterList init_FilterList(int size){
    FilterList new = malloc(sizeof(struct filterl));
    new->list = malloc(sizeof(Filter)*size);
    new->capacity = size;
    new->size = 0;
    new->filterFolder = NULL;
    return new;
}


void fL_increase_capacity(FilterList target){
    target->capacity *= 2;
    Filter* newArr = reallocarray(target->list,sizeof(Filter),target->capacity);
    if(newArr) target->list = newArr;
    else {
        //Error
    }
    
}

void fL_set_filterFolder(FilterList target,char* path){
    target->filterFolder = strdup(path);
}

char* fL_get_filterCode(FilterList target,char* name){
    for(int aux = 0;aux < target->size;aux++){
        if(strcmp(name,target->list[aux]->nome) == 0)
            return strdup(target->list[aux]->codigo);
    }
    return NULL;
}

char* fL_get_filterFolder(FilterList target){
     return strdup(target->filterFolder);
}

char* fL_get_filterExec(FilterList target,char* name){
    char* filterCode = fL_get_filterCode(target,name);
    int size = strlen(target->filterFolder) + strlen(filterCode)+3;
    char* res = malloc(sizeof(char)*size);
    res[0]='\0';
    strcat(res,"./");
    strcat(res,target->filterFolder);
    strcat(res,filterCode);
    free(filterCode);
    return res;
}

void fL_add_filter(FilterList target,Filter filter){
    if(target->size == target->capacity)
        fL_increase_capacity(target);
    target->list[target->size] = filter;
    target->size++;
}

Filter filter_fromLine(char* line){
    Filter new = malloc(sizeof(struct filter));
    new->utilizados = 0;
    new->nome = strdup(strsep(&line," "));
    new->codigo = strdup(strsep(&line," "));
    new->max = atoi(strsep(&line,"\n"));
    return new;
}

FilterList fL_load_FilterList_fromFile(char* filepath){
    FILE* fd = fopen(filepath,"r");
    if(!fd) return NULL;

    FilterList ready = init_FilterList(1);

    char* line = malloc(sizeof(char)*LINE_SIZE);
    while(fgets(line,LINE_SIZE,fd)){
        Filter fil = filter_fromLine(line);
        fL_add_filter(ready,fil);
    }

    fclose(fd);
    return ready;
}

int fL_filters_action(FilterList target,char* filters,int mode){ // 0 - check if exist, 1- check if free, 2- occupy filters, 3- free filters
    char* fres = filters;
    int res = 1;
    while(filters && res){
        char* filt = strsep(&filters," ");
        int found = 0;
        for(int aux = 0;aux < target->size && !found;aux++){
            if(strcmp(target->list[aux]->nome,filt) == 0){
                found = 1;
                if(mode == 0); //Não faz nada pois só verifica se eles existem.
                else if(mode == 1 && target->list[aux]->utilizados >= target->list[aux]->max) res = 0;
                else if(mode == 2) target->list[aux]->utilizados++;
                else if(mode == 3) target->list[aux]->utilizados--;
            }
        }
        if(!found) res = 0;
    }
    if(fres) free(fres);
    return res;
}

char* fL_toString(FilterList target){
    char* res = malloc(sizeof(char) * (16 + target->size*128));
    res[0] = '\0';
    strcat(res,"Filtros: \n");
    for(int aux = 0;aux < target->size;aux++){
        char* filtro = malloc(sizeof(char)*128);
        sprintf(filtro,"   %s (%s): Using %d from Max %d\n",target->list[aux]->nome,
                                                            target->list[aux]->codigo,
                                                            target->list[aux]->utilizados,
                                                            target->list[aux]->max);
        strcat(res,filtro);
        free(filtro);
    }
    return res;
}


void free_Filter(Filter target){
    free(target->codigo);
    free(target->nome);
    free(target);
}

void free_FilterList(FilterList target){
    for(int aux = 0;aux < target->size;aux++){
        free_Filter(target->list[aux]);
    }
    free(target);
}