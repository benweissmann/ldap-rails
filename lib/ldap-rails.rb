Dir[File.join(File.dirname(__FILE__), 'ldap-rails', '**', '*.rb')].each do |f|
  require f
end
