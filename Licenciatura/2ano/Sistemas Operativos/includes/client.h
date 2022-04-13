/**
 * Data de Criação: 16/06/2021
 * Autor: Vicente Moreira
 * 
 * API do Client
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>

/**
 * Função sinalizadora (Terminar)
 */
void close_client(int signum);

/**
 * Função sinalizadora (Aprovado)
 */
void approved(int signum);

/**
 * Função sinalizadora (Não aprovado)
 */
void notApproved(int signum);

/**
 * Mostra o signifcado do estado
 * 0 - válido
 * 1 - Erro nos argumentos (geral)
 * 2 - 1 ou mais filtros não existem
 * 3 - Ficheiro de entrada inválido
 * 4 - Exec Error
 */
void display_status(int error);