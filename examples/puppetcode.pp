node 'some_node' {

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

}
