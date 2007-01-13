GARNAME = mysql
GARVERSION = 5.0.17
CATEGORIES = db
MASTER_SITES  = http://downloads.mysql.com/archives/$(GARNAME)-5.0/
MASTER_SITES += http://mirror.trouble-free.net/mysql_mirror/Downloads/MySQL-5.0/
MASTER_SITES += http://mysql.mirror.redwire.net/Downloads/MySQL-5.0/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(KERNEL_ARCH)
PATCHFILES  = $(DISTNAME).patch.gar
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/ncurses lib/zlib
ifneq ($(DESTIMG),build)
BUILDDEPS = db/mysql
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-thread-safe-client \
	--with-gnu-ld \
	--without-debug \
	--without-server \
	--without-extra-tools \
	--without-docs \
	--without-bench

CONFIGURE_ENV = $(shell cat $(WORKDIR)/config.cache.$(KERNEL_ARCH))

GAR_EXTRA_CONF += kernel/linux/package-api.mk devel/glibc/package-api.mk
include ../../gar.mk

install-cross:
	cp -f $(WORKSRC)/extra/comp_err   $(DESTDIR)$(bindir)/mysql-comp_err
	cp -f $(WORKSRC)/sql/gen_lex_hash $(DESTDIR)$(bindir)/mysql-gen_lex_hash
	@$(MAKECOOKIE)

post-install:
	@$(call GLIBC_ADD_LIB_PATH, $(libdir)/mysql)
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient.la
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient_r.la
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(build_DESTDIR)$(build_prefix)/mysql-test
	@rm -rf $(build_DESTDIR)$(build_bindir)/mysql*
	@rm -rf $(build_DESTDIR)$(build_datadir)/mysql
	@rm -rf $(build_DESTDIR)$(build_includedir)/mysql
	@rm -rf $(build_DESTDIR)$(build_libdir)/mysql
	@rm -rf $(build_DESTDIR)$(build_mandir)/man1/mysql*
	@rm -rf $(DESTDIR)$(prefix)/mysql-test
	@rm -rf $(DESTDIR)$(bindir)/mysql*
	@rm -rf $(DESTDIR)$(datadir)/mysql
	@rm -rf $(DESTDIR)$(includedir)/mysql
	@rm -rf $(DESTDIR)$(libdir)/mysql
	@rm -rf $(DESTDIR)$(mandir)/man1/mysql*
