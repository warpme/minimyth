GCC_MAJOR_VERSION = 4
GCC_MINOR_VERSION = 1
GCC_TEENY_VERSION = 2
GCC_EXTRA_VERSION = 20070208

#GCC_TYPE = release
GCC_TYPE = prerelease
#GCC_TYPE = snapshot

GCC_VERSION = $(strip                                                                                                              \
	$(if $(filter release   ,$(GCC_TYPE)),$(GCC_MAJOR_VERSION).$(GCC_MINOR_VERSION).$(GCC_TEENY_VERSION)                     ) \
	$(if $(filter prerelease,$(GCC_TYPE)),$(GCC_MAJOR_VERSION).$(GCC_MINOR_VERSION).$(GCC_TEENY_VERSION)-$(GCC_EXTRA_VERSION)) \
	$(if $(filter snapshot  ,$(GCC_TYPE)),$(GCC_MAJOR_VERSION).$(GCC_MINOR_VERSION)-$(GCC_EXTRA_VERSION)                     ) )

CROSS_GCC_DIR = \
	$(build_DESTDIR)$(build_libdir)/gcc/$(GARTARGET)
CROSS_GCC_LIBDIR = \
	$(CROSS_GCC_DIR)/$(GCC_MAJOR_VERSION).$(GCC_MINOR_VERSION).$(GCC_TEENY_VERSION)
CROSS_GCC_INCLUDEDIR = \
	$(CROSS_GCC_LIBDIR)/include
