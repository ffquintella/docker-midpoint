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

-> exec {'Download Mysql Connector':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "wget -nv https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz",
  cwd     => '/opt',
  require => Package['wget'],
}
-> exec {'Uncompress Mysql Connector':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "tar zxf mysql-connector-java-5.1.42.tar.gz -C /opt",
  cwd     => '/opt',
}
-> exec {'Move Mysql Connector':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "mv mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar ${tomcat_home}/lib/mysql-connector-java.jar",
  cwd     => '/opt',
}
-> exec {'Removing downloaded Mysql Connector file':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "rm mysql-connector-java-5.1.42.tar.gz",
  cwd     => '/opt',
}
-> exec {'Removing downloaded Mysql Connector dir':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "rm -rf mysql-connector-java-5.1.42",
  cwd     => '/opt',
}

/*
-> exec {'Download Oracle Connector':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "wget -nv http://download.oracle.com/otn/utilities_drivers/jdbc/121010/ojdbc7.jar",
  cwd     => '/opt',
  require => Package['wget'],
}
-> exec {'Move Oracle Connector':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "mv ojdbc7.jar ${tomcat_home}/lib/",
  cwd     => '/opt',
}

-> exec {'Fix Permissions':
  path    => ['/usr/bin', '/bin', '/sbin', '/usr/sbin'],
  command => "chown -R tomcat:tomcat ${tomcat_home}/lib/*",
  cwd     => '/opt',
}*/
