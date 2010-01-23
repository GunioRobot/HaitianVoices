require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  it "finds a random story" do
    2.times {Factory(:story)}
    Story.all.include?(Story.random).should == true
  end
  
  it "should be taggable" do
    @foo = Factory(:story, :tag_list => "foo")
    @bar = Factory(:story, :tag_list => "bar")
    @foo_bar = Factory(:story, :tag_list => "foo, bar")
    Story.tagged_with("foo").all(:order => "id").should == [@foo, @foo_bar]
    Story.tagged_with("bar").all(:order => "id").should == [@bar, @foo_bar]
  end
  
end
