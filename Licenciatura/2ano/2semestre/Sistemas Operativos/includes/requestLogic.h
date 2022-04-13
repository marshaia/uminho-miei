/**
 * Data de Criação: 23/05/2021
 * Autor: Vicente Moreira
 * 
 * API da estrutura de Requests. 
 * Este módulo armazena toda a informação necessária das queues
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef struct request* Request;


Request new_request_empty();

Request new_request_param(int pid_client,int pid_worker);

Request new_request_fromLine(char* line);

void set_pid_client(Request target,int pid);
void set_pid_worker(Request target,int pid);
void set_waitLine(Request target,int waitLine);
void inc_waitLine(Request target);
/**
 * 0 - válido
 * 1 - Erro nos argumentos (geral)
 * 2 - 1 ou mais filtros não existem
 * 3 - Ficheiro de entrada inválido
 * 4 - Exec Error
 */
void set_invalid(Request target,int code);
void set_valid(Request target);
void set_processing(Request target);
void set_isReqStatus(Request target);
void set_input_file(Request target,char* input_file);
void set_output_file(Request target,char* output_file);
void set_filters(Request target,char* filters);

void init_req_filters(Request target);
void add_filter(Request target,char* filtro);

int get_pid_client(Request target);
int get_pid_worker(Request target);
int get_waitLine (Request target);
/**
 * 0 - válido
 * 1 - Erro nos argumentos (geral)
 * 2 - 1 ou mais filtros não existem
 * 3 - Ficheiro de entrada inválido
 * 4 - Exec Error
 */
int get_invalid(Request target);
int processing(Request target);
int get_isReqStatus(Request target);
int get_numberOfFilters(Request target);
char* get_input_file(Request target);
char* get_output_file(Request target);
char* get_filters(Request target);

char* request_toString(Request target);

Request clone_request(Request target);

void free_request(Request target);