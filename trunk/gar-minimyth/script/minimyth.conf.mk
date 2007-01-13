#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------

# The version of MiniMyth.
mm_VERSION           ?= 0.18.1.11

#-------------------------------------------------------------------------------
# Variables that you are likely to be override based on your environment.
#-------------------------------------------------------------------------------
# Lists the chipset families supported.
# Valid values for mm_CHIPSETS are one or more of 'nvidia' and 'via'.
mm_CHIPSETS          ?= via
# Indicates the microprocessor architecture.
# Valid values for mm_GARCH are 'c3', 'c3-2', 'pentium-mmx' and 'athlon64'.
mm_GARCH             ?= pentium-mmx
# Indicates whether or not to install the CRAMFS (ramdisk) file system images.
# Valid values for mm_INSTALL_CRAMFS are 'yes' and 'no'.
mm_INSTALL_CRAMFS    ?= yes
# Indicates whether or not to install the NFS file system images.
# Valid values for mm_INSTALL_NFS are 'yes' and 'no'.
mm_INSTALL_NFS       ?= no
# Indicates the directory where the GAR MiniMyth build system is installed.
mm_HOME              ?= $(P4ROOT)/gar-minimyth
# Indicates the pxeboot TFTP directory.
# The kernel and the CRAMFS image are installed in this directory.
mm_TFTP_ROOT         ?= /var/tftpboot/minimyth
# Indicates the directory in which the directory containing the NFS root file
# system image will be installed. The name of the directory containing the NFS
# root files sytem image is given by mm_NFSNAME.
mm_NFS_ROOT          ?= /home/public
# The version of Myth to use.
# Valid values are 'stable18', 'stable19' and 'svn'.
mm_MYTH_VERSION      ?= stable18
# Overrides the Myth SVN version built. If the version changes too much then
# the patches may no longer work.
mm_MYTH_SVN_VERSION  ?=
# Lists additional packages to build when minimyth is built.
mm_USER_PACKAGES     ?=
# Lists additional binaries to include in the MiniMyth image
# by adding to the lists found in minimyth-bin-list and bins-share-list
mm_USER_BIN_LIST     ?=
# Lists additional configs to include in the MiniMyth image
# by adding to the lists found in minimyth-etc-list and extras-etc-list
mm_USER_ETC_LIST     ?=
# Lists additional libraries to include in the MiniMyth image
# by adding to the lists found in minimyth-lib-list and extras-lib-list
mm_USER_LIB_LIST     ?=
# Lists additional data to include in the MiniMyth image
# by adding to the lists found in minimyth-share-list and extras-share-list
mm_USER_REMOVE_LIST   ?=
# Lists additional files to remove from the MiniMyth image
# by adding to the lists found in minimyth-remove-list*.
mm_USER_SHARE_LIST   ?=

#-------------------------------------------------------------------------------
# Variables that you are not likely to override.
#-------------------------------------------------------------------------------
mm_GARHOST           ?= $(strip \
                            $(if $(filter athlon64   ,$(mm_GARCH)),x86_64) \
                            $(if $(filter c3         ,$(mm_GARCH)),i586  ) \
                            $(if $(filter c3-2       ,$(mm_GARCH)),i586  ) \
                            $(if $(filter pentium-mmx,$(mm_GARCH)),i586  ) \
                         )-minimyth-linux-gnu
mm_NAME              ?= minimyth-$(mm_VERSION)
mm_NAME_PRETTY       ?= MiniMyth $(mm_VERSION)
mm_DESTDIR           ?= $(mm_HOME)/images/mm
mm_TFTPDIR           ?= $(mm_TFTP_ROOT)
mm_NFSDIR            ?= $(mm_NFS_ROOT)
mm_SOURCENAME        ?= gar-minimyth-$(mm_VERSION)
mm_KERNELNAME        ?= kernel-$(mm_NAME)
mm_ROOTFSNAME        ?= rootfs-$(mm_NAME)
mm_EXTRASNAME        ?= extras-$(mm_NAME)
mm_NFSNAME           ?= $(mm_NAME)
# The version of Myth checked out from SVN when mm_MYTH_VERSION=svn.
# If this is set, the patch files for myth/myth*-svn may fail.
mm_MYTH_VERSION_SVN  ?=

#-------------------------------------------------------------------------------
# Variables that you cannot override.
#-------------------------------------------------------------------------------
# Stop attempts to check out patches from perforce.
PATCH_GET=0
export PATCH_GET
