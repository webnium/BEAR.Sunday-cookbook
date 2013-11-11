name             'bear-sunday'
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

supports "centos", ">= 6.0"

recipe "bear-sunday", "Install BEAR.Package"
recipe "bear-sunday::environment", "Setup environment requried by BEAR.Sunday"
recipe "bear-sunday::nginx", "Install nginx environment for a BEAR.Sunday application"