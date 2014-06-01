Ini_setting {
  path    => '/etc/puppetlabs/puppet/puppet.conf',
  notify  => Service['pe-httpd'],
}

ini_setting {'modulepath':
  section => 'main',
  setting => 'modulepath',
  value   => '$confdir/environments/$environment/modules:$confdir/environments/$environment/:$confdir/modules:/opt/puppet/share/puppet/modules',
}

ini_setting {'manifest':
  section => 'master',
  setting => 'manifest',
  value   => '$confdir/environments/$environment/manifests/site.pp',
}

service {'pe-httpd':
  ensure => running,
  enable => true,
}

