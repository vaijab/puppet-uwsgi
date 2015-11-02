# == Class: uwsgi::app
#
# This class allows you to configure uWSGI apps.
#
# === Parameters
#
# See README.md
#
# === Authors
#
# - Vaidas Jablonskis <jablonskis@gmail.com>
#
class uwsgi::app inherits uwsgi {
  if defined('uwsgi::app') {
    create_resources(uwsgi::manage_app,
      hiera_hash('uwsgi::app', undef)
    )
  }
}
