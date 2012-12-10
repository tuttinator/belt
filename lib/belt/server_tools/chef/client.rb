module Belt
  module  ServerTools
    module Chef

      class Client

        attr_reader :dns
        attr_reader :location
        attr_reader :role
        attr_reader :number

        IGNORED_CLIENTS = [ "caleb", "chef-validator", "chef-webui", "giles", "luke", "obv" ]

        def initialize(name)
          @dns = name
          @role, @number, @location = @dns.split(/-|\./)[0..2]
        end

        def destroy!
          `knife client delete #{@name}`
        end

        # Class methods

        def self.new(name)
          @cache ||= {} # remember to remove from the cache on destroy
          @cache[name.to_sym] ||= super(name)
        end

        def self.all
          self.parse(self.list_from_command_line_tool)
          Chef.clients
        end


        def self.list_from_command_line_tool
          `knife client list`
        end

        def self.parse(list)
          list.split("\n").map{ |a| a.strip }.reject{ |b| IGNORED_CLIENTS.include? b }.map do |name|
            Chef.clients << new(name) unless Chef.clients.any? { |x| x.dns == name }
          end
        end

      end
    end
  end
end
