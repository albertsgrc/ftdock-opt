all: fftw-old fftw ftdocks

fftw-old:
	cd ./original/lib/fftw-2.1.3 && env CFLAGS="-O3 -march=native" ./configure --prefix=$(PWD)/installation --enable-float && make && make install
fftw:
	cd ./optimizations/lib/fftw-3.3.4 && env CFLAGS="-O3 -march=native" ./configure --prefix=$(PWD)/installation --enable-float && make && make install
ftdocks:
	cd scripts && compile speedup
clean:
	cd scripts && clean
	cd ./original/lib/fftw-2.1.3 && make distclean
	cd ./optimizations/lib/fftw-3.3.4 && make distclean
