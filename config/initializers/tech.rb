require 'ruport'

Time::DATE_FORMATS[:serial] = '%y%m%d'

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below
#

require 'memcache'
memcache_options = {
  :c_threshold => 10_000,
  :compression => true,
  :debug => false,
  :namespace => 'tech',
  :readonly => false,
  :urlencode => false
}

CACHE = MemCache.new memcache_options
CACHE.servers = 'localhost:11211'

require 'cached_model'
#
#ActionController::Base.session_options[:expires] = 1800
#ActionController::Base.session_options[:cache] = CACHE

ExceptionNotification::Notifier.exception_recipients = %w(root@localhost)


gem 'ruby-net-ldap'
require 'net/ldap'

$settings=Hash.new
$settings[:ldap_enabled]=false
$settings[:ldap_host]='localhost'
$settings[:ldap_port]=636
$settings[:ldap_ssl]=true
$settings[:ldap_base]='o=Company'
$settings[:ldap_group]='cn=Tech-App,o=Company'

ActiveRecord::Validations::DateTime.us_date_format = true

gem 'netaddr'
require 'netaddr'

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.raise_delivery_errors = true

require 'lib/currency.rb'
require 'lib/tree_functions.rb'

gem 'net-ping'
require 'net/ping'

$settings[:fqdn]='tech.localdomain'
$settings[:email_address]='tech@locahost'

