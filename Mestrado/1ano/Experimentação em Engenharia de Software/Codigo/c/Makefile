NTIMES=100
POWERCAP=25

export POWERCAP

compile:
	gcc -O2 -o mergesortSmall mergesortSmall.c 
	gcc -O2 -o mergesortMedium mergesortMedium.c 
	gcc -O2 -o mergesortLarge mergesortLarge.c 

	gcc -O2 -o quicksortSmall quicksortSmall.c 
	gcc -O2 -o quicksortMedium quicksortMedium.c 
	gcc -O2 -o quicksortLarge quicksortLarge.c

	gcc -O2 -o heapsortSmall heapsortSmall.c 
	gcc -O2 -o heapsortMedium heapsortMedium.c 
	gcc -O2 -o heapsortLarge heapsortLarge.c


mergeSortSmall:
	sudo ../RAPL/main "mergesortSmall" $(NTIMES) $(POWERCAP)

mergeSortMedium:
	sudo ../RAPL/main "mergesortMedium" $(NTIMES) $(POWERCAP)

mergeSortLarge:
	sudo ../RAPL/main "mergesortLarge" $(NTIMES) $(POWERCAP)



quickSortSmall: 
	sudo ../RAPL/main "quicksortSmall" $(NTIMES) $(POWERCAP)

quickSortMedium: 
	sudo ../RAPL/main "quicksortMedium" $(NTIMES) $(POWERCAP)

quickSortLarge: 
	sudo ../RAPL/main "quicksortLarge" $(NTIMES) $(POWERCAP)



heapSortSmall:
	sudo ../RAPL/main "heapsortSmall" $(NTIMES) $(POWERCAP)

heapSortMedium:
	sudo ../RAPL/main "heapsortMedium" $(NTIMES) $(POWERCAP)

heapSortLarge:
	sudo ../RAPL/main "heapsortLarge" $(NTIMES) $(POWERCAP)
	

clean:
	rm -rf *.txt heapsortSmall heapsortMedium heapsortLarge quicksortSmall quicksortMedium quicksortLarge mergesortSmall mergesortMedium mergesortLarge *.o *.J