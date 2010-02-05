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
  
  describe 'finding by review status' do
    before(:each) do
      @pending = Factory(:unreviewed_story)
      @approved = Factory(:approved_story)
      @disapproved = Factory(:disapproved_story)
    end
    
    it 'should find pending Stories' do
      Story.pending.to_a.should == [@pending]
    end
    
    it 'should find approved Stories' do
      Story.approved.to_a.should == [@approved]
    end
    
    it 'should find disapproved Stories' do
      Story.disapproved.to_a.should == [@disapproved]
    end
  end
  
  it 'should be approvable' do
    earlier = Time.now
    user = Factory(:user)
    story = Factory(:unreviewed_story)
    story.should_not be_approved
    story.approved_by!(user)
    story.should be_approved
    story.reviewer.should == user
    story.reviewed_at.should be > earlier
  end
  
end
