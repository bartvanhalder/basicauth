# Module description
A Kaliber Puppet module to generate files used for Basic Authentication

# Usage
This module creates files which can be used by webservers to look up authenticated users. It does not manage anything except the existense of the file itself. 

You will have to do any configuration of the webserver yourself. Or with another relevant Puppet module, ofcourse. 

Since this module requires some data to generate a basic authentication file, it does not do anything by default. 

## Example with Puppetcode
````
    include '::basicauth'

    basicauth::ensure   => 'present',
    basicauth::location => '/some/path/.some_file',

    basicauth::basic_entry { 'aap':
        user        => "aap",
        password    => "any literal string, externally generated hash or an eyaml hash",
    }

    basicauth::basic_entry { 'noot':
        user        => "noot",
        password    => "any literal string, externally generated hash or an eyaml hash",
        algorithm   => 'hash',
        hashtype    => 'SHA-512',
    }
````
## Example with Puppetcode and Hiera
### Puppet:
````
    include basicauth
````
### Hiera:
````
basicauth::ensure: 'present'

basicauth::basic_entry: 
  'aap':
    user:     'aap'
    password: 'some_hash_here'
  'noot':
    user:      'noot'
    password:  'this could be some eyaml hash'
    algorithm: 'hash'
    hashtype:  'SHA-512'
````

# Variables used by the module

````
basicauth (
    $owner      = 'www-data',
    $group      = 'www-data',
    $mode       = '0600',
    $location   = '/var/www/.basicauth',
    $ensure     = 'absent', # Don't do anything unless explicitly enabled
)
````

````
define basicauth::basic_entry(
    $user       = undef,
    $password   = undef,
    $algorithm  = 'literal',
    $hashtype   = 'md5',
    $location   = $::basicauth::location,
)
````

By using `literal` as algorithm you can use a literal string in plaintext or a bcrypt hash generated elsewhere. 

If you want to use cyphers supported by stdlib, you can choose `hash` as algorithm and supply an optional `hashtype`, which can currently be: `MD5`, `SHA-256` or `SHA-512`. If the [standard library](https://forge.puppet.com/puppetlabs/stdlib/) supports new crypt methods in the future, you can use these. 

