# Defines values for username and password
define basicauth::basic_entry(
    $user       = undef,
    $password   = undef,
    $algorithm  = 'literal',
    $hashtype   = 'md5',
    $location   = $::basicauth::location,
)
{
    include ::stdlib

    case $algorithm  {
        'hash': {
            $seed            = fqdn_rand_string(10, '', '4dKqzRr4XUBzL2QD8hLw')
            $hashed_password = pw_hash($password, $hashtype, $seed)
            $content         = "${user}:${hashed_password},\n"
        }
        default: {
            $content         = "${user}:${password}\n"
        }
    }

    concat::fragment{ "basicauth_fragment_${user}":
        # always the same location as the main class
        target  => $location,
        order   => '10',
        content => $content,
    }
}
