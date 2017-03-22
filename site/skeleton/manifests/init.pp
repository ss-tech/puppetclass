
class skeleton {
    file { "/etc/skel":
        ensure => directory,
    }
    
    file { "/etc/skel/.bashrc":
        ensure => file,
        source => 'puppet:///skeleton/bashrc',
        require => File['/etc/skel'],
    }
}
    
            
