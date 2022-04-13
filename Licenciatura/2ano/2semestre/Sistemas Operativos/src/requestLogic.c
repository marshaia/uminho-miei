/**
 * Data de Criação: 23/05/2021
 * Autor: Vicente Moreira
 * 
 * Código da estrutura de Requests. 
 * Este módulo armazena toda a informação necessária das queues
 */

#include "../includes/requestLogic.h"

struct request {
    int pid_client;       // Pid do Cliente que fez o pedido
    int pid_worker;       // Pid do Processo que irá fazer o pedido
    int waitLine;         // Tempo que está na fila. Este é incrementado sempre que algum elemento na fila (exceto ele próprio) é enviado para ser processado.
    int invalid;          // Validade: 0 - Válido / 1 - Inválido
    int processing;       // Se o pedido esta em processo
    int status;           // Se o pedido é um pedido de estado.
    char* input_file;     // Ficheiro de entrada.
    char* output_file;    // Ficheiro de saida.
    char* filters;        // Filtros pedidos. EX "alto eco"
};

Request new_request_empty(){
    Request new = malloc(sizeof(struct request));
    new->pid_client = 0;
    new->pid_worker = 0;
    new->waitLine = 0;
    new->invalid = 0;
    new->processing = 0;
    new->status = 0;
    new->input_file = NULL;
    new->output_file = NULL;
    new->filters = NULL;
    return new;
}

Request new_request_param(int pid_client,int pid_worker){
    Request new = new_request_empty();
    new->pid_client = pid_client;
    new->pid_worker = pid_worker;
    return new;
}

Request new_request_fromLine(char* line){
    char* fres = line;
    Request res = new_request_empty();
    int words_read = 0;
    int pid_client;
    char* arg = strsep(&line," ");
    while (arg && !res->invalid && !res->status){
        words_read++;
        switch (words_read){
        case 1:
            pid_client = atoi(arg);
            if(pid_client) res->pid_client = pid_client;                //Não existe PID 0
            else res->invalid = 1;
            break;
        
        case 2:
            if(strcmp(arg,"status") == 0) res->status = 1;
            else if (strcmp(arg,"transform") != 0) res->invalid = 1;    //Ou é Status ou transform
            break;

        case 3:
            res->input_file = strdup(arg);
            break;

        case 4:
            res->output_file = strdup(arg);
            break;

        case 5:
            init_req_filters(res);
            add_filter(res,arg);
            break;

        default:
            add_filter(res,arg);
            break;
        }

        arg = strsep(&line," ");
    }
    if ((res->status && words_read != 2) || (!res->status && words_read < 5)) res->invalid = 1;

    free(fres);
    return res;
}

void set_pid_client(Request target,int pid){target->pid_client = pid;}
void set_pid_worker(Request target,int pid){target->pid_worker = pid;}
void set_waitLine(Request target,int waitLine){target->waitLine = waitLine;}
void inc_waitLine(Request target){target->waitLine++;}
void set_invalid(Request target,int code){target->invalid = code;}
void set_valid(Request target){target->invalid = 0;}
void set_processing(Request target){target->processing = 1;}
void set_ReqisStatus(Request target){target->status = 1;}
void set_input_file(Request target,char* input_file){
    if(input_file){
        if(target->input_file) free(target->input_file);
        target->input_file = strdup(input_file);
    }
    else target->input_file = NULL;
    }
void set_output_file(Request target,char* output_file){
    if(output_file){
        if(target->output_file) free(target->output_file);
        target->output_file = strdup(output_file);
    }
    else target->output_file = NULL;
    }
void set_filters(Request target,char* filters){
    if(filters){
        if(target->filters) free(target->filters);
        target->filters = strdup(filters);
    }
    else target->filters = NULL;
    }


void init_req_filters(Request target){
    if(target->filters) free(target->filters);
    target->filters = malloc(sizeof(char));
    target->filters[0] = '\0';
}
void add_filter(Request target,char* filtro){
    if(!target->filters)init_req_filters(target);
    int size = 1+strlen(target->filters);
    target->filters = reallocarray(target->filters,sizeof(char),size+strlen(filtro));
    if(size != 1) strcat(target->filters," ");
    strcat(target->filters,filtro);
}

int get_pid_client(Request target){return target->pid_client;}
int get_pid_worker(Request target){return target->pid_worker;}
int get_waitLine (Request target){return target->waitLine;}
int get_invalid(Request target){return target->invalid;}
int processing(Request target){return target->processing;}
int get_isReqStatus(Request target){return target->status;}
int get_numberOfFilters(Request target){
    int res = 0;
    char* filters = strdup(target->filters);
    char* fres = filters;
    while(filters){
        strsep(&filters," ");
        res++;
    }
    free(fres);
    return res;
    }
char* get_input_file(Request target){
    if(target->input_file) return strdup(target->input_file);
    else return NULL;}
char* get_output_file(Request target){
    if(target->output_file) return strdup(target->output_file);
    else return NULL;}
char* get_filters(Request target){
    if(target->filters) return strdup(target->filters);
    else return NULL;}

char* request_toString(Request target){
    char* res = malloc(sizeof(char) * 256);
    if(get_isReqStatus(target)) {
        sprintf(res,"   Cliente: %d (Status)\n",target->pid_client);
        return res;
    }
    else sprintf(res,"   Cliente: %d |Input: %s |Output: %s |Filtros: %s |Estado: ",target->pid_client,target->input_file,target->output_file,target->filters);
    char* num = malloc(sizeof(char)*12);
    if(target->processing){
        sprintf(num,"%d",target->pid_worker);
        strcat(res,"Processing (Trabalhador: ");
    }
    else{
        sprintf(num,"%d",target->waitLine);
        strcat(res,"Em fila (WaitTime: ");
        
    }
    strcat(res,num);
    strcat(res,")\n");
    free(num);
    return res;
}

Request clone_request(Request target){
    Request clone = new_request_param(target->pid_client,target->pid_worker);
    clone->waitLine = target->waitLine;
    clone->invalid = target->invalid;
    clone->processing = target->processing;
    clone->status = target->status;
    set_input_file(clone,target->input_file);
    set_output_file(clone,target->output_file);
    set_filters(clone,target->filters);
    return clone;
}

void free_request(Request target){
    if(target->input_file)   free(target->input_file); 
    if(target->output_file)  free(target->output_file);
    if(target->filters)      free(target->filters);    
    free(target);
}
