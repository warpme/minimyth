#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------

# The version of MiniMyth.
mm_VERSION        ?= 0.18.1.10

# The version of Myth to use.
# Valid values are 'stable', 'knoppmyth' and 'svn'.
mm_MYTH_VERSION   ?= stable

#-------------------------------------------------------------------------------
# Variables that you are likely to be override based on your environment.
#-------------------------------------------------------------------------------
# Indicates the Via microprocessor architecture.
# Valid values for mm_GARCH are 'c3', 'c3-2' and 'pentium-mmx'.
# Use 'c3' if you have a processor that uses a Samuel or Ezra core.
# Motherboards with Ezra based processors include:
#   EPIA M6000E, EPIA M9000 and EPIA M10000.
# Use 'c3-2' if you have a processor that uses a Nehemiah or Antaur core.
# Motherboards with Nehemiah based processors include:
#   EPIA M10000N and EPIA MII12000.
# Use 'pentium-mmx' if you want an image that will work on all EPIA M boards.
mm_GARCH          ?= pentium-mmx
# Indicates whether or not to install the CRAMFS (ramdisk) root file system image.
# Valid values for mm_INSTALL_CRAMFS are 'yes' and 'no'.
mm_INSTALL_CRAMFS ?= yes
# Indicates whether or not to install the NFS root file system image.
# Valid values for mm_INSTALL_NFS are 'yes' and 'no'.
mm_INSTALL_NFS    ?= no
# Indicates the directory where the GAR MiniMyth build system is installed.
mm_HOME           ?= $(P4ROOT)/gar-minimyth
# Indicates the pxeboot TFTP directory.
# The kernel and the CRAMFS image are installed in this directory.
mm_TFTP_ROOT      ?= /var/tftpboot/minimyth
# Indicates the directory in which the directory containing the NFS root file
# system image will be installed. The name of the directory containing the NFS
# root files sytem image is given by mm_NFSNAME.
mm_NFS_ROOT       ?= /home/public

#-------------------------------------------------------------------------------
# Variables that you are not likely to override.
#-------------------------------------------------------------------------------
mm_GARHOST        ?= i586-minimyth-linux-gnu
mm_NAME           ?= minimyth-$(mm_VERSION)
mm_NAME_PRETTY    ?= MiniMyth $(mm_VERSION)
mm_BASEDIR        ?= $(mm_HOME)/images/mm
mm_TFTPDIR        ?= $(mm_TFTP_ROOT)
mm_NFSDIR         ?= $(mm_NFS_ROOT)
mm_KERNELNAME     ?= kernel-$(mm_NAME)
mm_CRAMFSNAME     ?= rootfs-$(mm_NAME)
mm_EXTRASNAME     ?= extras-$(mm_NAME).cmg
mm_NFSNAME        ?= $(mm_NAME)
mm_DESTDIR        ?= $(mm_BASEDIR)/rootfs-$(mm_NAME).d
mm_EXTRASDIR      ?= $(mm_BASEDIR)/extras-$(mm_NAME).d

#-------------------------------------------------------------------------------
# Variables that you cannot override.
#-------------------------------------------------------------------------------
# Stop attempts to check out patches from perforce.
PATCH_GET=0
export PATCH_GET
