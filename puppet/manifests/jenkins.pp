Exec { 
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/usr/local/bin/" ]
}

package { 'java-1.7.0-openjdk.x86_64':
  ensure => present
}

class {'jenkins':
  require => Package['java-1.7.0-openjdk.x86_64']
} #->
#jenkins::plugin { 'greenballs':} 

firewall { '100 default jenkins host to guest port forward':
	port => [8080],
	proto => tcp,
	action => accept
}

class { 'nodejs':
	version => 'stable'
} ->

exec { 'get-grunt':
	command => 'npm install -g grunt-cli'
} ->
file { '/usr/local/bin/grunt':
	ensure => 'link',
	target => '/usr/local/node/node-v0.10.22/lib/node_modules/grunt-cli/bin/grunt'
}


# Couldn't get the grunt-cli package to work 
#    "Provider npm is not functional on this host"
# package {'grunt-cli':
#     ensure   => present,
#     provider => 'npm',
# #    target_dir => '/usr/local/bin'
# #    require  => Package['nodejs'],
# }
