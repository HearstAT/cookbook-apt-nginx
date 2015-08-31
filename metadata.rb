name 'apt-nginx'
maintainer 'St. Isidore de Seville'
maintainer_email 'st.isidore.de.seville@gmail.com'
license 'MIT'
description 'Installs/Configures apt NGINX Vendor-Specific Repository'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

source_url 'https://github.com/st-isidore-de-seville/cookbook-apt-nginx'
issues_url 'https://github.com/st-isidore-de-seville/cookbook-apt-nginx/issues'

recipe 'apt-nginx::default', 'Installs/Configures apt NGINX Vendor-Specific Repository'

depends 'apt', '~> 2.8'

# Supported Platforms:
#  http://nginx.org/en/linux_packages.html
supports 'debian'
supports 'ubuntu'
