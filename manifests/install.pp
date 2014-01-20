class smokeping::install {

    package { 'smokeping':
        ensure => $smokeping::version
    }

    if ! defined (Package['fping']) {
        package {'fping': ensure => installed; }
    }

    case $operatingsystem {
        'Debian', 'Ubuntu': { $perldoc_package = 'perl-doc' }
        default: { $perldoc_package = 'perl' } #typically perldoc comes with perl
    }

    if ! defined (Package[$perldoc_package]) {
        package {$perldoc_package: ensure => installed; }
    }

    # correct permissions
    file {
        $smokeping::path_datadir:
            ensure  => directory,
            owner   => $smokeping::daemon_user,
            group   => $smokeping::daemon_group,
            recurse => true;
        $smokeping::path_piddir:
            ensure  => directory,
            owner   => $smokeping::daemon_user,
            group   => $smokeping::daemon_group,
            recurse => true;
        $smokeping::path_imgcache:
            ensure  => directory,
            owner   => $smokeping::webserver_user,
            group   => $smokeping::webserver_group,
            recurse => true;
    }

}
