POWERCAP=10

DIR_C=c
DIR_PYTHON=python
DIR_RAPL=RAPL


RAPL:
	cd ./$(DIR_RAPL) && make

mergeSortSmall:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortSmall POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make mergeSortSmall POWERCAP=$(POWERCAP)

mergeSortMedium:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortMedium POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make mergeSortMedium POWERCAP=$(POWERCAP)

mergeSortLarge:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortLarge POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make mergeSortLarge POWERCAP=$(POWERCAP)



quickSortSmall:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortSmall POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make quickSortSmall POWERCAP=$(POWERCAP)

quickSortMedium:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortMedium POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make quickSortMedium POWERCAP=$(POWERCAP)

quickSortLarge:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortLarge POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make quickSortLarge POWERCAP=$(POWERCAP)



heapSortSmall:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortSmall POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make heapSortSmall POWERCAP=$(POWERCAP)

heapSortMedium:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortMedium POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make heapSortMedium POWERCAP=$(POWERCAP)

heapSortLarge:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortLarge POWERCAP=$(POWERCAP)
	cd ./$(DIR_PYTHON) && make compile && make heapSortLarge POWERCAP=$(POWERCAP)


# -------------------------------- No PowerCap -----------------------------------#

mergeSortSmallNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortSmall
	cd ./$(DIR_PYTHON) && make compile && make mergeSortSmall

mergeSortMediumNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortMedium
	cd ./$(DIR_PYTHON) && make compile && make mergeSortMedium

mergeSortLargeNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make mergeSortLarge
	cd ./$(DIR_PYTHON) && make compile && make mergeSortLarge


quickSortSmallNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortSmall
	cd ./$(DIR_PYTHON) && make compile && make quickSortSmall

quickSortMediumNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortMedium
	cd ./$(DIR_PYTHON) && make compile && make quickSortMedium

quickSortLargeNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make quickSortLarge
	cd ./$(DIR_PYTHON) && make compile && make quickSortLarge


heapSortSmallNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortSmall
	cd ./$(DIR_PYTHON) && make compile && make heapSortSmall

heapSortMediumNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortMedium
	cd ./$(DIR_PYTHON) && make compile && make heapSortMedium

heapSortLargeNoPowerCap:
	cd ./$(DIR_RAPL) && make
	cd ./$(DIR_C) && make compile && make heapSortLarge
	cd ./$(DIR_PYTHON) && make compile && make heapSortLarge




allSmall: 
	$(MAKE) RAPL 
	$(MAKE) mergeSortSmall 
	$(MAKE) quickSortSmall 
	$(MAKE) heapSortSmall 
	$(MAKE) concatFilesPowerCap
	$(MAKE) mergeSortSmallNoPowerCap 
	$(MAKE) quickSortSmallNoPowerCap 
	$(MAKE) heapSortSmallNoPowerCap 
	$(MAKE) concatFilesNoPowerCap
	$(MAKE) concatFinalSmall

allMedium: 
	$(MAKE) RAPL 
	$(MAKE) mergeSortMedium 
	$(MAKE) quickSortMedium 
	$(MAKE) heapSortMedium
	$(MAKE) concatFilesPowerCap
	$(MAKE) mergeSortMediumNoPowerCap 
	$(MAKE) quickSortMediumNoPowerCap 
	$(MAKE) heapSortMediumNoPowerCap 
	$(MAKE) concatFilesNoPowerCap
	$(MAKE) concatFinalMedium

allLarge: 
	$(MAKE) RAPL 
	$(MAKE) heapSortLarge
	$(MAKE) mergeSortLarge 
	$(MAKE) quickSortLarge 
	$(MAKE) concatFilesPowerCap
	$(MAKE) mergeSortLargeNoPowerCap 
	$(MAKE) quickSortLargeNoPowerCap 
	$(MAKE) heapSortLargeNoPowerCap 
	$(MAKE) concatFilesNoPowerCap
	$(MAKE) concatFinalLarge


all: 
	$(MAKE) clean
	$(MAKE) allSmall
	$(MAKE) cleanJfiles
	$(MAKE) allMedium 
	$(MAKE) cleanJfiles
	$(MAKE) allLarge
	$(MAKE) finalConcat



concatFilesPowerCap:
	cat ./c/*.J ./python/*.J > mergedPowerCap.csv

concatFilesNoPowerCap:
	cat ./c/*.J ./python/*.J > mergedNoPowerCap.csv


concatFinalSmall:
	cat mergedPowerCap.csv mergedNoPowerCap.csv > mergedSmall.csv

concatFinalMedium:
	cat mergedPowerCap.csv mergedNoPowerCap.csv > mergedMedium.csv

concatFinalLarge:
	cat mergedPowerCap.csv mergedNoPowerCap.csv > mergedLarge.csv

finalConcat:
	cat header.csv mergedSmall.csv mergedMedium.csv mergedLarge.csv > merged.csv



cleanJfiles:
	cd ./$(DIR_C) && make clean
	cd ./$(DIR_PYTHON) && make clean

cleanIntermedios:
	rm -rf mergedLarge.csv mergedMedium.csv mergedSmall.csv mergedPowerCap.csv mergedNoPowerCap.csv


clean:
	$(MAKE) cleanJfiles
	$(MAKE) cleanIntermedios