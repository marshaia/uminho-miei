
LDFLAGS = /usr/local/lib/libraplcap-msr.a

main : main.c rapl.o
	gcc -O2 -o main main.c rapl.o -lm $(LDFLAGS) 
	chmod 777 main

rapl.o : rapl.c rapl.h
	gcc -O2 -c rapl.c -lm $(LDFLAGS) 

clean:
	rm -rf main.o rapl.o main