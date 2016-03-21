git clone git://github.com/zsiciarz/aquila.git aquila-src && echo "Finished cloning the git repo for Aquila-DSP"
mkdir build && cd build
cmake ../aquila-src && make && sudo make install && sudo cp lib/libOoura_fft.a /usr/local/lib/ && echo "Copied libOoura_fft.a to /usr/local/lib"