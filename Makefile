CURR_DIR=$(PWD)

all: fftw-old fftw ftdocks optim

fftw-old:
	cd ./original/lib/fftw-2.1.3 && echo $(CURR_DIR)/original/lib/fftw-2.1.3/installation && env CFLAGS="-O3 -march=native" ./configure --prefix=$(CURR_DIR)/original/lib/fftw-2.1.3/installation --enable-float && make && make install
fftw:
	cd ./optimizations/lib/fftw-3.3.4 && env CFLAGS="-O3 -march=native" ./configure --prefix=$(CURR_DIR)/optimizations/lib/fftw-3.3.4/installation --enable-float && make && make install
ftdocks:
	cd scripts-js && ./compile speedup
optim:
	cd scripts/optim && make
	cd scripts-js/optim && make
clean:
	cd scripts-js && ./clean -u
	cd ./original/lib/fftw-2.1.3 && make distclean
	cd ./optimizations/lib/fftw-3.3.4 && make distclean
	cd scripts/optim && make clean
	cd scripts-js/optim && make clean
