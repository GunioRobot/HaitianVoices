require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should have a default user role" do
    user = Factory(:user)
    user.should be_user
    user.should_not be_moderator
    user.should_not be_admin
  end
  it "should have a default user role" do
    user = Factory(:user, :role => User.moderator_role)
    user.should_not be_user
    user.should be_moderator
    user.should_not be_admin
  end
  it "should have a default user role" do
    user = Factory(:user, :role => User.admin_role)
    user.should_not be_user
    user.should_not be_moderator
    user.should be_admin
  end
end
