class lamp (
$htaccess = true,
)
{



package { ['httpd',
           'php']:
  ensure => 'installed',
} ->
file { '/etc/httpd/conf/httpd.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/httpd.conf.erb"),
} ~>
service { 'httpd':
  ensure  => 'running',
  enable  => 'true',
  require => Package['httpd'],
}


file { '/var/www/html/index.php':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/index.php",
}

package { 'mysql-server':
  ensure => 'installed',
} ->
file { '/etc/my.cnf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/my.cnf.erb"),
      
} ~>
service { 'mysqld':
  ensure => 'running',
  enable => 'true',
  require => Package['mysql-server'],
}

}

