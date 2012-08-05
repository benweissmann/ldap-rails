require 'uri'

module LdapRails
  class << self
    attr_reader :config
    attr_reader :ldap

    def configure config
      # config[:host] is required
      unless config[:host]
        raise InvalidConfigurationError.new("Must provide :host to LdapRails.configure")
      end

      # store and autocomplete the config
      @config = config
      autocomplete_config

      # create a Net::LDAP
      opts = {:host => config[:host], :port => config[:port]}

      if config[:ssl]
        opts[:encryption] = :simple_tls
      end

      @ldap = Net::LDAP.new opts
    end

    private

    def autocomplete_config
      # split port from host
      if @config[:port].nil? and @config[:host] and config[:host].include? ':'
        @config[:host], @config[:port] = @config[:host].split(':')
        @config[:port] = @config[:port].to_i
      end

      # default port to 389
      @config[:port] ||= 389

      # infer TLS from port
      if @config[:ssl].nil? and @config[:port] == 636
        @config[:ssl] = true
      end

      # default TLS to false
      @config[:ssl] ||= false

      # infer base_dn from host
      if @config[:host] and @config[:base_dn].nil?
        parts = @config[:host].split('.')
        if parts.length == 1
          @config[:base_dn] = "dc=#{parts[0]}"
        elsif parts.length > 1
          @config[:base_dn] = "dc=#{parts[-2]},dc=#{parts[-1]}"
        end
      end

      # default login key to 'uid' and login suffix to ''
      @config[:login_key] ||= 'uid' 
      @config[:login_suffix] ||= ''
    end
  end

  class InvalidConfigurationError < StandardError; end
end