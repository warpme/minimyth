MYTHPLUGINS_VERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)

MYTHPLUGINS_CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl

WORKSRC = $(WORKDIR)/mythplugins-$(MYTHPLUGINS_VERSION)
