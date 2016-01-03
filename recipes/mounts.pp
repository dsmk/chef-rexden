# These are the common mounts for the media servers
# 
# vi:ts=2
#

class rexden::media::mounts (
  $media_prefix = "192.168.8.12:/mnt/nas/media",
) {
  include rexden::common::nfs_client

  file { "/opt/music" :
    ensure => directory,
  }

  rexden::nfs_client::mount { "/opt/music/active" :
    location => "$media_prefix/music/active",
    require => File['/opt/music'],
  }

  rexden::nfs_client::mount { "/opt/music/playlists" :
    location => "$media_prefix/music/playlists",
    options => "defaults,rw",
    require => File['/opt/music'],
  }

  rexden::nfs_client::mount { "/opt/video" :
    location => "$media_prefix/video/rexden",
  }

  rexden::nfs_client::mount { "/opt/video/staging" :
    location => "$media_prefix/video/staging",
    require => Mount['/opt/video'],
  }

}

