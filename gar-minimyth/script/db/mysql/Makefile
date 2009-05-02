GARNAME = mysql
GARVERSION = 5.1.34
CATEGORIES = db
MASTER_SITES  = http://downloads.mysql.com/archives/$(GARNAME)-5.1/
MASTER_SITES += http://mirror.trouble-free.net/mysql_mirror/Downloads/MySQL-5.1/
MASTER_SITES += http://mysql.mirror.redwire.net/Downloads/MySQL-5.1/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(GARCH_FAMILY)
PATCHFILES  = $(DISTNAME)-perl.patch.gar
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lib/ncurses lib/zlib
BUILDDEPS  = utils/procps
ifneq ($(DESTIMG),build)
BUILDDEPS += db/mysql
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-shared \
	--disable-static \
	--enable-thread-safe-client \
	--with-gnu-ld \
	--without-debug \
	--with-server \
	--with-extra-tools \
	--without-docs \
	--without-bench

#CONFIGURE_ENV = $(shell cat $(WORKDIR)/config.cache.$(GARCH_FAMILY))

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

extract-config.cache.$(GARCH_FAMILY):
	@cp $(DOWNLOADDIR)/config.cache.$(GARCH_FAMILY) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

install-cross:
	@if test -e $(WORKSRC)/extra/comp_err   ; then cp -f $(WORKSRC)/extra/comp_err   $(DESTDIR)$(bindir)/mysql-comp_err     ; fi
	@if test -e $(WORKSRC)/sql/gen_lex_hash ; then cp -f $(WORKSRC)/sql/gen_lex_hash $(DESTDIR)$(bindir)/mysql-gen_lex_hash ; fi
	@$(MAKECOOKIE)

post-install:
	@$(call GLIBC_ADD_LIB_PATH, $(libdir)/mysql)
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient.la
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysqlclient_r.la
	@rm -f $(DESTDIR)$(libdir)/mysql/plugin/ha_archive.la
	@rm -f $(DESTDIR)$(libdir)/mysql/plugin/ha_blackhole.la
	@rm -f $(DESTDIR)$(libdir)/mysql/plugin/ha_example.la
	@rm -f $(DESTDIR)$(libdir)/mysql/plugin/ha_federated.la
	@rm -f $(DESTDIR)$(libdir)/mysql/plugin/ha_innodb.la
	@rm -f $(DESTDIR)$(libdir)/mysql/libdbug.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libheap.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libmyisam.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libmyisammrg.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libmystrings.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libmysys.a
	@rm -f $(DESTDIR)$(libdir)/mysql/libvio.a
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
