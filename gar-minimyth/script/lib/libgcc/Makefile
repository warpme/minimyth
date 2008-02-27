GARNAME = libgcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = lib
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

build-custom:
	@$(MAKE) -C $(GARDIR)/devel/gcc DESTIMG=build install
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(elibdir)
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgcc.a        ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgcc_s.so     ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgcc_s.so.*   ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgcc.a     ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgcc_s.so  ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgcc_s.so.*),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgcc.a     ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgcc_s.so  ),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgcc_s.so.*),cp -af $(file) $(DESTDIR)$(elibdir) ; )
	@mkdir -p $(DESTDIR)$(libdir)
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgomp.a      ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgomp.so     ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libgomp.so.*   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgomp.a   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgomp.so  ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libgomp.so.*),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgomp.a   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgomp.so  ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libgomp.so.*),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(MAKECOOKIE)

CROSSIMG = $(DESTIMG)
export CROSSIMG
