require 'spec_helper'

describe Rubix::Parser do
  
  context "Dynamic Class Instantiation" do    
    
    it "should create a new class for a Heartbeat message (35=0)" do
      message = "8=FIX.4.4\0019=178\00135=0\00110=128\001"
      message.should_receive(:split).twice.with("\001").and_call_original
      Rubix::Messages::Message.should_receive(:class_for_type).with("0").and_call_original
      Rubix::Parser.parse(message).should be_a Rubix::Messages::Message::Heartbeat
    end
    
    it "should create a new class for a TestRequest message (35=1)" do
      message = "8=FIX.4.4\0019=178\00135=1\00110=128\001"
      message.should_receive(:split).twice.with("\001").and_call_original
      Rubix::Messages::Message.should_receive(:class_for_type).with("1").and_call_original
      Rubix::Parser.parse(message).should be_a Rubix::Messages::Message::TestRequest
    end
    
  end
  
end