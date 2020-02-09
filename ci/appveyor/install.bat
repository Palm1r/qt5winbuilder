@echo off

cd %APPVEYOR_BUILD_FOLDER%

echo Compiler: %COMPILER%
echo Architecture: %MSYS2_ARCH%
echo Platform: %PLATFORM%
echo MSYS2 directory: %MSYS2_DIR%
echo MSYS2 system: %MSYSTEM%
echo Configuration: %CONFIGURATION%
echo Bits: %BIT%

IF %COMPILER%==msys2 (
  @echo on
  SET "PATH=C:\%MSYS2_DIR%\%MSYSTEM%\bin;C:\%MSYS2_DIR%\usr\bin;%PATH%"
  bash -lc "pacman --noconfirm --sync pacman-mirrors"
  bash -lc "pacman -S --needed --noconfirm git"
  bash -lc "pacman -S --needed --noconfirm mingw-w64-x86_64-gcc"
  bash -lc "pacman -S --needed --noconfirm mingw-w64-x86_64-toolchain mingw-w64-x86_64-make"
  bash -lc "pacman -S --needed --noconfirm openssl"
  
  git clone git://code.qt.io/qt/qt5.git
  cd %CD%\qt5
  git checkout -t origin/5.14.1
  git submodule update --init --recursive
  
  SET OPENSSL_LIBS='-LC:\%MSYS2_DIR%\%MSYSTEM%\lib -llibssl -llibcrypto'
  
  mkdir qtbuild
  cd %CD%\qtbuild
  
  %APPVEYOR_BUILD_FOLDER%\qt5\configure -prefix  -opensource -confirm-license -platform win32-g++ -c++std c++1z -release -shared -strip -opengl desktop -openssl-linked -no-icu -no-iconv -no-angle -no-dbus -nomake tools -nomake examples -nomake tests -skip qtwebengine -skip qtmultimedia -qt-zlib -qt-libpng -qt-libjpeg
)
