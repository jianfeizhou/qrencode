#! /bin/sh

MYHOST=`echo $C_TOOLCHAIN_CC | sed 's/\(.*\)\//\1 /' | cut -d ' ' -f2 | sed 's/\(.*\)-/\1 /' | cut -d ' ' -f1`

echo "--------- CURL BUILD ENVIREMENT ----------"
echo "CC : $C_TOOLCHAIN_CC"
echo "CXX : $CXX_TOOLCHAIN"
echo "LD : $LD_TOOLCHAIN"
echo "HOSTNAME: $MYHOST"
echo "------------------------------------------"

export CC=$C_TOOLCHAIN_CC
export LDFLAGS="-L../lib/zlib/lib -L../lib/pnglib/lib"
export CPPFLAGS="-I../lib/zlib/include/ -I../lib/pnglib/include/"
export png_LIBS="-L../lib/zlib/lib -L../lib/pnglib/lib -lpng16 -lz"
./configure --host=arm-linux --prefix=$TOP_FOLDER/lib/qrencode