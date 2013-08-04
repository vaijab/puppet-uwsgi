# == Defined Type: uwsgi::manage_app
#
# This defined type sets up uwsgi apps from a hash.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# - Vaidas Jablonskis <jablonskis@gmail.com>
#
define uwsgi::manage_app(
  $ensure = present,
  $config = undef,
  $uid    = $::uwsgi::run_user,
  $gid    = $::uwsgi::run_user,
) {
  $conf_template = 'uwsgi_app.ini.erb'

  file { "${::uwsgi::app_config_dir}/${title}.ini":
    ensure  => $ensure,
    owner   => $uid,
    group   => $gid,
    mode    => '0644',
    content => template("${module_name}/${conf_template}"),
    require => Package[$::uwsgi::package_name],
  }
}
