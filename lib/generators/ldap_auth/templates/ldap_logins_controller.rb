class LdapLoginsController < ApplicationController
  # GET /ldap_login
  def ldap_login
    # ldap_logins.erb
  end

  # POST /ldap_login
  def persist_ldap_login
    user = LdapRails::LdapUser.auth params[:username], params[:password]

    if user.nil?
      flash[:ldap_login_error] = "Incorrect username or password."
      redirect_to ldap_login_path
    else
      session[:ldap_user] = user.to_hash
      flash[:notice] = "Logged in as #{user.username}."

      # Clear return_to so it doesn't get re-used if the user logs out
      # and logs in again.
      target = (session[:return_to] || '/')
      session.delete :return_to

      redirect_to target
    end
  end

  # POST /ldap_logout
  def ldap_logout
    session[:ldap_user] = nil
    redirect_to '/'
  end
end