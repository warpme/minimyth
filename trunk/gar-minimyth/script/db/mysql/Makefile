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

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD)

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

post-configure:
	@$(call USE_BUILD_BIN, libmysql, conf_to_src)
	@$(call USE_BUILD_BIN, strings , conf_to_src)
	@$(call USE_BUILD_BIN, sql     , gen_lex_hash)
	@$(MAKECOOKIE)

post-install:
	@$(call INSTALL_BUILD_BIN, libmysql, conf_to_src)
	@$(call INSTALL_BUILD_BIN, strings , conf_to_src)
	@$(call INSTALL_BUILD_BIN, sql     , gen_lex_hash)
	@$(call GLIBC_ADD_LIB_PATH, $(libdir)/mysql)
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient.la
	@$(MAKECOOKIE)
