mm_VERSION     := 0.0.4

mm_HOME        := $(P4ROOT)/gar-minimyth
# Valid values mm_GARCH are c3 and c3-2
mm_GARCH       := c3
mm_GARHOST     := i586-minimyth-linux-gnu
mm_TFTP_ROOT   := /var/tftpboot/minimyth
mm_NFS_ROOT    := /home/public

mm_NAME        := gar-minimyth-$(mm_VERSION)-$(mm_GARCH)
mm_NAME_PRETTY := GAR Minimyth $(mm_VERSION) $(mm_GARCH)
mm_BASEDIR     := $(mm_HOME)/images/mm
mm_TFTPDIR     := $(mm_TFTP_ROOT)
mm_NFSDIR      := $(mm_NFS_ROOT)
mm_KERNELNAME  := kernel-$(mm_NAME)
mm_CRAMFSNAME  := rootfs-$(mm_NAME)
mm_EXTRASNAME  := extras-$(mm_NAME).tar.bz2
mm_NFSNAME     := $(mm_NAME)
mm_DESTDIR     := $(mm_BASEDIR)/rootfs-$(mm_NAME).d
mm_EXTRASDIR   := $(mm_BASEDIR)/extras-$(mm_NAME).d
