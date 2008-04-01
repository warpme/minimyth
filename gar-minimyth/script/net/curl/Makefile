GARNAME = curl
GARVERSION =  7.18.1
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
	--enable-http \
	--enable-ftp \
	--enable-file \
	--disable-ldap \
	--disable-ldaps \
	--disable-dict \
	--disable-telnet \
	--enable-tftp \
	--disable-manual \
	--enable-libgcc \
	--disable-ipv6 \
	--enable-nonblocking \
	--enable-thread \
	--disable-ares \
	--disable-verbose \
	--disable-sspi \
	--disable-debug \
	--disable-crypto-auth \
	--disable-cookies \
	--enable-hidden-symbols \
	--with-gnu-ld \
	--with-ssl \
	--with-zlib \
	--without-libssh2 \
	--with-random=$(rootdir)/dev/urandom \
	--without-gnutls \
	--without-nss \
	--without-ca-bundle \
	--without-libidn

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcurl.la
	@$(MAKECOOKIE)
