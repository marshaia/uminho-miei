NTIMES=100
POWERCAP=25

export POWERCAP



compile:
	chmod +x heapsortSmall.py
	chmod +x heapsortMedium.py
	chmod +x heapsortLarge.py
	chmod +x quicksortSmall.py
	chmod +x quicksortMedium.py
	chmod +x quicksortLarge.py
	chmod +x mergesortSmall.py
	chmod +x mergesortMedium.py
	chmod +x mergesortLarge.py
	


quickSortSmall: 
	sudo ../RAPL/main "quicksortSmall.py" $(NTIMES) $(POWERCAP)

quickSortMedium: 
	sudo ../RAPL/main "quicksortMedium.py" $(NTIMES) $(POWERCAP)

quickSortLarge: 
	sudo ../RAPL/main "quicksortLarge.py" $(NTIMES) $(POWERCAP)

quickSortAll:
	sudo ../RAPL/main "quicksortSmall.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "quicksortMedium.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "quicksortLarge.py" $(NTIMES) $(POWERCAP)



mergeSortSmall: 
	sudo ../RAPL/main "mergesortSmall.py" $(NTIMES) $(POWERCAP)

mergeSortMedium: 
	sudo ../RAPL/main "mergesortMedium.py" $(NTIMES) $(POWERCAP)

mergeSortLarge: 
	sudo ../RAPL/main "mergesortLarge.py" $(NTIMES) $(POWERCAP)

mergeSortAll:
	sudo ../RAPL/main "mergesortSmall.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "mergesortMedium.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "mergesortLarge.py" $(NTIMES) $(POWERCAP)



heapSortSmall:
	sudo ../RAPL/main "heapsortSmall.py" $(NTIMES) $(POWERCAP)

heapSortMedium:
	sudo ../RAPL/main "heapsortMedium.py" $(NTIMES) $(POWERCAP)

heapSortLarge:
	sudo ../RAPL/main "heapsortLarge.py" $(NTIMES) $(POWERCAP)

heapSortAll:
	sudo ../RAPL/main "heapsortSmall.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "heapsortMedium.py" $(NTIMES) $(POWERCAP)
	sudo ../RAPL/main "heapsortLarge.py" $(NTIMES) $(POWERCAP)


clean:
	rm -rf *.J *.txt
