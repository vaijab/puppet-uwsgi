uwsgi
===
This module installs [uWSGI][] and configures it for [Emperor mode][]. If you
want to configure and run uWSGI apps, see the `uwsgi::app` class.

This module is most flexible and easiest to manage when used with [Hiera][].

[uWSGI]: http://uwsgi-docs.readthedocs.org/en/latest/index.html
[Emperor mode]: http://uwsgi-docs.readthedocs.org/en/latest/Emperor.html
[Hiera]: http://docs.puppetlabs.com/hiera/1/index.html

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

* `config` - Valid [uWSGI configuration options][] for the uWSGI server. It is a hash, so any
uWSGI valid key-value pairs as parameters.

[uWSGI configuration options]: http://uwsgi-docs.readthedocs.org/en/latest/Options.html


#### Examples
    ---
    classes:
      - uwsgi
    
    # override default params
    uwsgi::onboot: manual
    
    # Add extra configs to default wsgi config
    uwsgi::config:
      chmod-socket: 664

### uwsgi::app
This class allows you to configure uWSGI apps.

#### Parameters
* `ensure` - Determines the state of the application configuration.
Default: `present`. Valid values: `present` or `absent`.

* `config` - Valid [uWSGI configuration options][] specific to an app. It is a hash, so any
uWSGI valid key-value pairs as parameters.

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

