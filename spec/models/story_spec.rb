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
    Story.tagged_with("foo").all(:order => "#{Story.table_name}.id").should == [@foo, @foo_bar]
    Story.tagged_with("bar").all(:order => "#{Story.table_name}.id").should == [@bar, @foo_bar]
  end
  
  it "should be searchable" do
    @foo = Factory(:story, :body => "This is about foo.")
    @bar = Factory(:story, :body => "This is about bar.")
    Story.search("foo").all.should == [@foo]
  end
  
  it 'should be approvable' do
    earlier = Time.now
    user = Factory(:user)
    story = Factory(:story, :approved => false)
    story.should_not be_approved
    story.approved_by!(user)
    story.should be_approved
    story.approver.should == user
    story.approved_on.should be > earlier
  end
  
end
