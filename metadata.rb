name             'bearsunday'
maintainer       'Webnium, Inc'
maintainer_email 'koichi@webnium.co.jp'
license          'BSD'
description      'Installs and maintains BEAR.Sunday and its applications'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'php'
depends 'nginx'
depends 'yum'
depends 'composer'
depends 'php-fpm'
depends 'mysql'

supports "centos", ">= 6.0"

recipe "bearsunday", "Install BEAR.Package"
recipe "bearsunday::environment", "Setup environment requried by BEAR.Sunday"
recipe "bearsunday::nginx", "Install nginx environment for a BEAR.Sunday application"
