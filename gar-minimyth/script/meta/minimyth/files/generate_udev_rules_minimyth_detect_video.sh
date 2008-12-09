#!/bin/sh
################################################################################
# generate_udev_rules_minimyth_detect_video.sh
#
# This script creates the MiniMyth udev X video driver detection rules that are
# based on the drm_pciids.txt tile.
#
# First, it downloads the drm_pciids.txt file from the DRM GIT repository using
# the repository's web interface.
# Second, it uses AWK to process the drm_pciids.txt it matching rules for the
# 05-minimyth-detect-video.rules file.
# Third, it outputs the matching rules to the file
# 05-minimyth-detect-video.rules.generated in the current working directory.
################################################################################

script='BEGIN {
            FS="\n"
            RS=""
        }
        $1 !~ /^\[.*\]$/ { 
            next
        }
        {
            x = 1

            mm_detect_state_video = $x
            sub(/^\[/, "", mm_detect_state_video 
            sub(/\]$/, "", mm_detect_state_video 
            if ( mm_detect_state_video ~ /^i810$/ ) {
                mm_detect_state_video = "intel_810"
            }
            if ( mm_detect_state_video ~ /^i915$/ ) {
                mm_detect_state_video = "intel_915"
            }
            if ( mm_detect_state_video ~ /^viadrv$/ ) {
                mm_detect_state_video = "openchrome"
            }
            if ( ( mm_detect_state_video !~ /^intel_810$/  ) &&
                 ( mm_detect_state_video !~ /^intel_915$/  ) &&
                 ( mm_detect_state_video !~ /^openchrome$/ ) &&
                 ( mm_detect_state_video !~ /^radeon$/     ) &&
                 ( mm_detect_state_video !~ /^savage$/     ) &&
                 ( mm_detect_state_video !~ /^sis$/        ) ) {
                next
            }

            while ( x < NF ) {
                x++

                vendor = $x
                sub(/ .*$/, "", vendor)
                sub(/^0x/, "", vendor)
                vendor = tolower(vendor)

                device = $x
                sub(/^[^ ]* /, "", device)
                sub(/ .*$/, "", device)
                sub(/^0x/, "", device)
                device = tolower(device)

                mm_detect_id = "pci:0300:00:" vendor ":" device ":????:????"
                print "  ENV{mm_detect_id}==" "\"" mm_detect_id "\"" ", " "ENV{mm_detect_state_video =" "\"" mm_detect_state_video "\""
            }
        }'

outfile_udev_rules="05-minimyth-detect-video.rules.generated"
if test -e ${outfile_udev_rules} ; then
    echo "error: output file ${outfile_udev_rules} already exists."
    exit 1
fi
tmpfile_udev_rules="/tmp/$$.05-minimyth-detect-video.rules.generated"
if test -e ${tmpfile_udev_rules} ; then
    echo "error: temporary file ${tmpfile_udev_rules} already exists."
    exit 1
fi
tmpfile_drm_pciids_txt="/tmp/$$.drm_pciids.txt"
if test -e ${tmpfile_drm_pciids_txt} ; then
    echo "error: temporary file ${tmpfile_drm_pciids_txt} already exists."
    exit 1
fi

wget 'http://gitweb.freedesktop.org/?p=mesa/drm.git;a=blob_plain;f=shared-core/drm_pciids.txt' -O ${tmpfile_drm_pciids_txt}
if test ! -e ${tmpfile_drm_pciids_txt} ; then
    echo "error: failed to download DRM PCI ids file."
    exit 1
fi

awk "${script}" ${tmpfile_drm_pciids_txt} | sort > ${tmpfile_udev_rules}
if test $? -ne 0 ; then
    echo "error: failed to generate udev rules from DRM PCI ids file."
    exit 1
fi

cp -f ${tmpfile_udev_rules} ${outfile_udev_rules}

rm -rf ${tmpfile_drm_pciids_txt}
rm -rf ${tmpfile_udev_rules}

exit 0
