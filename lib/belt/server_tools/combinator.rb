module Belt
  require 'zonomi'
  require 'fog'

  require_relative 'chef/client'
  require_relative 'chef/node'


  module ServerTools

    class Combinator

      def initialize(config = {})
        @ec2_connection = load_fog_for config[:aws_regions], config[:aws_access_key_id], config[:aws_secret_access_key]
        @zonomi_api = ::Zonomi::API::Client.new(api_key: config[:zonomi_token])
      end

      def dns_records
        @zonomi_api.api.records_by_name("onebigvoice.com", all_records: true).select{ |r| r.type == "A" }
      end

      def ec2_instances
        Hash[ @ec2_connection.map { |key, value|  [ key, value.servers ] } ]
      end

      def chef_clients
        @chef_clients ||= ServerTools::Chef::Client.all
      end

      def chef_nodes
        @chef_nodes ||= ServerTools::Chef::Node.all
      end

      def set_ipaddress_for_a_record_for(domain, ip)
        @zonomi_api.api.set_ipaddress_for_a_record_for(domain, ip)
      end


      private

      def load_fog_for(aws_regions, aws_access_key_id, aws_secret_access_key)

        Hash[
          aws_regions.map do |key, value| 
          
            [ 
              key,  

              Fog::Compute.new({  provider: "AWS", 
                                  aws_access_key_id: aws_access_key_id, 
                                  aws_secret_access_key: aws_secret_access_key,
                                  region: value } )
            ]

          end
        ]

       end


    end



    module Chef

      @@clients = []
      @@nodes = []

      mattr_accessor :clients
      mattr_accessor :nodes

    end


  end
end
