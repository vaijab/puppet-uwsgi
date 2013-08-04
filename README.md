uwsgi
===
This module installs and configures uWSGI Emperor service. If you
want to configure and run uWSGI apps, see `uwsgi::app` class.

This module is most flexible and most easier to manage when used with hiera.

## Classes

### uwsgi

#### Parameters
* `package` - used to specify what version of the package should be used.
Valid values: `installed`, `absent` or specific package version. Default:
`installed`. Note: Puppet cannot downgrade packages.

* `service` - service state. Valid values: `running` or `stopped`.
Default: `running`.

* `onboot` - whether to enable or disable the service on boot. Valid values:
`true`, `false` or `manual`. Default: `true`.


#### Examples
    ---
    classes:
      - uwsgi

### uwsgi::app
This class allows you to configure uWSGI apps.

#### Parameters
* `ensure` - Determines the state of the application configuration.
Default: `present`. Valid values: `present` or `absent`.

* `config` - Valid uwsgi app specific configuration. It is a hash, so any
uwsgi valid key-value pairs parameters.

* `uid` - User name to run uwsgi process on for this app. User must exist.
Default: `www-data` for Ubuntu/Debian and `uwsgi` for Fedora/RedHat.

* `gid` - User group name to run uwsgi process on for this app. Group must exist.
Default: `www-data` for Ubuntu/Debian and `uwsgi` for Fedora/RedHat.


#### Examples
    ---
    classes:
      - uwsgi::app
    
    uwsgi::app:
      'graphite':
        ensure: 'present'
        uid: '_graphite'
        gid: '_graphite'
        config:
          socket: ':20010'
          processes: 4
          wsgi-file: '/usr/share/graphite-web/graphite.wsgi'
          plugins: python


## Authors
* Vaidas Jablonskis <jablonskis@gmail.com>

