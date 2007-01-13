GARNAME = c
GARVERSION = none
CATEGORIES = lang

DESCRIPTION =
define BLURB
endef

DEPENDS    = lib/libgcc
BUILDDEPS  = lang/c
# Development tools often used when building c language programs.
BUILDDEPS += \
	devel/bison \
	devel/flex \
	devel/gettext \
	devel/autoconf \
	devel/automake-1.6 \
	devel/automake \
	devel/libtool \
	devel/pkgconfig \
	utils/coreutils

include ../../gar.mk

$(DESTIMG)_NODEPEND += lang/c
export $(DESTIMG)_NODEPEND
