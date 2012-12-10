module Belt
  module ServerTools
    module Chef
      class Node

        attr_reader :name

        IGNORED_NODES = [ "obv" ]

        attr_reader :dns
        attr_reader :location
        attr_reader :role
        attr_reader :number


        def initialize(name)
          @dns = name
          @role, @number, @location = @dns.split(/-|\./)[0..2]
        end

        def destroy!
          `knife node delete #{@name}`
        end

        # Class methods
        def self.new(name)
          @cache ||= {} # remember to remove from the cache on destroy
          @cache[name.to_sym] ||= super(name)
        end

        def self.all
          self.parse(self.list_from_command_line_tool)
          Chef.nodes
        end

        def self.list_from_command_line_tool
          `knife node list`
        end

        def self.parse(list)
          list.split("\n").map{ |a| a.strip }.reject{ |b| IGNORED_NODES.include? b }.map do |name|
            Chef.nodes << new(name) unless Chef.nodes.any? { |x| x.dns == name }
          end
        end

      end
    end
  end
end
