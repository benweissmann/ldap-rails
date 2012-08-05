module LdapRails
  module ControllerExtensions
    def ldap_user
      if session[:ldap_user]
        @ldap_user = LdapRails::LdapUser.new session[:ldap_user]
      end

      return @ldap_user
    end

    def require_ldap_auth
      if ldap_user.nil?
        session[:return_to] = request.path
        flash[:error] = "You must log in."
        redirect_to ldap_login_path
      end
    end
  end
end

ActionController::Base.send :include, LdapRails::ControllerExtensions