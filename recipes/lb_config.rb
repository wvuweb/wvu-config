#
# Cookbook Name::
# Recipe:: lb_config
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

def service_name
  node['platform_family'] == 'debian' ? 'apache2' : 'httpd'
end

def conf_dir
  File.join('/', 'etc', service_name)
end

# Delete the default 000-default.conf
file '/var/apache2/sites-available/000-default.conf' do
  action :delete
end

template File.join(conf_dir,'sites-available','000-default.conf') do
  owner 'root'
  group 'root'
  mode '0644'
  source '000-default.vhost.conf.erb'
  notifies :restart, service_name, :delayed)
end