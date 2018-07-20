# Defines values for username and password
define basicauth::basic_entry(
    $user       = undef,
    $password   = undef,
)
{
    concat::fragment{ "basicauth_fragment_${user}":
        # always the same location as the main class
        target  => $::basicauth::location,
        order   => '10',
        content => "${user}:${password}\n",
    }
}
