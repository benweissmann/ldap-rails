module LdapRails
  module HelperExtensions
    def ldap_user
      controller.ldap_user
    end

    def ldap_status
      return '' unless ldap_user

      link = link_to('Log Out', ldap_logout_path, :method => :post)
      return "Logged in as #{ldap_user.username}. #{link}.".html_safe
    end
  end
end

ActionView::Base.send :include, LdapRails::HelperExtensions