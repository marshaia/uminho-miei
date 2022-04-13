/**
 * Data de Criação: 22/05/2021
 * Autor: Vicente Moreira
 * 
 * Api do Queue Manager. 
 * Este é responsável pelo tratamento de dados e organização
 * da fila dos pedidos que o servirdor receber.
 */

#include <stdlib.h>
#include <string.h>
#include "filterMGR.h"
#include "requestLogic.h"


typedef struct reqQueue* ReqQueue;

ReqQueue new_ReqQueue_empty();

/**
 * Incrementa a linha de espera em todos os pedidos
 */
void rQ_incWaitLine_all(ReqQueue target);

/**
 * Define o valor máximo de espera de pedidos
 */
void rQ_set_maxWait(ReqQueue target, int value);

/**
 * Adiciona um pedido numa fila
 */
void rQ_add_request(ReqQueue target,Request request);

/**
 * Vais buscar os filtros de um request dado o worker
 */
char* rQ_get_filters_fromWorker(ReqQueue target,int pid_worker);

/**
 * Remove um pedido da fila, dado o trabalhador
 */
void rQ_remove_request_worker(ReqQueue target,int pid_worker);

/**
 * Atribui um trabalhador a um pedido
 */
void rQ_assign_worker(ReqQueue target,int pid_worker,int pid_client);

/**
 * Consulta a fila e devolve o próximo elemento a ser processado
 */
Request rQ_next_request(ReqQueue target,FilterList filterList);

/**
 * Função toString
 */
char* rQ_toString(ReqQueue target);

/**
 * Função free
 */
void free_RecQueue(ReqQueue target);
