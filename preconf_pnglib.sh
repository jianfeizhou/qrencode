#! /bin/sh

MYHOST=`echo $C_TOOLCHAIN_CC | sed 's/\(.*\)\//\1 /' | cut -d ' ' -f2 | sed 's/\(.*\)-/\1 /' | cut -d ' ' -f1`

echo "--------- CURL BUILD ENVIREMENT ----------"
echo "CC : $C_TOOLCHAIN_CC"
echo "CXX : $CXX_TOOLCHAIN"
echo "LD : $LD_TOOLCHAIN"
echo "HOSTNAME: $MYHOST"
echo "------------------------------------------"

export LDFLAGS="-L../lib/zlib/lib"
export CPPFLAGS="-I./ -I../lib/zlib/include/"
export CC=$C_TOOLCHAIN_CC
./configure --host=arm-linux  --prefix=$TOP_FOLDER/lib/pnglib