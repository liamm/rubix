module Rubix
  module Messages
    class Field
    
      attr_reader :tag, :value
    
      def initialize(tag, value)
        @tag = tag
        @name = MessageTags[tag]
        @value = value
      end
      
    end
  end
end