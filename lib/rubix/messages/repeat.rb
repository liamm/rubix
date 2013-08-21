module Rubix
  module Messages
    class Repeat < Hash
      
      def tag(tag)
        self[tag]
      end
      
    end
  end
end