GARNAME = libstdc++
GARVERSION = $(GCC_VERSION)
CATEGORIES = lib
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c++

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

build-custom:
	@$(MAKE) -C $(GARDIR)/devel/gcc DESTIMG=build install
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libstdc++.a      ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libstdc++.so     ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_LIBDIR)/libstdc++.so.*   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libstdc++.a   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libstdc++.so  ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib32/libstdc++.so.*),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libstdc++.a   ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libstdc++.so  ),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(foreach file,$(wildcard $(CROSS_GCC_DIR)/lib64/libstdc++.so.*),cp -af $(file) $(DESTDIR)$(libdir) ; )
	@$(MAKECOOKIE)

CROSSIMG = $(DESTIMG)
export CROSSIMG
