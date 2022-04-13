/**
 * Data de Criação: 02/06/2021
 * Autor: Vicente Moreira
 * Autor: Joana Alves
 * 
 * Código principal do servidor
 */

#include "../includes/server.h"

#define CommandSize 256
#define Write_my_pid_onFifo if(write(fdWritePid,&server_pid,sizeof(int))){}

FilterList filters;
ReqQueue queue;
int server_pid;
int fdEntry;
int fdWritePid;
int fdReadPid;
int ongoing_processes; 
int terminate;

void action_terminate(int signum){
    (void) signum;
    printf("SERVER: TIME TO CLOSE DOWN!\n");
    terminate = 1;
}

void new_client(int signum){
    (void) signum;
    printf("SERVER: New Client! \n");
    char* buff = malloc(sizeof(char)*CommandSize);
    if(read(fdEntry,buff,CommandSize) <= 0) printf("Mandaram-me sinal de novo cliente. Mas ninguém escreveu no pipe?\n");
    Request new_req = new_request_fromLine(buff);

    if(terminate){
        printf(" Unfortunately i have to ingore him...\n");
        kill(get_pid_client(new_req),SIGUSR2);
        return;
    }

    kill(get_pid_client(new_req),SIGUSR1);  //Informa o cliente que já leu o seu pedido.

    //VERIFICA A VALIDADE
    if(!get_isReqStatus(new_req)){
        if(!fL_filters_action(filters,get_filters(new_req),0)) set_invalid(new_req,2);
        if(access(get_input_file(new_req),F_OK) == -1) set_invalid(new_req,3);
    }
    
    //SE FOR INVALIDO OU "STATUS" ENVIA PARA PROCESSAMENTO
    if(get_invalid(new_req) || get_isReqStatus(new_req)) set_processing(new_req);
    rQ_add_request(queue,clone_request(new_req));
    if(get_invalid(new_req) || get_isReqStatus(new_req)){
        int pid_client = get_pid_client(new_req);
        int pid_worker = execute_request(new_req);
        rQ_assign_worker(queue,pid_worker,pid_client);
        }
    else next_request();

    printf("SERVER: New Client done processing\n");
    Write_my_pid_onFifo;
}

void next_request(){
    Request req = rQ_next_request(queue,filters);
    if(req == NULL){
        printf("SERVER: Nenhum request pronto a ser executado ou à espera de filtros\n");
        return;
    }
    int pid_client = get_pid_client(req);
    char* filters_used = get_filters(req);
    fL_filters_action(filters,filters_used,2);
    int pid_worker = execute_request(req);
    rQ_assign_worker(queue,pid_worker,pid_client);
    printf("SERVER: Request sent for processing (Client: %d, Worker: %d)\n",pid_client,pid_worker);
}


int execute_request(Request req){
    int pid_worker;
    ongoing_processes++;
    if((pid_worker = fork()) == 0){
        char* path = malloc(sizeof(char) *12);   //MAX 11 algarismos
        sprintf(path,"%d",get_pid_client(req)); 

        int fdWrite = open(path,O_RDWR);  //O cliente faz o pipe Worker->Client
        free(path);

        if(get_invalid(req)){
            int invCode = get_invalid(req);
            if(write(fdWrite,&invCode,sizeof(int))){};
            kill(get_pid_client(req),SIGUSR2);
            close(fdWrite);
            _exit(0);
        }            
        
        if(get_isReqStatus(req)){
            char* status = get_server_status();
            if(write(fdWrite,status,strlen(status)+1)){};
            kill(get_pid_client(req),SIGUSR1);
            free(status);
            close(fdWrite);
            _exit(0);
        }

        kill(get_pid_client(req),SIGUSR1);
        int res = execute_transform(req);
        if(write(fdWrite,&res,sizeof(int))){};
        kill(get_pid_client(req),SIGUSR1);
        close(fdWrite);
        _exit(0);

    }

    free_request(req);
    return pid_worker;
}

int execute_transform(Request req){
    int aux= 0;
    int num_filters = get_numberOfFilters(req);

    char* input = get_input_file(req);
    int fdinput = open(input,O_RDONLY,0444);

    char* output = get_output_file(req);
    int fdoutput = open(output,O_CREAT|O_TRUNC|O_RDWR,0666);

    char** execNames = malloc(sizeof(char*) * num_filters);
    char* allFilters = get_filters(req);
    do{
        char* filter = strsep(&allFilters," ");
        execNames[aux++] = fL_get_filterExec(filters,filter);
    }while (allFilters);

    int error = 0;

    if(num_filters == 1){
        if(fork() == 0){
            dup2(fdinput,0);
            dup2(fdoutput,1);
            execl(execNames[0],execNames[0],NULL);
            _exit(4);
        }
        wait(&error);
    }
    else {
        int pipes[num_filters-1][2];
        for(int aux = 0;aux < num_filters;aux++){
            if(aux == 0){
                if(pipe(pipes[aux]) != 0) return 4;
                switch (fork()){
                    case -1: 
                        return 4;
                    case 0:
                        close(pipes[aux][0]);
                        dup2(pipes[aux][1],1);
                        close(pipes[aux][1]);
                        dup2(fdinput,0);
                        execl(execNames[aux],execNames[aux],NULL);
                        _exit(4);
                        break;
                    default:
                        close(pipes[aux][1]);
                        break;
                }

            }
            else if(aux == num_filters-1){
                switch (fork()){
                case -1: 
                    return 4;
                case 0:
                    dup2(pipes[aux-1][0],0);
                    close(pipes[aux-1][0]);
                    dup2(fdoutput,1);
                    execl(execNames[aux],execNames[aux],NULL);
                    _exit(4);
                    break;
                default:
                    close(pipes[aux-1][0]);
                    break;
                }
            }
            else{
                if(pipe(pipes[aux]) != 0) return 4;
                switch (fork()){
                case -1: 
                    return 4;
                case 0:
                    close(pipes[aux][0]);

                    dup2(pipes[aux][1],1);
                    close(pipes[aux][1]);

                    dup2(pipes[aux-1][0],0);
                    close(pipes[aux-1][0]);

                    execl(execNames[aux],execNames[aux],NULL);
                    _exit(4);
                    break;
                default:
                    close(pipes[aux][1]);
                    close(pipes[aux-1][0]);
                    break;
                }
            }
        }   
        for(int aux =0 ;aux<num_filters;aux++){
            int errorFork;
            wait(&errorFork);
            if(errorFork != 0) error = errorFork;
        } 
    }

    

    close(fdinput);close(fdoutput);
    free(allFilters);
    for(int aux =0 ;aux<num_filters;aux++) free(execNames[aux]);
    free(execNames);

    return error;
}

char* get_server_status(){
    //Servidor PID: XXXX
    //Filtros:
    //  alto (blablabla): Using 2 from Max 4
    //  baixo (blablabla): Using 1 from Max 1
    //Pedidos: ???
    //  Cliente: XXXX |Input: XXXXXXXXXXXXXXX | Output: XXXXXXXXXXXXX | Filtros: XXXXX XXXXXX XXXXX | Estado: Em fila
    //  Cliente: XXXX |Input: XXXXXXXXXXXXXXX | Output: XXXXXXXXXXXXX | Filtros: XXXXX XXXXXX XXXXX | Estado: Em fila (Alto prioridade)
    //  Cliente: XXXX |Input: XXXXXXXXXXXXXXX | Output: XXXXXXXXXXXXX | Filtros: XXXXX XXXXXX XXXXX | Estado: Processando (Trabalhador XXXX)
    char* titulo = malloc(sizeof(char)*28);
    sprintf(titulo,"Servidor PID: %d\n",server_pid);
    int tam_titulo = strlen(titulo);

    char* filtros = fL_toString(filters);
    int tam_filters = strlen(filtros);

    char* pedidos = rQ_toString(queue);
    int tam_pedidos = strlen(pedidos);

    int size = tam_titulo + tam_filters + tam_pedidos + 8;
    char* res=malloc(sizeof(char)*size);
    res[0]='\0';
    strcat(res,titulo);
    strcat(res,filtros);
    strcat(res,pedidos);

    free(titulo);free(filtros);free(pedidos);

    return res;
}

void conclude_request(int pid_worker,int status){
    ongoing_processes--;
    char* filters_used = rQ_get_filters_fromWorker(queue,pid_worker);
    fL_filters_action(filters,filters_used,3);
    rQ_remove_request_worker(queue,pid_worker);
    if(WEXITSTATUS(status) == -1)
        printf("SERVER: ERRO COM O CLIENTE %d (MKFIFO FALHOU)\n",pid_worker);

    printf("SERVER: Worker %d done\n",pid_worker);
}










int main(int argc,char** argv){

    //--------------------------------------------CONFIGURAÇÃO INICIAL--------------------------------------
    if(argc != 3){
        printf("SERVER: Número de argumentos inválidos\n");
        return -1;
    }

    printf("SERVER: Inicializando!\n");
    server_pid = getpid();

    unlink("master");
    unlink("server_pid");
    //Criação dos FIFOS
    if(mkfifo("master",0666) == -1){      //Client -> Server
        perror("mkfifo");
        unlink("master");
        return -1;
    }
    if(mkfifo("server_pid",0666) == -1){  //Server -> Client
        perror("mkfifo");
        unlink("master");
        unlink("server_pid");
        return -1;
    }

    //Abre os FIFOS
    fdEntry = open("master",O_RDWR);
    fdWritePid = open("server_pid",O_RDWR);
    fdReadPid = open("server_pid",O_RDWR);
    if(!fdEntry || !fdWritePid || !fdReadPid){
        perror("open");
        return -1;
    }
    filters = fL_load_FilterList_fromFile(argv[1]);
    queue = new_ReqQueue_empty();   
    if(!filters || !queue){
        printf("SERVER: Config path inválido\n");
        return -1;
    }
    fL_set_filterFolder(filters,argv[2]);

    signal(SIGUSR1,new_client);
    signal(SIGINT,action_terminate);
    signal(SIGTERM,action_terminate);
    ongoing_processes = 0;

    Write_my_pid_onFifo;
    //--------------------------------------------FIM CONFIGURAÇÃO--------------------------------------


    //------------------------------------------------SERVER LOOP---------------------------------------
    int status;
    int pid_worker;
    terminate = 0;

    while(!terminate){
        while(ongoing_processes > 0){
            printf("SERVER: Waiting for processes\n");
            pid_worker = wait(&status);
            conclude_request(pid_worker,status);
            next_request();
        }
        if(!terminate){
            printf("SERVER: All jobs done, entering sleep mode.\n");
            sleep(60);
        }
    }
    //------------------------------------------------FIM SERVER------------------------------------------

    //---------------------------------------------TERMINAR O SERVER--------------------------------------
    close(fdEntry);
    close(fdWritePid);
    close(fdReadPid);
    unlink("master");
    unlink("server_pid");
    free_FilterList(filters);
    free_RecQueue(queue);

    printf("SERVER: BYE BYE :-)\n");
    return 0;
}
