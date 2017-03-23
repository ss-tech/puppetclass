define users::managed_user (
    $homedir = "/home/${title}",
    $usergroup = $title,
) {
    user { $title:
        ensure      => present,
        home        => $homedir,
        managehome  => true,
        gid         =>  $usergroup,
    }
    
    file { "${homedir}/.ssh":
        ensure  => directory,
        owner   => $title,
        group   => $usergroup,
        mode    => '0700',
    }
    
    file { "${homedir}/.bashrc":
        ensure    => file,
        owner   =>  $title,
        group   =>  $usergroup,
        mode    =>  "0700",
        content =>  "echo 'Have a nice day' | cowsay",
    }

}
