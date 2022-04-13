Flags =  -std=c99 -O2 -D_POSIX_C_SOURCE -D_GNU_SOURCE -pedantic -pedantic-errors -Wall -Wextra -Wno-unused-variable -Wno-unused-but-set-variable 
CC = gcc

Sname = bin/aurrasd
Cname = bin/aurras

SCode = src/queueMGR.c src/filterMGR.c src/requestLogic.c src/server.c
CCode = src/client.c

SObjs = obj/queueMGR.o obj/filterMGR.o obj/requestLogic.o obj/server.o
CObjs = obj/client.o


all: 
	@echo Making all...
	@make servidor cliente
	@echo Done!

servidor: 
	@make servercompile serverlink
cliente: 
	@make clientcompile clientlink

serverlink: $(SObjs)
	@$(CC) $(SObjs) -o $(Sname)

servercompile: $(SCode)
	@$(CC) -c $(SCode) $(Flags) -lm
	@mkdir -p obj
	@mv ./*.o obj/

clientlink: $(CObjs)
	@$(CC) $(CObjs) -o $(Cname)

clientcompile: $(CCode)
	@$(CC) -c $(CCode) $(Flags) -lm
	@mkdir -p obj
	@mv ./*.o obj/

clean:
	@cat etc/secretAscii	
	@echo  
	@rm obj/*.o $(Sname) $(Cname)
	@echo All clean

test:
	bin/aurras
	bin/aurras status
	bin/aurras transform samples/sample-1.m4a output.m4a alto eco rapido