#  Ark: simple nightly archiving of core files.  This
# serves as a replacement for backups for most VMs.
# 
# vi:ts=2
#

class rexden::media::plex (
  $plex_version = "0.9.12.19.1537-f38ac80",
) {

  include rexden::media::mounts
  
  $rpm_loc = "https://downloads.plex.tv/plex-media-server/${plex_version}/plexmediaserver-${plex_version}.x86_64.rpm"

  package { "plexmediaserver" :
    ensure => present,
    provider => rpm,
    source => $rpm_loc,
  }

  service { "plexmediaserver" :
    ensure => running,
    enable => true,
    require => Package['plexmediaserver'],
  }

  file { "/var/lib/plexmediaserver/Library" :
    ensure => directory,
    owner => plex,
    group => plex,
    mode => 0755,
    require => Package['plexmediaserver'],
  }

  file { "/var/lib/plexmediaserver/Library/Application Support" :
    ensure => directory,
    owner => plex,
    group => plex,
    mode => 0755,
    require => File['/var/lib/plexmediaserver/Library'],
  }

  file { "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server" :
    ensure => directory,
    owner => plex,
    group => plex,
    mode => 0755,
    require => File['/var/lib/plexmediaserver/Library/Application Support'],
  }

  file { "/etc/sysconfig/PlexMediaServer" :
    content => template('rexden/media/PlexMediaServer.erb'),
    owner => plex,
    group => plex,
    mode => 0600,
    require => Package['plexmediaserver'],
    notify => Service['plexmediaserver'],
  }

  # do the firewall stuff

  rexden::common::firewalld::service { "plex" :
    source => "puppet:///modules/rexden/media/plex.xml",
  }
}

