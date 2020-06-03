include ../../include/MakeConfig

ZLIB_DIR=zlib-1.2.11
PNGLIB_DIR=libpng-1.6.37
QRENCODE=qrencode-4.0.2

CURRENT_FOLDER=$(shell pwd)

CP_LIB_TO_PREBUILD=YES

all:  prepare_env
	@if [ ! -r zlib/configure.log ]; then cd zlib; $(SH) TOP_FOLDER=$(CURRENT_FOLDER) TOOLCHAIN_VER=$(TOOLCHAIN_VER) C_TOOLCHAIN_CC=$(_CC) CXX_TOOLCHAIN=$(_CXX) ../preconf_zlib.sh ; fi
	make -C zlib -j8
	make -C zlib install
	@if [ "$(CP_LIB_TO_PREBUILD)" == "YES" ]; then cp -fd lib/zlib/lib/libz*.so* ../../lib_release/QR ; fi

	@if [ ! -r pnglib/config.status ]; then cd pnglib; $(SH) TOP_FOLDER=$(CURRENT_FOLDER) TOOLCHAIN_VER=$(TOOLCHAIN_VER) C_TOOLCHAIN_CC=$(_CC) CXX_TOOLCHAIN=$(_CXX) source ../preconf_pnglib.sh ; fi
	make -C pnglib -j8
	make -C pnglib install
	@if [ "$(CP_LIB_TO_PREBUILD)" == "YES" ]; then cp -fd lib/pnglib/lib/libpng*.so* ../../lib_release/QR ; fi
	
	@if [ ! -r qrencode/config.status ]; then cd qrencode; $(SH) TOP_FOLDER=$(CURRENT_FOLDER) TOOLCHAIN_VER=$(TOOLCHAIN_VER) C_TOOLCHAIN_CC=$(_CC) CXX_TOOLCHAIN=$(_CXX) ../preconf_qrencode.sh ; fi
	make -C qrencode -j8
	make -C qrencode install
	@if [ "$(CP_LIB_TO_PREBUILD)" == "YES" ]; then cp -fd lib/qrencode/lib/libqrencode*.so* ../../lib_release/QR ; cp lib/qrencode/bin/qrencode ../../src/Project/ ; fi
	
clean:
	make clean -C  zlib 
	make clean -C  pnglib 
	make clean -C  qrencode
#	-rm  $(CURRENT_FOLDER)/lib -r
distclean:
	make distclean -C  zlib  
	make distclean -C  pnglib 
	make distclean -C  qrencode

prepare_env:
	ln -sf $(ZLIB_DIR) zlib
	ln -sf $(PNGLIB_DIR) pnglib
	ln -sf $(QRENCODE) qrencode
	test -d ../../lib_release/QR || mkdir ../../lib_release/QR
	
