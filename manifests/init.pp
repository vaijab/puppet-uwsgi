# == Class: uwsgi
#
# This class installs and configures uWSGI Emperor service. If you
# want to configure and run uWSGI apps, see 'uwsgi::app' class.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# - Vaidas Jablonskis <jablonskis@gmail.com>
#
class uwsgi(
    $service = 'running',
    $onboot  = true,
    $package = 'installed',
) {
  case $::operatingsystem {
    Fedora: {
      $package_name   = 'uwsgi'
      $service_name   = 'uwsgi'
      $run_user       = 'uwsgi'
      $app_config_dir = '/etc/uwsgi.d'
    }
    Ubuntu: {
      $package_name   = 'uwsgi'
      $service_name   = 'uwsgi'
      $upstart_script = '/etc/init/uwsgi.conf'
      $run_user       = 'www-data'
      $app_config_dir = '/etc/uwsgi/apps-enabled'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  $config_file   = '/etc/uwsgi.ini'
  $conf_template = 'uwsgi.ini.erb'

  $default_plugins = ['uwsgi-plugin-python',
                      'uwsgi-plugin-psgi']

  package { $package_name:
    ensure => $package,
    before => Package[$default_plugins],
  }

  package { $default_plugins:
    ensure => installed,
  }

  # Since people who package software for Ubuntu/Debian still live in
  # the year of 1995, we have to suffer as well.
  # Let's install an Upstart script to be able to bypass the stupid init
  # script which comes by default.
  if $::operatingsystem == 'Ubuntu' {
    file { $upstart_script:
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/${module_name}/uwsgi_upstart.conf",
      before => [Package[$package_name], Service[$service_name]],
    }
  }

  file { $config_file:
    ensure  => file,
    require => Package[$package_name],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/${conf_template}"),
    notify  => Service[$service_name],
  }

  service { $service_name:
    ensure     => $service,
    enable     => $onboot,
    hasrestart => true,
    hasstatus  => true,
    require    => [ Package[$package_name],
                    Package[$default_plugins],
                    File[$config_file] ],
  }
}
