# Defines values for username and password
define basicauth::basic_entry(
    $user       = undef,
    $password   = undef,
    $algorithm  = 'literal',
    $hashtype   = 'md5',
)
{
    include ::stdlib

    case $algorithm  {
        default: {
            # this includes the 'literal' option
            concat::fragment{ "basicauth_fragment_${user}":
                # always the same location as the main class
                target  => $::basicauth::location,
                order   => '10',
                content => "${user}:${password}\n",
            }
        }
        'hash': {
            $seed            = fqdn_rand_string(10, '', '4dKqzRr4XUBzL2QD8hLw')
            $hashed_password = pw_hash($password, $hashtype, $seed)

            concat::fragment{ "basicauth_fragment_${user}":
                # always the same location as the main class
                target  => $::basicauth::location,
                order   => '10',
                content => "${user}:${hashed_password},\n",
            }
        }
    }
}
