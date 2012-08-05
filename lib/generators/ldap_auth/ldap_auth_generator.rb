class LdapAuthGenerator < Rails::Generators::Base
  desc "Creates the views and controllers for LDAP authentication"
  source_root File.expand_path("../templates", __FILE__)
  argument :ldap_host, :type => :string

  def create_initializer
    LdapRails.configure :host => ldap_host
    template "ldap_auth.rb.erb", "config/initializers/ldap_auth.rb"
  end

  def add_before_filter
    inject_into_class "app/controllers/application_controller.rb", ApplicationController do
     "  before_filter :require_ldap_auth, :except => [:ldap_login, :persist_ldap_login, :ldap_logout]\n"
    end
  end

  def add_routes
    route "get '/ldap_login' => 'LdapLogins#ldap_login', :as => :ldap_login"
    route "post '/ldap_login' => 'LdapLogins#persist_ldap_login', :as => :persist_ldap_login"
    route "post '/ldap_logout' => 'LdapLogins#ldap_logout', :as => :ldap_logout"
  end

  def create_controller
    copy_file "ldap_logins_controller.rb", "app/controllers/ldap_logins_controller.rb"
  end

  def create_views
    copy_file "ldap_login.html.erb", "app/views/ldap_logins/ldap_login.html.erb"
  end

  def instructions
    readme "README"
  end
end