package {'sudo':
  ensure => present
}

package {'bzip2':
  ensure => present
}

package {'wget':
  ensure => present
}

file{ '/etc/yum.repos.d/epel.repo':
  ensure => present,
  content => '[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=0'
}

file{ $java_home:
  ensure => directory,
}

-> class { 'jdk_oracle':
  version     => $java_version,
  install_dir => $java_home,
  version_update => $java_version_update,
  version_build  => $java_version_build,
  version_hash  => $java_version_hash,
  package     => 'server-jre'
}

-> tomcat::install { $tomcat_home:
  source_url => $tomcat_url,
}
-> tomcat::instance { 'default':
  catalina_home => $tomcat_home,
}

-> file{ $midpoint_home:
  ensure => directory,
  owner  => 'tomcat',
  group  => 'tomcat',
}

-> exec {'Download MidPoint':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "wget -nv https://evolveum.com/downloads/midpoint/${midpoint_version}/midpoint-${midpoint_version}-dist.tar.bz2",
  cwd     => '/opt',
  require => Package['wget'],
}
-> exec {'Uncompress MidPoint':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "tar xjf midpoint-${midpoint_version}-dist.tar.bz2 -C /opt",
  cwd     => '/opt',
}
-> exec {'Rename MidPoint dir':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "mv midpoint-${midpoint_version} ${midpoint_install_dir}",
  cwd     => '/opt',
}
-> exec {'Removing downloaded file':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "rm midpoint-${midpoint_version}-dist.tar.bz2",
  cwd     => '/opt',
}
-> exec {'Coping WAR':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "cp ${midpoint_install_dir}/war/midpoint.war ${tomcat_home}/webapps/midpoint.war",
  cwd     => '/opt',
}


#wget -nv https://evolveum.com/downloads/midpoint/${v}/midpoint-${v}-dist.tar.bz2 \
#&& tar xjf midpoint-${v}-dist.tar.bz2 -C /opt \
#&& rm -f midpoint-${v}-dist.tar.bz2

/*
file { '/etc/pki/tls/certs/java':
  ensure  => directory
} ->

file { '/etc/pki/tls/certs/java/cacerts':
  ensure  => link,
  target  => '/etc/pki/ca-trust/extracted/java/cacerts'
} ->

file { "/opt/java_home/jdk1.${java_version}.0_${java_version_update}/jre/lib/security/cacerts":
  ensure  => link,
  target  => '/etc/pki/tls/certs/java/cacerts'
}

# Install rundeck repo
exec {'Install repository':
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  command => 'rpm -Uvh http://repo.rundeck.org/latest.rpm',
  creates => '/etc/yum.repos.d/rundeck.repo',
} ->

# Full update
exec {'Full update':
  path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  command => 'yum -y update',
  timeout => 1800,
} ->

package {'rundeck':
  ensure => $rundeck_version,
} ->
package {'rundeck-config':
  ensure => $rundeck_version,
} ->

file { '/d_bck':
  ensure  => directory,
} ->

file { '/d_bck/rundeck':
  ensure  => directory,
  recurse => true,
  purge   => true,
  source  => 'file:///etc/rundeck',
} ->

# Cleaning unused packages to decrease image size
exec {'erase installer':
  path  => '/bin:/sbin:/usr/bin:/usr/sbin',
  command => 'rm -rf /tmp/*; rm -rf /opt/staging/*'
} ->

exec {'erase cache':
  path  => '/bin:/sbin:/usr/bin:/usr/sbin',
  command => 'rm -rf /var/cache/*'
}


package {'rhn-check': ensure => absent }
package {'rhn-client-tools': ensure => absent }
package {'rhn-setup': ensure => absent }
package {'rhnlib': ensure => absent }

package {'/usr/share/kde4':
  ensure => absent
}
*/
