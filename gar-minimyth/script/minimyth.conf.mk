#-------------------------------------------------------------------------------
# Values in this file can be overridden by including the desired value in
# '$(HOME)/.minimyth/minimyth.conf.mk'.
#-------------------------------------------------------------------------------

# The version of GAR MiniMyth.
mm_VERSION        ?= 0.0.5

#-------------------------------------------------------------------------------
# Variables that you are likely to be override based on your environment.
#-------------------------------------------------------------------------------
# Indicates the Via microprocessor architecture.
# Valid values for mm_GARCH are 'c3' and 'c3-2'.
mm_GARCH          ?= c3
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
mm_NAME           ?= gar-minimyth-$(mm_VERSION)-$(mm_GARCH)
mm_NAME_PRETTY    ?= GAR Minimyth $(mm_VERSION) $(mm_GARCH)
mm_BASEDIR        ?= $(mm_HOME)/images/mm
mm_TFTPDIR        ?= $(mm_TFTP_ROOT)
mm_NFSDIR         ?= $(mm_NFS_ROOT)
mm_KERNELNAME     ?= kernel-$(mm_NAME)
mm_CRAMFSNAME     ?= rootfs-$(mm_NAME)
mm_EXTRASNAME     ?= extras-$(mm_NAME).tar.bz2
mm_NFSNAME        ?= $(mm_NAME)
mm_DESTDIR        ?= $(mm_BASEDIR)/rootfs-$(mm_NAME).d
mm_EXTRASDIR      ?= $(mm_BASEDIR)/extras-$(mm_NAME).d
