#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------
-include $(HOME)/.minimyth/minimyth.conf.mk

# The version of MiniMyth.
mm_VERSION                ?= $(mm_VERSION_MYTH)-$(mm_VERSION_MINIMYTH)$(mm_VERSION_EXTRA)
mm_VERSION_MYTH           ?= $(strip \
                                $(if $(filter 0.22  ,$(mm_MYTH_VERSION)),0.22.0) \
                                $(if $(filter 0.23  ,$(mm_MYTH_VERSION)),0.23.1) \
                                $(if $(filter 0.24  ,$(mm_MYTH_VERSION)),0.24.2) \
                                $(if $(filter 0.25  ,$(mm_MYTH_VERSION)),0.25.0) \
                                $(if $(filter master,$(mm_MYTH_VERSION)),master) \
                              )
mm_VERSION_MINIMYTH       ?= 80
mm_VERSION_EXTRA          ?= $(strip \
                                $(if $(filter yes,$(mm_DEBUG)),-debug) \
                              )

# Configuration file (minimyth.conf) version.
mm_CONF_VERSION           ?= 59

#-------------------------------------------------------------------------------
# Variables that you are likely to be override based on your environment.
#-------------------------------------------------------------------------------
# Indicates whether or not to enable debugging in the image.
# Valid values for mm_DEBUG are 'yes' and 'no'.
mm_DEBUG                  ?= no
# Indicates whether or not to enable debugging in the build system.
# Valid values for mm_DEBUG_BUILD are 'yes' and 'no'.
mm_DEBUG_BUILD            ?= no
# Lists the graphics drivers supported.
# Valid values for mm_GRAPHICS are one or more of 'intel', 'geode', 'nouveau',
# 'nvidia', 'openchrome', 'radeon', 'savage', 'sis', and 'vmware'.
mm_GRAPHICS               ?= intel \
                             $(if $(filter $(mm_GARCH_FAMILY),i386),geode) \
                             nouveau \
                             nvidia \
                             $(if $(filter $(mm_GARCH_FAMILY),i386),openchrome) \
                             radeon \
                             sis \
                             vmware
# Lists the software to be supported.
# Valid values for MM_SOFTWARE are zero or more of 'mythbrowser', 'mythgallery',
# 'mythgame', 'mythmusic', 'mythnetvision', 'mythnews', 'mythstream',
# 'mythvideo', 'mythweather', 'mythzoneminder', 'flash', 'hulu', 'mplayer-svn',
# 'mplayer-vld', 'vlc' 'xine', 'mame', 'bdremote', 'wiimote', 'backend','python',
# 'debug'.
mm_SOFTWARE               ?= mythbrowser \
                             mythgallery \
                             mythgame \
                             mythmusic \
                             $(if $(filter-out $(mm_MYTH_VERSION),0.22),mythnetvision) \
                             mythnews \
                             $(if $(filter $(mm_MYTH_VERSION),0.22 0.23 0.24),mythstream) \
                             $(if $(filter $(mm_MYTH_VERSION),0.22 0.23 0.24),mythvideo) \
                             mythweather \
                             mythzoneminder \
                             flash \
                             hulu \
                             mplayer-svn \
                             $(if $(filter openchrome,$(mm_GRAPHICS)), \
                                 $(if $(filter $(mm_MYTH_VERSION),0.22 0.23 0.24),mplayer-vld)) \
                             vlc \
                             xine \
                             bdremote \
                             wiimote \
                             backend \
                             python \
                             $(if $(filter $(mm_DEBUG),yes),debug)
# Indicates the microprocessor architecture.
# Valid values for mm_GARCH are 'atom', 'c3', 'c3-2', 'pentium-mmx' and 'x86-64'.
mm_GARCH                  ?= pentium-mmx
# Indicates whether or not to create the RAM based part of the distribution.
mm_DISTRIBUTION_RAM       ?= yes
# Indicates whether or not to create the NFS based part of the distribution.
mm_DISTRIBUTION_NFS       ?= yes
# Indicates whether or not to create the local distribution.
mm_DISTRIBUTION_LOCAL     ?= yes
# Indicates whether or not to create the share distribution.
mm_DISTRIBUTION_SHARE     ?= yes
# Indicates whether or not to install the MiniMyth files needed to network boot
# with a RAM root file system. This will cause files to be installed in
# directory $(mm_TFTP_ROOT)/minimyth-$(mm_VERSION)/.
# Valid values for mm_INSTALL_RAM_BOOT are 'yes' and 'no'.
mm_INSTALL_RAM_BOOT       ?= no
# Indicates whether or not to install the MiniMyth files needed to network boot
# with an NFS root file system. This will cause files to be installed in
# directories $(mm_TFTP_ROOT)/minimyth-$(mm_VERSION) and
# $(mm_NFS_ROOT)/minimyth-$(mm_VERSION).
# Valid values for mm_INSTALL_NFS_BOOT are 'yes' and 'no'.
mm_INSTALL_NFS_BOOT       ?= no
# Indicates whether or not to install the MiniMyth files needed to run the
# mm_local_install and mm_local_update. These files will be installed in
# directory $(mm_TFTP_ROOT)/latest so that they can be downloaded via TFTP. It
# is called latest because that is the directory name used in the public
# MiniMyth distribution download directory.
# Valid values for mm_INSTALL_LATEST are 'yes' and 'no'.
mm_INSTALL_LATEST         ?= no
# Indicates the directory where the GAR MiniMyth build system is installed.
mm_HOME                   ?= $(HOME)/svnroot/minimyth/gar-minimyth
# Indicates the pxeboot TFTP directory.
# The MiniMyth kernel, the MiniMyth file system image and MiniMyth themes are
# installed in this directory. The files will be installed in a subdirectory
# named 'minimyth-$(mm_VERSION)'.
mm_TFTP_ROOT              ?= /var/tftpboot/minimyth
# Indicates the directory in which the directory containing the MiniMyth root
# file system for mounting using NFS. The MiniMyth root file system will be
# installed in a subdirectory named 'minimyth-$(mm_VERSION)'.
mm_NFS_ROOT               ?= /home/public/minimyth
# The version of kernel headers to use.
# Valid values are '3.3'.
mm_KERNEL_HEADERS_VERSION ?= 3.3
# The version of kernel to use.
# Valid values are '3.3'.
mm_KERNEL_VERSION         ?= 3.3
# The kernel configuration file to use.
# When set, the kernel configuration file $(HOME)/.minimyth/$(mm_KERNEL_CONFIG) will be used.
# When not set, a built-in kernel configuration file will be used.
mm_KERNEL_CONFIG          ?=
# The version of Myth to use.
# Valid values are '0.22', '0.23', '0.24', '0.25', 'master'.
mm_MYTH_VERSION           ?= 0.24
# The version of the NVIDIA driver.
# Valid values are '96.43.20' (legacy), '173.14.31' (legacy), '270.41.19',
# '275.36', '295.40'.
mm_NVIDIA_VERSION         ?= 295.40
# The version of xorg to use.
# Valid values are '7.6'.
mm_XORG_VERSION           ?= 7.6
# MythTV master version built. If the version changes too much then the patches
# may no longer work. The version string format is:
# master-<date>-<mythtv-git-commit>-<myththemes-git-commit>, where <date> has
# the format YYYYMMDD.
mm_MYTHTV_MASTER_VERSION  ?= master-20120408-28db6ca
# Lists additional packages to build when minimyth is built.
mm_USER_PACKAGES          ?=
# Lists additional binaries to include in the MiniMyth image
# by adding to the lists found in minimyth-bin-list* and bins-share-list files.
mm_USER_BIN_LIST          ?=
# Lists additional configs to include in the MiniMyth image
# by adding to the lists found in minimyth-etc-list* and extras-etc-list files.
mm_USER_ETC_LIST          ?=
# Lists additional libraries to include in the MiniMyth image
# by adding to the lists found in minimyth-lib-list* and extras-lib-list files.
mm_USER_LIB_LIST          ?=
# Lists additional files to remove from the MiniMyth image
# by adding to the lists found in minimyth-remove-list* and extras-remote-list files.
mm_USER_REMOVE_LIST       ?=
# Lists additional data to include in the MiniMyth image
# by adding to the lists found in minimyth-share-list* and extras-share-list files.
mm_USER_SHARE_LIST        ?=

#-------------------------------------------------------------------------------
# Variables that you are not likely to override.
#-------------------------------------------------------------------------------
mm_GARCH_FAMILY           ?= $(strip \
                                 $(if $(filter atom       ,$(mm_GARCH)),x86_64) \
                                 $(if $(filter c3         ,$(mm_GARCH)),i386  ) \
                                 $(if $(filter c3-2       ,$(mm_GARCH)),i386  ) \
                                 $(if $(filter pentium-mmx,$(mm_GARCH)),i386  ) \
                                 $(if $(filter x86-64     ,$(mm_GARCH)),x86_64) \
                              )
mm_GARHOST                ?= $(strip \
                                 $(if $(filter atom       ,$(mm_GARCH)),x86_64) \
                                 $(if $(filter c3         ,$(mm_GARCH)),i586  ) \
                                 $(if $(filter c3-2       ,$(mm_GARCH)),i586  ) \
                                 $(if $(filter pentium-mmx,$(mm_GARCH)),i586  ) \
                                 $(if $(filter x86-64     ,$(mm_GARCH)),x86_64) \
                              )-minimyth-linux-gnu
mm_CFLAGS                 ?= $(strip \
                                 -pipe                                                                                       \
                                 $(if $(filter atom        ,$(mm_GARCH)),-march=atom        -mtune=atom    -O2 -mfpmath=sse -ftree-vectorize -mmovbe) \
                                 $(if $(filter c3          ,$(mm_GARCH)),-march=c3          -mtune=c3      -Os             ) \
                                 $(if $(filter c3-2        ,$(mm_GARCH)),-march=c3-2        -mtune=c3-2    -Os -mfpmath=sse) \
                                 $(if $(filter pentium-mmx ,$(mm_GARCH)),-march=pentium-mmx -mtune=generic -Os             ) \
                                 $(if $(filter x86-64      ,$(mm_GARCH)),-march=x86-64      -mtune=generic -O3 -mfpmath=sse) \
                                 -flto                                                                                       \
                                 $(if $(filter i386  ,$(mm_GARCH_FAMILY)),-m32)                                              \
                                 $(if $(filter x86_64,$(mm_GARCH_FAMILY)),-m64)                                              \
                                 $(if $(filter yes,$(mm_DEBUG)),-g)                                                          \
                              )
mm_CXXFLAGS               ?= $(mm_CFLAGS)
mm_DESTDIR                ?= $(mm_HOME)/images/mm

#-------------------------------------------------------------------------------
# Variables that you cannot override.
#-------------------------------------------------------------------------------
# Set the language for gettext to English so the configure scripts for packages
# such as lib/libjpeg do not yield incorrect results.
LANGUAGE=en
export LANGUAGE

# Stop attempts to check out patches from perforce.
PATCH_GET=0
export PATCH_GET

# Set the number of parallel makes to the number of processors.
PARALLELMFLAGS=-j$(shell cat /proc/cpuinfo | grep -c '^processor[[:cntrl:]]*:')
export PARALLELMFLAGS

# Get rid of Qt environment variables
$(foreach var, $(shell set | grep '^QMAKE' | sed 's%=.*$$%%'), $(eval $(var) :=))
$(foreach var, $(shell set | grep '^QMAKE' | sed 's%=.*$$%%'), $(eval unexport $(var)))
$(foreach var, $(shell set | grep '^QT' | sed 's%=.*$$%%'), $(eval $(var) :=))
$(foreach var, $(shell set | grep '^QT' | sed 's%=.*$$%%'), $(eval unexport $(var)))
