class basicauth (
    $owner      = 'www-data',
    $group      = 'www-data',
    $mode       = '0600',
    $location   = '/var/www/.basicauth',
    $ensure     = 'absent', # Do not do anything unless explicitly enabled
)
{

    if $ensure == 'present' {

        concat { $location:
            owner => "$owner",
            group => "$group",
            mode  => "$mode",
        }

        concat::fragment{ 'file-header':
            target  => $location,
            content => "#This file is generated by Puppet, do not change manually!\n",
            order   => '01',
        } 
    }

    define basic_entry(
        $user       = undef,
        $password   = undef,
    ) 
    {
        concat::fragment{ "basicauth_fragment_$user":
            #always the same location as the main class
            target  => "$::basicauth::location", 
            order   => '10',
            content => "$user:$password\n",
        }
    }   
}
