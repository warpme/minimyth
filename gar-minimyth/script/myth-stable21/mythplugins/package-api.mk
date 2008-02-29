MYTHPLUGINS_VERSION = 0.21

MYTHPLUGINS_CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl

WORKSRC = $(strip $(if $(filter yes,$(MYTHTV_USE_RELEASE_TARBALL)), \
	$(WORKDIR)/mythplugins-$(MYTHPLUGINS_VERSION), \
	$(WORKDIR)/mythplugins-$(MYTHPLUGINS_VERSION)-$(MYTHTV_STABLE21_FIXES_VERSION)))
