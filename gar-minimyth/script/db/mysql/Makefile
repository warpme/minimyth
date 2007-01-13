GARNAME = mysql
GARVERSION = 3.23.58
CATEGORIES = db
MASTER_SITES = http://downloads.mysql.com/archives/mysql-3.23/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lib/ncurses lib/zlib
ifneq ($(DESTIMG),build)
BUILDDEPS += db/mysql
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-thread-safe-client \
	--with-gnu-ld \
	--without-debug \
	--without-server \
	--without-docs \
	--without-bench

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

CONFIGURE_ENV :=
BUILD_ARGS    += $(BUILD_ENV)

ifeq ($(DESTIMG),build)
USE_BUILD_BIN     =
INSTALL_BUILD_BIN = \
	mkdir -p $(DESTDIR)$(bindir) ; \
	cp $(WORKSRC)/$(strip $(1))/$(strip $(2)) $(DESTDIR)$(bindir)/_mysql_$(strip $(1))_$(strip $(2))
else
USE_BUILD_BIN     = \
	sed -i 's%\([ \t]*\)./$(strip $(2)) %\1_mysql_$(strip $(1))_$(strip $(2)) %g' $(WORKSRC)/$(strip $(1))/Makefile
INSTALL_BUILD_BIN =
endif

post-patch:
	@#Hack to allow configure to work. This works because we are not really cross compiling.
	@sed -i 's%\([ \t]*cross_compiling *= *\)yes%\1no%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@$(call USE_BUILD_BIN, libmysql, conf_to_src)
	@$(MAKECOOKIE)

post-install:
	@$(call INSTALL_BUILD_BIN, libmysql, conf_to_src)
	@$(call GLIBC_ADD_LIB_PATH, $(libdir)/mysql)
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient.la
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient_r.la
	@$(MAKECOOKIE)
