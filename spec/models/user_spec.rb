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
  
  context "that has the default user role" do
    before do
      @user = Factory(:user, :role => User.user_role)
      @ability = Ability.new(@user)
    end
    it "should not be able to manage stories" do
      @ability.can?(:manage, Story.new).should be_false
    end
    it "should not be able to manage stories" do
      @ability.can?(:manage, User.new).should be_false
    end
  end

  context "that has the moderator role" do
    before do
      @user = Factory(:user, :role => User.moderator_role)
      @ability = Ability.new(@user)
    end
    it "should be able to manage stories" do
      @ability.can?(:manage, Story.new).should be_true
    end
    it "should not be able to manage users" do
      @ability.can?(:manage, User.new).should be_false
    end
  end

  context "that has the admin role" do
    before do
      @user = Factory(:user, :role => User.admin_role)
      @ability = Ability.new(@user)
    end
    it "should be able to manage stories" do
      @ability.can?(:manage, Story.new).should be_true
    end
    it "should be able to manage users" do
      @ability.can?(:manage, User.new).should be_true
    end
  end
  
end
