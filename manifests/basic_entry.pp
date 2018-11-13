# Defines values for username and password
define basicauth::basic_entry (
  Optional[String[1]]    $user       = undef,
  Optional[String[1]]    $password   = undef,
  Enum['literal','hash'] $algorithm  = 'literal',
  String[1]              $hashtype   = 'md5',
  Stdlib::Unixpath       $location   = $::basicauth::location,
) {

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
