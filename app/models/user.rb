class User < ActiveRecord::Base
  acts_as_authentic

  def self.roles
    [["user", 0], ["moderator", 1], ["admin", 2]]
  end

  def self.user_role
    0
  end
  
  def self.moderator_role
    1
  end
  
  def self.admin_role
    2
  end

  roles.each do |r|
    define_method("#{r.first}?") { role == r.last }
  end
  
end
