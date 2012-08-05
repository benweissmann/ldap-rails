require 'net-ldap'

module LdapRails
  class LdapUser
    attr_reader :username

    def initialize hash
      @username = hash[:username]
    end

    def to_hash
      {:username => @username}
    end

    # Tries to authenticate using the given username and password. Returns
    # an LdapUser is successful, nil if unsuccessful.
    def self.auth username, password
      unless LdapRails.config
        raise NoConfigurationError.new("You must have a call to LdapRails.configure in an initializer.")
      end

      LdapRails.ldap.auth dn_for(username), password
      if LdapRails.ldap.bind
        return new(:username => username)
      else
        return nil
      end
    end

    def self.dn_for username
      dn = "#{LdapRails.config[:login_key]}=#{username}"
      if LdapRails.config[:login_suffix].length > 0
        dn += ",#{LdapRails.config[:login_suffix]}"
      end
    end
    private_class_method :dn_for
  end

  class NoConfigurationError < StandardError; end
end