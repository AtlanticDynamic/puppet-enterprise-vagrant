
ini_setting {'autosign':
  path    => '/etc/puppetlabs/puppet/puppet.conf',
  section => 'master',
  setting => 'autosign',
  value   => 'true',
}~>
service {'pe-httpd':
  ensure => running,
  enable => true,
}
