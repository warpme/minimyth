GARNAME = curl
GARVERSION =  7.19.4
CATEGORIES = net
MASTER_SITES = http://curl.haxx.se/download/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/openssl lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--enable-optimize \
	--enable-warnings \
	--enable-largefile \
	--enable-shared \
	--disable-static \
	--enable-http \
	--enable-ftp \
	--enable-file \
	--disable-ldap \
	--disable-ldaps \
	--enable-proxy \
	--disable-dict \
	--enable-telnet \
	--enable-tftp \
	--disable-manual \
	--enable-libgcc \
	--disable-ipv6 \
	--enable-nonblocking \
	--enable-thread \
	--disable-ares \
	--enable-verbose \
	--disable-sspi \
	--enable-crypto-auth \
	--enable-cookies \
	--enable-hidden-symbols \
	--disable-soname-bump \
	--with-gnu-ld \
	--without-ldap \
	--without-krb4 \
	--without-spnego \
	--without-gssapi \
	--with-ssl \
	--with-zlib \
	--without-libssh2 \
	--without-egd-socket \
	--with-random="$(rootdir)/dev/urandom" \
	--without-gnutls \
	--without-nss \
	--with-ca-bundle="$(sysconfdir)/ssl/certs/ca-bundle.crt" \
	--without-ca-path \
	--without-libidn

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcurl.la
	@$(MAKECOOKIE)
