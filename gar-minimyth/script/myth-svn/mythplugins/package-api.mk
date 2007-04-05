MYTHPLUGINS_VERSION = $(mm_MYTH_SVN_VERSION)

MYTHPLUGINS_CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl
