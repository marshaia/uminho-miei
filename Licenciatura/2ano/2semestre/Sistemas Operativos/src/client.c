/**
 * Data de Criação: 15/06/2021
 * Autor: Vicente Moreira
 * Autor: Joana Alves
 * 
 * Código principal do cliente
 */

#include "../includes/client.h"

#define CommandSize 256
#define RDSTATUSSIZE 1024
#define AddSpace strcat(request," ")

int request_approved = 1;
int terminate = 0;
char* myfifo;

void close_client(int signum){
    (void) signum;
    unlink(myfifo);
    terminate = 1;
}

void approved(int signum){
    (void) signum;
    request_approved = 1;
}

void notApproved(int signum){
    (void) signum;
    request_approved = 0;
}

void display_status(int error){
    /*
    0 - válido
    1 - Erro nos argumentos (geral)
    2 - 1 ou mais filtros não existem
    3 - Ficheiro de entrada inválido
    4 - Exec Error
    */
    switch (error){
    case 0:
        printf("CLIENT: Comando efetuado com sucesso!\n");
        break;
    case 1:
        printf("CLIENT: Erro %d: Erro nos argumentos (geral)\n",error);
        break;
    case 2:
        printf("CLIENT: Erro %d: 1 ou mais filtros não existem\n",error);
        break;
    case 3:
        printf("CLIENT: Erro %d: Ficheiro de entrada inválido\n",error);
        break;
    case 4:
        printf("CLIENT: Erro %d: Execução deu erro\n",error);
        break;
    default:
        printf("CLIENT: Erro %d: Idk whats this...\n",error);
        break;
    }
}

int main(int argc,char** argv){

    //-----------------------------------------------INICIALIZAÇÃO-----------------------

    if(argc != 2 && argc < 5){
        printf("CLIENT: Invalid Number of arguments. Exiting\n");
        return -1;
    }
    if(  (argc == 2 && strcmp(argv[1],"status")    != 0) || 
         (argc >= 5 && strcmp(argv[1],"transform") != 0) ){
        printf("CLIENT: Comando inválido. Exiting\n");
        return -1;
    }


    int fdWrite = open("master",O_RDWR); 
    int fdRead = open("server_pid",O_RDWR);
    if(!fdWrite || !fdRead){
        perror("open");
        return -1;
    }
    signal(SIGUSR1,approved);
    signal(SIGUSR2,notApproved);
    signal(SIGINT,close_client);

    //------------------------------------------------MONTA REQUEST-------------------------------

    char* request = malloc(sizeof(char) * CommandSize);
    request[0] = '\0';
    int pid_client = getpid();
    myfifo = malloc(sizeof(char)*12);
    sprintf(myfifo,"%d",pid_client);
    strcat(request,myfifo);
    AddSpace;
    for(int aux = 1;aux < argc;aux++){
        strcat(request,argv[aux]);
        if(aux+1 < argc) AddSpace;
    }

    //------------------------------------------------COMUNICACAO---------------------------------

    int server_pid;
    if(read(fdRead,&server_pid,sizeof(int))){};

    kill(server_pid,SIGUSR1);

    if(write(fdWrite,request,CommandSize)){};
    printf("CLIENT: Request Sent\n");
    pause();
    if(terminate) return -1;

    if(!request_approved){
        printf("CLIENT: Request was not read/approved\n");
        return -1;
    }
    else printf("CLIENT: Request was approved. Now pending...\n");

    //-------------------------------------------COMUNICACAO WORKER--------------------------------

    if(mkfifo(myfifo,0666) == -1){    //Worker -> Client
        perror("mkfifo");
        return -1;
    }
    int fdComms = open(myfifo,O_RDWR);
    if(!fdComms){
        perror("open");
        return -1;
    }
    pause();
    if(terminate) return -1;

    int status;
    if(!request_approved){
        if(read(fdComms,&status,sizeof(int))){};
        display_status(status);
    }
    else if(strcmp(argv[1],"status") == 0){
        char* rdstatus = malloc(sizeof(char) * RDSTATUSSIZE);
        int bytes_read;
        do{
            bytes_read = read(fdComms,rdstatus,RDSTATUSSIZE);
            if(write(1,rdstatus,bytes_read)){};
        } while(bytes_read == RDSTATUSSIZE);
    }
    else{
        printf("CLIENT: Processing...\n");
        pause();
        if(terminate) return -1;
        if(read(fdComms,&status,sizeof(int))){};
        display_status(status);
    }

    printf("CLIENT: Exiting...\n");
    unlink(myfifo);

}