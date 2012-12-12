# external dependencies
require 'zonomi'
require 'fog'

# internal dependencies
require 'belt/version'
require 'belt/core_ext'
require 'belt/server_tools/combinator'


module Belt

  class Configuration
    attr_accessor :aws_regions, :aws_access_key_id, :aws_secret_access_key, :zonomi_key
  end
  
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end



  aws_credentials = YAML.load_file(File.dirname(__FILE__) + '/../config/aws_tools.yml').recursive_symbolize_keys!
  zonomi = YAML.load_file(File.dirname(__FILE__) + '/../config/zonomi.yml').recursive_symbolize_keys!


    server_tools = ServerTools::Combinator.new( {
      aws_regions: aws_credentials[:regions],
      aws_access_key_id: aws_credentials[:aws_credentials][:aws_access_key_id],
      aws_secret_access_key: aws_credentials[:aws_credentials][:aws_secret_access_key],
      zonomi_key: zonomi[:key]
    })





end
