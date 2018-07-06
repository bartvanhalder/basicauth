# Module description
A Kaliber Puppet module to generate files used for Basic Authentication

# Usage
This module creates files which can be used by webservers to look up authenticated users. It does not manage anything except the existense of the file itself. 

You will have to do any configuration of the webserver yourself. Or with another relevant Puppet module, ofcourse. 

# Does not do anything by default
Since we will include this module in a role where it will not be used all the time, the default behaviour is to do nothing. 

Only by setting the variable $::klbr_basicauth::ensure to 'present' will this module manage a file. 

Without defining some '$::klbr_basicauth::basic_entry' instances nothing will be written to this file.

## Example with Puppetcode
````
    class { 'klbr_basicauth':
        ensure  => 'present',
    }

    klbr_basicauth::basic_entry { 'aap':
        user        => "aap",
        password    => "some_hash_here",
    }

    klbr_basicauth::basic_entry { 'noot':
        user        => "noot",
        password    => "another_hash_here",
    }
````
## Puppet and Hiera
### Puppet:
````
    include klbr_basicauth

    $entry = hiera('klbr_basicauth::basic_entry', {})
    create_resources('klbr_basicauth::basic_entry', $entry)
````
### Hiera:
````
klbr_basicauth::ensure: 'present'

klbr_basicauth::basic_entry: 
  'aap':
    user: 'aap'
    password: 'some_hash_here'
  'noot':
    user: 'noot'
````

# Variables used by the module

````
klbr_basicauth (
    $owner      = 'www-data',
    $group      = 'www-data',
    $mode       = '0600',
    $location   = '/var/www/.basicauth',
    $ensure     = 'absent', # Don't do anything unless explicitly enabled
)
````

````
    define basic_entry(
        $user       = undef,
        $password   = undef,
    ) 
````