/**
 * Data de Criação: 16/06/2021
 * Autor: Vicente Moreira
 * 
 * API do server
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>
#include "../includes/queueMGR.h"

/**
 * Função sinalizadora (Terminar)
 */
void action_terminate(int signum);

/**
 * Função sinalizadora (Novo cliente)
 * Lê o pipe master e interpreta o pedido, se for inválido ou "Status" processa-o
 * Senão adiciona à fila para processamento.
 */
void new_client(int signum);

/**
 * Executa o próximo pedido
 */
void next_request();

/**
 * Executa o request fornecido
 */
int execute_request(Request req);

/**
 * Executa o comando "transform"
 */
int execute_transform(Request req);

/**
 * Devolve o estado do servidor
 */
char* get_server_status();

/**
 * Termina o request, Limpa a fila
 */
void conclude_request(int pid_worker,int status);