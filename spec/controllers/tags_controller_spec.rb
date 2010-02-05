require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TagsController do
  
  describe 'routing' do
    it 'routes index' do
      route_for(:controller => "tags", :action => "index").should == "/tags"
    end
    it 'routes index with a format' do
      route_for(:controller => 'tags', :action => 'index', :format => 'xml').should == '/tags.xml'
    end
  end
  
  describe '#index' do
    it 'loads tags' do
      tag = Tag.new(:name => 'fazbot')
      Tag.should_receive(:all).and_return { [tag] }
      get :index
      assigns[:tags].should == [tag]
    end
  end

end
