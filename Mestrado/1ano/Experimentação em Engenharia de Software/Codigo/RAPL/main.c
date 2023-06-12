
/*
 *  Análise e Teste de Software
 *  João Saraiva 
 *  2016-2017
 */


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <math.h>
#include "rapl.h"
#include "../powercap/inc/powercap.h"
#include "../raplcap/inc/raplcap.h"

#define MAX_BUFFER_SIZE 256
#define RUNTIME



void getPackageTemp(float* temp){
    
    FILE *fp;
    char buffer[MAX_BUFFER_SIZE];
    float temp2;
    
    fp = popen("sensors | grep 'Package id 0:' | awk '{print $4}'", "r");
    if (fp == NULL) {
        printf("Error: Failed to execute command\n");
        exit(1);
    }
    
    fgets(buffer, MAX_BUFFER_SIZE, fp);
    pclose(fp);
    
    sscanf(buffer, "%f", &temp2);
    *temp = temp2;
}


void write_temperature(FILE* fp){

    float temp;
    getPackageTemp(&temp);
    fprintf(fp,"%.2f , ",temp);                         // Temperature of Package

}




void writePhysicalMemory(FILE * memoryfp, FILE *fp){

  int num = 0;

  if (memoryfp == NULL) {
        printf("Failed to open file.\n");
        return 1;
  }

  if (fscanf(memoryfp, "%d,", &num) != 1) {
        printf("Failed to read value from file.\n");
        return;
  }

  fprintf(fp,"%d , ",num);
  
}



void setPowerCap(int cap){

  raplcap rc;
    raplcap_limit rl_short, rl_long;
    uint32_t i, j, n, d;

    // get the number of RAPL packages
    n = raplcap_get_num_packages(NULL);
    if (n == 0) {
        perror("raplcap_get_num_packages");
        return -1;
    }

    // initialize
    if (raplcap_init(&rc)) {
        perror("raplcap_init");
        return -1;
    }

    // assuming each package has the same number of die, only querying for package=0
    d = raplcap_get_num_die(&rc, 0);
    if (d == 0) {
        perror("raplcap_get_num_die");
        raplcap_destroy(&rc);
        return -1;
    }

    // for each package die, set a power cap of 100 Watts for short_term and 50 Watts for long_term constraints
    // a time window of 0 leaves the time window unchanged
    rl_short.watts = cap;
    rl_short.seconds = 0.0;
    rl_long.watts = cap;
    rl_long.seconds = 0.0;
    for (i = 0; i < n; i++) {
        for (j = 0; j < d; j++) {
            if (raplcap_pd_set_limits(&rc, i, j, RAPLCAP_ZONE_PACKAGE, &rl_long, &rl_short)) {
                perror("raplcap_pd_set_limits");
            }
        }
    }

    // for each package die, enable the power caps
    // this could be done before setting caps, at the risk of enabling unknown power cap values first
    for (i = 0; i < n; i++) {
        for (j = 0; j < d; j++) {
            if (raplcap_pd_set_zone_enabled(&rc, i, j, RAPLCAP_ZONE_PACKAGE, 1)) {
                perror("raplcap_pd_set_zone_enabled");
            }
        }
    }

    // cleanup
    if (raplcap_destroy(&rc)) {
        perror("raplcap_destroy");
    }

}




int main (int argc, char **argv) {
  char command[500],res[500], memoryFileName[500];
  int  ntimes = 1;
  int  core = 0;
  int  k=0;

#ifdef RUNTIME
  clock_t begin, end;
  double time_spent;

  struct timeval tvb,tva;
  
#endif
  
  FILE * fp;

  strcat(command,argv[1]);
  strcpy(command, "./" );
  strcat(command,argv[1]);

  ntimes = atoi (argv[2]);

  strcpy(res,command);
  strcat(res,".J");
  printf("Command: %s  %d-times res: %s\n",command,ntimes,res);
  


  fp = fopen(res,"w");
  rapl_init(core);


  strcpy(memoryFileName,command);
  strcat(memoryFileName,".txt");

  FILE* memoryfp = fopen(memoryFileName,"w+");

  float temp;

  
  for (k = 0 ; k < ntimes ; k++){

        setPowerCap( atoi(argv[3]) );

        getPackageTemp(&temp);
        
        while(temp > 55.0){   // em repouso: 45ºC
          getPackageTemp(&temp);
          sleep(1);
        }

        fprintf(fp,"%s , ",argv[1]);

        int len = strlen(argv[1]);
    
        if(strstr(argv[1], ".py") != NULL)
          fprintf(fp,"python , ");
        else
          fprintf(fp,"c , ");

        fprintf(fp,"%d, ", atoi(argv[3]));

        /* Tamanho das listas a ordenar*/

        if(strstr(argv[1], "Small") != NULL)   
          fprintf(fp,"0 , ");
        else if (strstr(argv[1], "Medium") != NULL)
              fprintf(fp,"1 , ");
              else fprintf(fp,"2 , ");

        write_temperature(fp);
        
        rapl_before(fp,core);
      
        #ifdef RUNTIME
          begin = clock();
          gettimeofday(&tvb, 0);
        #endif
          system(command);
          writePhysicalMemory(memoryfp,fp);

        #ifdef RUNTIME
          end = clock();
          gettimeofday(&tva, 0);
          //	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
          time_spent = (tva.tv_sec-tvb.tv_sec)*1000000 + tva.tv_usec-tvb.tv_usec;
        #endif

          rapl_after(fp,core);
          write_temperature(fp);
          write_cost_to_develop(fp,command,argv[1]);

        #ifdef RUNTIME	
          fprintf(fp," %G \n",time_spent);
        #endif
    }
    
  printf("\n\n END of PARAMETRIZED PROGRAM: \n");

  // if (raplcap_destroy(&rc)) {
  //   perror("raplcap_destroy");
  // }

  fclose(fp);
  fflush(stdout);

  return 0;
}

void changeCommaToDot(char* word){
  for (int i = 0; word[i] != '\0'; i++) {
    if (word[i] == ',') {
        word[i] = '.';
    }
}
}


void write_cost_to_develop(FILE* fpWrite, char* fullCommand, char* arg){

    char command[500] = "sloccount ";
    char smallCommand[500] = "";
    char output[3024];
    char cost_to_develop[50];

    strcpy(smallCommand, &fullCommand[2]); //  "/heapsortSmall"
    strcat(command,smallCommand);

    if(strstr(arg, ".py") != NULL) strcat(command,"");
    else strcat(command,".c");

    FILE* fp = popen(command, "r");

    if (fp == NULL) {
        printf("Failed to run command\n");
        exit(1);
    }

    while(fgets(output, sizeof(output)-1, fp)>0){
    
      char* cost_str = strstr(output, "Total Estimated Cost to Develop");
      if (cost_str != NULL) {
          sscanf(cost_str, "Total Estimated Cost to Develop = $ %s", &cost_to_develop);
          changeCommaToDot(&cost_to_develop);
          fprintf(fpWrite,"%s ,",cost_to_develop);
      }
    }


    // Close the command
    pclose(fp);

}

