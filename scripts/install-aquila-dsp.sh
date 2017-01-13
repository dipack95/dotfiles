git clone git://github.com/zsiciarz/aquila.git aquila-src && echo "Finished cloning the git repo for Aquila-DSP"
echo "Build static library"
mkdir build_static && cd build_static
cmake ../aquila-src && make && sudo make install && sudo cp lib/libOoura_fft.* /usr/local/lib/ && echo "Copied libOoura_fft.a to /usr/local/lib"
cd ..
echo "Build dynamic library"
mkdir build_dynamic && cd build_dynamic
cmake ../aquila-src -DBUILD_SHARED_LIBS=True && make && sudo make install && sudo cp lib/libOoura_fft.* /usr/local/lib/ && echo "Copied libOoura_fft.so to /usr/local/lib"