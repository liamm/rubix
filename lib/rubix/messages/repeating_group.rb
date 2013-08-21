require 'set'

module Rubix
  module Messages
    class RepeatingGroup
  
      include Enumerable
      
      attr_reader :tag, :value, :start_tag
      
      def initialize(tag, value, start_tag)
        @tag = tag
        @value = value
        @start_tag = start_tag
        @repeats = []
        @tags = Set.new
      end
      
      def add_field(tag, value)
        @tags << tag
        @repeats << Repeat.new if tag == start_tag
        @repeats.last[tag] = Field.new(tag, value)
      end
      
      def each(&block)
        @repeats.each(&block)
      end
      
      def include?(tag)
        @tags.include?(tag)
      end
      
      def inspect
        str = ""
        each do |entry|
          str << "-\n"
          entry.each do |tag, repeat|
            str << " - #{repeat.tag}: #{repeat.value}\n"
          end
        end
        str
      end
      
    end
  end
end