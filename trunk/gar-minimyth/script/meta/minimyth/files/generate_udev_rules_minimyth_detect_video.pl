#!/usr/bin/perl

sub modalias
{
    $vendor = shift;
    $product = shift;

    $vendor = uc($vendor);
    $product = uc($product);

    return "pci:v0000" . $vendor . "d0000" . $product . "sv0000????sd0000????bc03sc00i??";
}

my %entries = undef;

my $outfile_udev_rules = qq(05-minimyth-detect-video.rules.disabled);
die qq(error: output file $outfile_udev_rules already exists.\n) if (-e $outfile_udev_rules);

my $tmpfile_udev_rules = qq(/tmp/$$.05-minimyth-detect-video.rules.disabled);
die qq(error: temporary file $tmpfile_udev_rules already exists.\n) if (-e $tmpfile_udev_rules);

my $tmpfile_pciids_txt = qq(/tmp/$$.pciids.txt);
die qq(error: temporary file $tmpfile_pciids_txt already exists.\n) if (-e $tmpfile_pciids_txt);

system(qq(wget 'http://cgit.freedesktop.org/mesa/drm/plain/shared-core/drm_pciids.txt' -O $tmpfile_pciids_txt));
die qq(error: failed to download DRM PCI ids file.\n) if (! -e $tmpfile_pciids_txt);
if (open(FILE, '<', qq($tmpfile_pciids_txt)))
{
    my $driver = undef;
    while (<FILE>)
    {
        if    (/^\[i810\]$/)   { $driver = q(intel_810);  }
        elsif (/^\[i915\]$/)   { $driver = q(intel_915);  }
        elsif (/^\[viadrv\]$/) { $driver = q(openchrome); }
        elsif (/^\[savage\]$/) { $driver = q(savage);     }
        elsif (/^\[sis\]$/)    { $driver = q(sis);        }
        elsif (/^\[.*\]$/)     { $driver = undef;         }
        if (defined($driver))
        {
            if (/^0x(....) 0x(....) /)
            {
                my $vendor  = uc($1);
                my $product = uc($2);
                $entries{qq($vendor.$product)} = $driver;
            }
        }
    }
    close(FILE);
}
unlink(qq($tmpfile_pciids_txt));

system(qq(wget 'http://cgit.freedesktop.org/xorg/driver/xf86-video-radeonhd/plain/src/rhd_id.c' -O $tmpfile_pciids_txt));
die qq(error: failed to download xf86-video-radeonhd PCI ids file.\n) if (! -e $tmpfile_pciids_txt);
if (open(FILE, '<', qq($tmpfile_pciids_txt)))
{
    my $driver = undef;
    while (<FILE>)
    {
        if (/^ *const *PCI_ID_LIST *= *{/)
        {
            $driver = 'radeonhd';
            last;
        }
    }
    while (<FILE>)
    {
        if (defined($driver))
        {
            if (/^ *RHD_DEVICE_MATCH\( *0x(....) *,/)
            {
                my $vendor  = uc(q(1002));
                my $product = uc($1);
                $entries{qq($vendor.$product)} = $driver;
            }
        }
        if (/^ *} *;/)
        {
            $driver = undef;
            last;
        }
    }
    close(FILE);
}
unlink(qq($tmpfile_pciids_txt));

system(qq(wget 'http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/plain/src/radeon_chipinfo_gen.h' -O $tmpfile_pciids_txt));
die qq(error: failed to download xf86-video-ati PCI ids file.\n) if (! -e $tmpfile_pciids_txt);
if (open(FILE, '<', qq($tmpfile_pciids_txt)))
{
    my $driver = undef;
    while (<FILE>)
    {
        if (/^ *(static +)?RADEONCardInfo +RADEONCards\[\] *= *{/)
        {
            $driver = 'radeon';
            last;
        }
    }
    while (<FILE>)
    {
        if (defined($driver))
        {
            if (/^ *{ *0x(....),/)
            {
                my $vendor  = uc(q(1002));
                my $product = uc($1);
                $entries{qq($vendor.$product)} = $driver;
            }
        }
        if (/^ *} *;/)
        {
            $driver = undef;
            last;
        }
    }
    close(FILE);
}
unlink(qq($tmpfile_pciids_txt));

# NVIDIA.
{
    my $vendor = q(10DE);
    {
        my $driver= q(nvidia);
        my $product = q(????);
        $entries{qq($vendor.$product)} = $driver;
    }
    {
        my $driver= q(nv);
        foreach my $product (qw(0020 0028 0029 002c 002d 00a0 0100 0101 0103 0150 0151 0152 0153))
        {
            $entries{qq($vendor.$product)} = $driver;
        }
    }

}

# VMWare.
{
    my $vendor = q(15AD);
    {
        my $driver= q(vmware);
        my $product = q(0405);
        $entries{qq($vendor.$product)} = $driver;
    }
}

if (open(FILE, '>', qq($outfile_udev_rules)))
{
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(# Detect video devices.\n);
    print FILE qq(#\n);
    print FILE qq(# mm_detect_state_video has the following format:\n);
    print FILE qq(#     <driver>\n);
    print FILE qq(# where\n);
    print FILE qq(#     <driver>: The X video driver. Actually, this is the 'Identifier' \(sans the\n);
    print FILE qq(#               'Device_' prefix\) of the 'Device' section in the\n);
    print FILE qq(#               '/etc/xorg.conf' file.\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(ACTION!="add|change|remove", GOTO="end"\n);
    print FILE qq(SUBSYSTEM=="pci", ATTR{class}=="0x0300??", GOTO="begin"\n);
    print FILE qq(GOTO="end"\n);
    print FILE qq(LABEL="begin"\n);
    print FILE qq(\n);
    print FILE qq(ENV{mm_detect_state_video}=""\n);
    print FILE qq(\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(# autogenerated from:\n);
    print FILE qq(# http://cgit.freedesktop.org/mesa/drm/plain/shared-core/drm_pciids.txt\n);
    print FILE qq(# http://cgit.freedesktop.org/xorg/driver/xf86-video-radeonhd/plain/src/rhd_id.c\n);
    print FILE qq(# http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/plain/src/radeon_chipinfo_gen.h\n);
    print FILE qq(# built-in nvidia/nv driver information\n);
    print FILE qq(# built-in vmdriver driver information\n);
    print FILE qq(#-------------------------------------------------------------------------------\n);
    print FILE qq(\n);
    my $vendor_previous = undef;
    my @keys = sort
    {
        my ($a_vendor, $a_product) = split(/\./, $a);
        my ($b_vendor, $b_product) = split(/\./, $b);

        if ($a_vendor eq $b_vendor)
        {
            if    ($a_product eq '????') { return -1;                        }
            elsif ($b_product eq '????') { return  1;                        }
            else                         { return $a_product cmp $b_product; }
        }
        else
        {
            return $a_vendor cmp $b_vendor;
        }
    } keys(%entries);
    foreach my $key (@keys)
    {
        if ($key)
        {
            my ($vendor, $product) = split(/\./, $key);
            my $driver = $entries{$key};
            if ((! defined($vendor_previous)) || ($vendor != $vendor_previous))
            {
                if (defined($vendor_previous))
                {
                    print FILE qq(  LABEL="end-$vendor_previous"\n);
                    print FILE qq(\n);
                }
                my $modalias = modalias($vendor, q(????));
                print FILE qq(  ENV{MODALIAS}!="$modalias", GOTO="end-$vendor"\n);
                $vendor_previous = $vendor;
            }
            my $modalias = modalias($vendor, $product);
            print FILE qq(  ENV{MODALIAS}=="$modalias", ENV{mm_detect_state_video}="$driver"\n);

        }
    }
    if (defined($vendor_previous))
    {
        print FILE qq(  LABEL="end-$vendor_previous"\n);
        print FILE qq(\n);
    }
    print FILE qq(# The state has been set, so save it.\n);
    print FILE qq(ENV{mm_detect_state_video}=="?*", RUN+="/lib/udev/mm_detect video %k \$env{mm_detect_state_video}"\n);
    print FILE qq(\n);
    print FILE qq(LABEL="end"\n);
    close(FILE);
  }

1;
