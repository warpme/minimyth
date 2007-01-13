GARNAME = mysql
GARVERSION = 4.1.14
CATEGORIES = db
MASTER_SITES  = http://downloads.mysql.com/archives/$(GARNAME)-4.1/
MASTER_SITES += http://mirror.trouble-free.net/mysql_mirror/Downloads/MySQL-4.1/
MASTER_SITES += http://mysql.sd1.mirrors.redwire.net/Downloads/MySQL-4.1/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/ncurses lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-thread-safe-client \
	--with-gnu-ld \
	--without-debug \
	--without-server \
	--without-extra-tools \
	--without-docs \
	--without-bench

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

post-patch:
	@#Hack to allow configure to work. This works because we are not really cross compiling.
	@sed -i 's%\("$$cross_compiling" *= *\)yes%\1gar%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@$(call GLIBC_ADD_LIB_PATH, $(libdir)/mysql)
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient.la
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient_r.la
	@$(MAKECOOKIE)
