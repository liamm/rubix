module Rubix
  class Parser
    
    def self.parse(message)
      pairs = message.split(Messages::Message::Delimiter)
      type = pairs.grep(/35=.*/).first[3..-1]
      Messages::Message.class_for_type(type).new(message).parse
    end
    
  end
end