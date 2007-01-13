GARNAME = nvidia
GARVERSION = $(NVIDIA_VERSION)
CATEGORIES = X11
SOURCEPKG = kernel/nvidia
LICENSE = nvidia
nvidia_LICENSE_TEXT=$(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/linux xorg/xorg
BUILDDEPS = kernel/module-init-tools

WORKSRC = $(WORKDIR)/$(NVIDIA_DISTFILE)

INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += kernel/nvidia/package-api.mk
include ../../gar.mk

MAJOR_VERSION = $(NVIDIA_MAJOR_VERSION)
MINOR_VERSION = $(NVIDIA_MINOR_VERSION)
TEENY_VERSION = $(NVIDIA_TEENY_VERSION)

NVIDIA_LIBDIR = $(libdir)/nvidia
NVIDIA_BINDIR = $(bindir)/nvidia

install-custom:
	@mkdir -p $(DESTDIR)$(NVIDIA_BINDIR)
	@install $(WORKSRC)/usr/bin/nvidia-xconfig \
		$(DESTDIR)$(NVIDIA_BINDIR)/nvidia-xconfig
	@mkdir -p $(DESTDIR)$(NVIDIA_LIBDIR)
	@mkdir -p $(DESTDIR)$(NVIDIA_LIBDIR)/xorg/modules/drivers
	@mkdir -p $(DESTDIR)$(NVIDIA_LIBDIR)/xorg/modules/extensions
	@install $(WORKSRC)/usr/X11R6/lib/libXvMCNVIDIA.a \
		$(DESTDIR)$(NVIDIA_LIBDIR)/libXvMCNVIDIA.a
	@install $(WORKSRC)/usr/X11R6/lib/libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)
	@install $(WORKSRC)/usr/lib/libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)
	@install $(WORKSRC)/usr/lib/libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)
	@install $(WORKSRC)/usr/X11R6/lib/modules/drivers/nvidia_drv.so \
		$(DESTDIR)$(NVIDIA_LIBDIR)/xorg/modules/drivers
	@install $(WORKSRC)/usr/X11R6/lib/modules/extensions/libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)/xorg/modules/extensions
	@install $(WORKSRC)/usr/lib/tls/libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)
	@install $(WORKSRC)/usr/lib/libnvidia-cfg.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(NVIDIA_LIBDIR)
	@cd $(DESTDIR)$(NVIDIA_LIBDIR) ; \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libXvMCNVIDIA.so.$(MAJOR_VERSION) ; \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION) \
		       libXvMCNVIDIA.so
	@cd $(DESTDIR)$(NVIDIA_LIBDIR) ; \
		ln -sf libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libGL.so.$(MAJOR_VERSION) ; \
		ln -sf libGL.so.$(MAJOR_VERSION) \
		       libGL.so
	@cd $(DESTDIR)$(NVIDIA_LIBDIR) ; \
		ln -sf libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libGLcore.so.$(MAJOR_VERSION) ; \
		ln -sf libGLcore.so.$(MAJOR_VERSION) \
		       libGLcore.so
	@cd $(DESTDIR)$(NVIDIA_LIBDIR)/xorg/modules/extensions; \
		ln -sf libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libglx.so.$(MAJOR_VERSION) ; \
		ln -sf libglx.so.$(MAJOR_VERSION) \
		       libglx.so
	@cd $(DESTDIR)$(NVIDIA_LIBDIR) ; \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libnvidia-tls.so.$(MAJOR_VERSION) ; \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION) \
		       libnvidia-tls.so
	@cd $(DESTDIR)$(NVIDIA_LIBDIR) ; \
		ln -sf libnvidia-cfg.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libnvidia-cfg.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libnvidia-cfg.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libnvidia-cfg.so.$(MAJOR_VERSION) ; \
		ln -sf libnvidia-cfg.so.$(MAJOR_VERSION) \
		       libnvidia-cfg.so
	@$(MAKECOOKIE)
