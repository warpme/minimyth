################################################################################
# MM_VERSION configuration variable handlers.
################################################################################
package init::conf::MM_VERSION;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_VERSION_MYTH_BINARY'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $version = '';
        if ((-x '/usr/bin/mythfrontend') &&
            (open(FILE, '-|', '/usr/bin/mythfrontend --version')))
        {
            while (<FILE>)
            {
                chomp;
                if (/^Library API[^:]*: *(.*)$/)
                {
                    $version = $1;
                    last;
                }
            }
            close(FILE);
        }
        return $version;
    }
};
$var_list{'MM_VERSION_MYTH_BINARY_MAJOR'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $version = $minimyth->var_get('MM_VERSION_MYTH_BINARY');
        $version =~ s/^([^.]*)\.([^.]*)\.(.*)$/$1/;

        return $version;
    }
};
$var_list{'MM_VERSION_MYTH_BINARY_MINOR'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $version = $minimyth->var_get('MM_VERSION_MYTH_BINARY');
        $version =~ s/^([^.]*)\.([^.]*)\.(.*)$/$2/;

        return $version;
    }
};
$var_list{'MM_VERSION_MYTH_BINARY_TEENY'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $version = $minimyth->var_get('MM_VERSION_MYTH_BINARY');
        $version =~ s/^([^.]*)\.([^.]*)\.(.*)$/$3/;
        $version =~ s/^([^-]*)-(.*)$/$1/;

        return $version;
    }
};
$var_list{'MM_VERSION_MYTH_BINARY_EXTRA'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $version = $minimyth->var_get('MM_VERSION_MYTH_BINARY');
        $version =~ s/^([^.]*)\.([^.]*)\.(.*)/$3/;
        $version =~ s/^([^-]*)-(.*)$/$2/;

        return $version;
    }
};

1;
