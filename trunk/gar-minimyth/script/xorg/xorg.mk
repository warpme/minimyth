# Include AFTER gar.lib.mk

include ../../xorg/xorg.conf.mk

licensedir := $(xorg_licensedir)

CPPFLAGS := -I$(DESTDIR)$(xorg_includedir) $(CPPFLAGS)
CFLAGS   := -I$(DESTDIR)$(xorg_includedir) $(CFLAGS)
CFLAGS   := -L$(DESTDIR)$(xorg_libdir)     $(CFLAGS)
LDFLAGS  := -L$(DESTDIR)$(xorg_libdir)     $(LDFLAGS)

# Change TMP_DIRPATHS so that DIRPATHS will use xorg directories.
TMP_DIRPATHS := \
	--prefix=$(xorg_prefix) \
	--exec_prefix=$(xorg_exec_prefix) \
	--bindir=$(xorg_bindir) \
	--sbindir=$(xorg_sbindir) \
	--libexecdir=$(xorg_libexecdir) \
	--datadir=$(xorg_datadir) \
	--sysconfdir=$(xorg_sysconfdir) \
	--sharedstatedir=$(xorg_sharedstatedir) \
	--localstatedir=$(xorg_localstatedir) \
	--libdir=$(xorg_libdir) \
	--infodir=$(xorg_infodir) \
	--includedir=$(xorg_includedir) \
	--oldincludedir=$(xorg_oldincludedir) \
	--mandir=$(xorg_mandir)

# Change STAGE_EXPORTS so that it does not include directories.
STAGE_EXPORTS :=
STAGE_EXPORTS += CPPFLAGS CFLAGS LDFLAGS
STAGE_EXPORTS += CC CXX LD CPP AR AS NM RANLIB STRIP OBJCOPY OBJDUMP

$(DESTIMG)_DEPENDS += xorg/xorg-base
