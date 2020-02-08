@echo on

git clone git://code.qt.io/qt/qt5.git
cd %CD%\qt5
git checkout -t origin/5.14.1
git submodule update --init --recursive

mkdir qtbuild
cd %CD%\qtbuild

set OPENSSL_LIBS='-LC:\msys64\mingw64\lib -llibssl -llibcrypto'
..\configure -prefix C:\Qt\5.13.0 -opensource -confirm-license -platform win32-g++ -c++std c++1z -release -shared -strip -opengl desktop -openssl-linked -no-icu -no-iconv -no-angle -no-dbus -nomake tools -nomake examples -nomake tests -skip qtwebengine -skip qtmultimedia -qt-zlib -qt-libpng -qt-libjpeg

REM mingw32-make -j8
REM mingw32-make install

REM echo pause
