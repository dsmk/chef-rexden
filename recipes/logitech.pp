#  Ark: simple nightly archiving of core files.  This
# serves as a replacement for backups for most VMs.
# 
# vi:ts=2
#

class rexden::media::logitech (
  $version = "7.7.5",
) {

  include rexden::media::mounts
 
  $rpm_loc = "http://downloads.slimdevices.com/LogitechMediaServer_v${version}/logitechmediaserver-${version}-1.noarch.rpm"

  package { "perl-CGI-Session" :
    ensure => present,
  }

  package { "logitechmediaserver" :
    ensure => present,
    provider => rpm,
    source => $rpm_loc,
    require => Package['perl-CGI-Session'],
  }

  file { "/usr/share/perl5/vendor_perl/Slim" :
    ensure => link,
    target => "/usr/lib/perl5/vendor_perl/Slim",
    require => Package['logitechmediaserver'],
  }


  service { "squeezeboxserver" :
    ensure => running,
    enable => true,
    require => Package['logitechmediaserver'],
  }

  # do the firewall stuff

  rexden::common::firewalld::service { "logitech" :
    source => "puppet:///modules/rexden/media/logitech.xml",
  }
}

