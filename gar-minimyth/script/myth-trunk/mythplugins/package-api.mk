MYTHPLUGINS_VERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)

MYTHPLUGINS_CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl

WORKSRC = $(WORKDIR)/mythplugins-$(MYTHPLUGINS_VERSION)
