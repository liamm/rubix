module Rubix
  module Messages
    class Message
  
      Delimiter = 0x01.chr
      Version = 4.4
      
      def self.class_for_type(type)
        klass = MessageTypes[type]
        const_set(klass, Class.new(self)) unless const_defined?(klass)
        const_get(klass)
      end
      
      attr_reader :message, :lookup
      
      def initialize(message)
        @message = message
        @lookup = {}
      end
      
      def parse
        repeating_group = nil
        pairs.each do |pair|
          tag, value = pair.split('=') # TODO: What if value has '=' in it? Possibly split by regex on first '='
          if lookup.include?(tag) || (repeating_group && repeating_group.include?(tag))
            unless repeating_group
              repeating_group_tag = tags[tags.index(tag) - 1]
              repeating_group_tag_value = lookup[repeating_group_tag].value
              start_tag = tag
              repeating_group = RepeatingGroup.new(repeating_group_tag, repeating_group_tag_value, start_tag)
              # TODO: Add previous tags to repeating_group
              lookup[repeating_group.tag] = repeating_group
            end            
            repeating_group.add_field(tag, value)
            lookup.delete(tag)
          else
            repeating_group = nil
            lookup[tag] = Field.new(tag, value)
          end
          tag_name = MessageTags[tag] || (raise "No tag defined for #{tag}")
        end
        self
      end
      
      def tag(tag)
        lookup[tag]
      end
      
      def inspect
        str = ""
        lookup.each do |tag, entry|
          case entry
          when Field
            str << "#{entry.tag}: #{entry.value}\n"
          when RepeatingGroup
            str << "#{entry.tag}: #{entry.value} \n#{entry.inspect}"
          end  
        end
        str
      end
      
      private
      
      def pairs
        @pairs ||= message.split(Delimiter)
      end
      
      def tags
        @tags ||= pairs.map { |pair| pair.split('=').first } # TODO: What if value has '=' in it? Possibly split by regex on first '='
      end
      
    end
  end
end
