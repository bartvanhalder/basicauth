node 'some_node' {

    class { 'basicauth':
        ensure  => 'present',
    }

    basicauth::basic_entry { 'aap':
        user        => "aap",
        password    => "some_hash_here",
    }

    basicauth::basic_entry { 'noot':
        user        => "noot",
        password    => "another_hash_here",
    }

}
