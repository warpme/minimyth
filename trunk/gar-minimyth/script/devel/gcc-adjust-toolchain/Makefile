GARNAME = gcc-adjust-toolchain
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

BEPENDS = devel/gcc-bootstrap devel/glibc

INSTALL_SCRIPTS = adjust-ld-linux adjust-gcc-headers

GCC_LIB_DIR  = $(DESTDIR)$(libdir)/gcc/$(GARTARGET)/$(GCC_VERSION)
LD_LINUX_DIR = $(elibdir)

GAR_EXTRA_CONF += devel/gcc/package-api.mk

include ../../gar.mk

install-adjust-ld-linux:
	@sed -i 's% [^ ]*/lib/ld-linux.so.2% $(LD_LINUX_DIR)/ld-linux.so.2%g' $(GCC_LIB_DIR)/specs $(GCC_LIB_DIR)/specs
	@$(MAKECOOKIE)

install-adjust-gcc-headers:
	@rm -f $(GCC_LIB_DIR)/include/pthread.h
	@rm -f $(GCC_LIB_DIR)/include/bits/sigthread.h
	@$(MAKECOOKIE)
