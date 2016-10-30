#!/bin/sh


echo build tesseract 3.02
echo check tesseract-ocr @ github for detail


./autogen.sh
./configure --enable-debug
make
sudo make install
sudo ldconfig

make training
sudo make training-install
