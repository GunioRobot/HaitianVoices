require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  it "finds a random story" do
    2.times {Factory(:story)}
    Story.all.include?(Story.random).should == true
  end
end
