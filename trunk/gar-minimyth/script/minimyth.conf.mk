#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------

# The version of MiniMyth.
mm_VERSION           ?= 0.18.1.11

# The version of Myth to use.
# Valid values are 'stable', 'knoppmyth' and 'svn'.
mm_MYTH_VERSION      ?= stable

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
