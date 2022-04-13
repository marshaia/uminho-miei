/**
 * Data de Criação: 22/05/2021
 * Autor: Vicente Moreira
 * 
 * Código do Queue Manager. 
 * Este é responsável pelo tratamento de dados e organização
 * da fila dos pedidos que o servirdor receber.
 * 
 * Função com o prefixo rQ são funções contidas na API. 
 */
#include "../includes/queueMGR.h"

struct reqQueue{
    int capacity;     //Capacidade da queue em memória
    int size;         //Tamanho atual da queue
    int fluhsing;     //Sinal de existência de requests em "High priority"
    int maxWait;      //Tamanho da espera de request antes de se tornarem "High priority" (Default 3)
    Request* request; //Lista de Requests
};


ReqQueue new_ReqQueue_empty(){
    ReqQueue new = malloc(sizeof(struct reqQueue));
    new->request = malloc(sizeof(Request));
    new->capacity = 1;
    new->size = 0;
    new->fluhsing = 0;
    new->maxWait = 3;
    return new;
}

void rQ_increase_capacity(ReqQueue target){
    target->capacity *= 2;
    Request* newArr = reallocarray(target->request,sizeof(Request),target->capacity);
    if(newArr) target->request = newArr;
    else {
        //Error
    }
}

int max_capacity(ReqQueue target){
    return (target->capacity == target->size);
}

int check_flushing(ReqQueue target){
    for(int aux = 0;aux < target->size;aux++){
        if(!processing(target->request[aux]) && get_waitLine(target->request[aux]) >= target->maxWait){
            target->fluhsing = 1;
            return aux;
        }
    }
    target->fluhsing = 0;
    return -1;
}

int check_pos(ReqQueue target,int pos){
    return (pos < target->size);
}

void remove_request(ReqQueue target,int pos){
    if(check_pos(target,pos)){
        free_request(target->request[pos]);
        for(int aux = pos;aux < target->size-1;aux++){
            target->request[aux] = target->request[aux+1];
        }
        target->size--;
    }
}

void rQ_incWaitLine_all(ReqQueue target){
    for(int aux = 0;aux < target->size;aux++){
        if(!processing(target->request[aux])) 
            inc_waitLine(target->request[aux]);
    }
}

void rQ_set_maxWait(ReqQueue target, int value){
    if (value < 0) target->maxWait = 0;
    else  target->maxWait = value;
    check_flushing(target);
}

void rQ_add_request(ReqQueue target,Request request){
    if(max_capacity(target))
        rQ_increase_capacity(target);
    target->request[target->size] = clone_request(request);
    target->size++;
    free_request(request);
}

int get_pos_fromPid(ReqQueue target,int pid,int mode){ //0-worker, 1-client
    for(int aux = 0;aux < target->size;aux++){
        if(mode == 0 && get_pid_worker(target->request[aux]) == pid) return aux;
        else if (mode == 1 && get_pid_client(target->request[aux]) == pid) return aux;
    }
    return -1;
}

char* rQ_get_filters_fromWorker(ReqQueue target,int pid_worker){
    int pos = get_pos_fromPid(target,pid_worker,0);
    if(pos != -1){
        return get_filters(target->request[pos]);
    }
    return strdup("");
}

void rQ_remove_request_worker(ReqQueue target,int pid_worker){
    int pos = get_pos_fromPid(target,pid_worker,0);
    if(pos != -1) remove_request(target,pos);
}

void rQ_assign_worker(ReqQueue target,int pid_worker,int pid_client){
    int pos = get_pos_fromPid(target,pid_client,1);
    if(check_pos(target,pos)){
        set_pid_worker(target->request[pos],pid_worker);
    }
}


Request rQ_next_request(ReqQueue target,FilterList filterList){
    if(target->size){
        int pos = check_flushing(target);
        if(target->fluhsing){
            char* filt = get_filters(target->request[pos]);
            if(fL_filters_action(filterList,filt,1)){
                set_processing(target->request[pos]);
                rQ_incWaitLine_all(target);
                return clone_request(target->request[pos]);
            }
            else return NULL;
        }
        else{
            for(int aux = 0;aux < target->size;aux++){
                if(!processing(target->request[aux])){
                    char* filt = get_filters(target->request[aux]);
                    if(fL_filters_action(filterList,filt,1)){
                        set_processing(target->request[aux]);
                        rQ_incWaitLine_all(target);
                        return clone_request(target->request[aux]);
                    }
                }
            }
        }
    }
    return NULL;
}

char* rQ_toString(ReqQueue target){
    char* res = malloc(sizeof(char) * (128 + 256*target->size));
    res[0] = '\0';
    strcat(res,"Pedidos:\n");
    for(int aux = 0;aux < target->size;aux++){
        char* req = request_toString(target->request[aux]);
        strcat(res,req);
        free(req);
    }
    return res;
}

void free_RecQueue(ReqQueue target){
    for(int aux = 0; aux < target->size;aux++){
        free_request(target->request[aux]);
    }
    free(target->request);
    free(target);
}