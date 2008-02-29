#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------
-include $(HOME)/.minimyth/minimyth.conf.mk

# The version of MiniMyth.
mm_VERSION                ?= $(mm_VERSION_MYTH)-$(mm_VERSION_MINIMYTH)$(mm_VERSION_EXTRA)
mm_VERSION_MYTH           ?= $(strip \
                                $(if $(filter softpad20 ,$(mm_MYTH_VERSION)),softpad20                     ) \
                                $(if $(filter stable20  ,$(mm_MYTH_VERSION)),0.20.2                        ) \
                                $(if $(filter stable21  ,$(mm_MYTH_VERSION)),0.21.0                        ) \
                                $(if $(filter trunk     ,$(mm_MYTH_VERSION)),trunk.$(mm_MYTH_TRUNK_VERSION)) \
                              )
mm_VERSION_MINIMYTH       ?= 39
mm_VERSION_EXTRA          ?= $(strip \
                                $(if $(filter yes,$(mm_DEBUG)),-debug) \
                              )

# Configuration file (minimyth.conf) version.
mm_CONF_VERSION           ?= 23

#-------------------------------------------------------------------------------
# Variables that you are likely to be override based on your environment.
#-------------------------------------------------------------------------------
# Indicates whether or not to enable debugging in the image.
# Valid values for mm_DEBUG are 'yes' and 'no'.
mm_DEBUG                  ?= no
# Indicates whether or not to enable debugging in the build system.
# Valid values for mm_DEBUG_BUILD are 'yes' and 'no'.
mm_DEBUG_BUILD            ?= no
# Lists the chipset families supported.
# Valid values for mm_CHIPSETS are one or more of 'ati', 'iegd' 'intel',
# 'nvidia', 'sis', 'via', 'vmware' and 'other'.
mm_CHIPSETS               ?= intel nvidia via other
# Lists the software to be supported.
# Valid values for MM_SOFTWARE are zero or more of 'mythaudio', 'mythbrowser',
# 'mythdvd', 'mythgallery', 'mythgame', 'mythmusic', 'mythnews', 'mythphone',
# 'mythstream', 'mythvideo', 'mythweather', 'mythzoneminder', 'mplayer', 'xine',
# 'perl', 'transcode', 'mame', 'wiimote' and 'debug'.
mm_SOFTWARE               ?= mythbrowser \
                             $(if $(filter $(mm_MYTH_VERSION),softpad20 stable20),mythdvd) \
                             mythgallery \
                             mythgame \
                             mythmusic \
                             mythnews \
                             mythphone \
                             mythstream \
                             mythvideo \
                             mythweather \
                             $(if $(filter $(mm_MYTH_VERSION),svn),mythzoneminder) \
                             mplayer \
                             xine \
                             perl \
                             $(if $(filter $(mm_DEBUG),yes),debug)
# Indicates the microprocessor architecture.
# Valid values for mm_GARCH are 'athlon64', 'c3', 'c3-2' and 'pentium-mmx'.
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
# Valid values are '2.6.23' and '2.6.24'.
mm_KERNEL_HEADERS_VERSION ?= 2.6.24
# The version of kernel to use.
# Valid values are '2.6.23' and '2.6.24'.
mm_KERNEL_VERSION         ?= 2.6.24
# The kernel configuration file to use.
# When set, the kernel configuration file $(HOME)/.minimyth/$(mm_KERNEL_CONFIG) will be used.
# When not set, a built-in kernel configuration file will be used.
mm_KERNEL_CONFIG          ?=
# The version of Myth to use.
# Valid values are 'softpad20', 'stable20', 'stable21', and 'svn'.
mm_MYTH_VERSION           ?= stable20
# The version of the NVIDIA driver.
# Valid values are '71.86.04' (legacy), '96.43.05' (legacy), '169.09' and '169.12'.
mm_NVIDIA_VERSION         ?= 169.12
# The version of xorg to use.
# Valid values are '7.2' and '7.3'.
mm_XORG_VERSION           ?= 7.3
# Myth trunk version built. If the version changes too much then the patches may
# no longer work.
mm_MYTH_TRUNK_VERSION       ?= 16133
# Lists additional packages to build when minimyth is built.
mm_USER_PACKAGES          ?=
# Lists additional binaries to include in the MiniMyth image
# by adding to the lists found in minimyth-bin-list and bins-share-list
mm_USER_BIN_LIST          ?=
# Lists additional configs to include in the MiniMyth image
# by adding to the lists found in minimyth-etc-list and extras-etc-list
mm_USER_ETC_LIST          ?=
# Lists additional libraries to include in the MiniMyth image
# by adding to the lists found in minimyth-lib-list and extras-lib-list
mm_USER_LIB_LIST          ?=
# Lists additional data to include in the MiniMyth image
# by adding to the lists found in minimyth-share-list and extras-share-list
mm_USER_REMOVE_LIST       ?=
# Lists additional files to remove from the MiniMyth image
# by adding to the lists found in minimyth-remove-list*.
mm_USER_SHARE_LIST        ?=

#-------------------------------------------------------------------------------
# Variables that you are not likely to override.
#-------------------------------------------------------------------------------
mm_GARCH_FAMILY           ?= $(strip \
                                $(if $(filter athlon64   ,$(mm_GARCH)),x86_64) \
                                $(if $(filter c3         ,$(mm_GARCH)),i386  ) \
                                $(if $(filter c3-2       ,$(mm_GARCH)),i386  ) \
                                $(if $(filter pentium-mmx,$(mm_GARCH)),i386  ) \
                              )
mm_GARHOST                ?= $(strip \
                                $(if $(filter athlon64   ,$(mm_GARCH)),               \
                                    $(if $(filter i386  ,$(mm_GARCH_FAMILY)),i686  )  \
                                    $(if $(filter x86_64,$(mm_GARCH_FAMILY)),x86_64)) \
                                $(if $(filter c3         ,$(mm_GARCH)),      i586  )  \
                                $(if $(filter c3-2       ,$(mm_GARCH)),      i586  )  \
                                $(if $(filter pentium-mmx,$(mm_GARCH)),      i586  )  \
                              )-minimyth-linux-gnu
mm_CFLAGS                 ?= $(strip \
                                -pipe                                                     \
                                -march=$(mm_GARCH)                                        \
                                $(if $(filter athlon64    ,$(mm_GARCH)),-O3 -mfpmath=sse) \
                                $(if $(filter c3          ,$(mm_GARCH)),-Os             ) \
                                $(if $(filter c3-2        ,$(mm_GARCH)),-Os -mfpmath=sse) \
                                $(if $(filter pentium-mmx ,$(mm_GARCH)),-Os             ) \
                                $(if $(filter i386  ,$(mm_GARCH_FAMILY)),-m32)            \
                                $(if $(filter x86_64,$(mm_GARCH_FAMILY)),-m64)            \
                                $(if $(filter yes,$(mm_DEBUG)),-g)                        \
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
PARALLELMFLAGS=-j`cat /proc/cpuinfo | grep -c '^processor[[:cntrl:]]*:'`
export PARALLELMFLAGS
