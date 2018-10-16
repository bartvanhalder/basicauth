# Defines values for username and password
define basicauth::basic_entry(
    $user       = undef,
    $password   = undef,
    $algorithm  = 'literal'
)
{

    case $algorithm  {
        default: {
            concat::fragment{ "basicauth_fragment_${user}":
                # always the same location as the main class
                target  => $::basicauth::location,
                order   => '10',
                content => "${user}:${password}\n",
            }
        }
        # 'md5': {
        #     notify { 'md5 algorithm':
        #         name    => 'md5',
        #         message => 'md5',
        #     }
        # }
        # 'bcrypt': {
        #     notify { 'bcrypt algorithm':
        #         name    => 'bcrypt',
        #         message => 'bcrypt',
        #     }
        # }

    }
}
