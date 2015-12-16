# Base docker status
# 
# vi:ts=2
#

class rexden::common::docker (
  $disable_firewalld = false,
) {

  if ($osfamily == 'RedHat') {
    package { "docker" :
      ensure => present,
    }

    service { "docker" :
      ensure => running,
      enable => true,
      require => Package['docker'],
    }

    group { "docker" : 
      gid => 1000,
      require => Package['docker'],
    }

    User <| title == 'dsmk' |> { groups +> "docker" }

    file { '/etc/sysconfig/docker' :
      content => template('rexden/common/sysconfig.docker.erb'),
      owner => root,
      group => root,
      mode => 0644,
      require => Package['docker'],
      notify => Service['docker'],
    }

    if ($disable_firewalld) {
      service { "firewalld" :
        ensure => stopped,
        enable => false,
      }
    }
  }
}

