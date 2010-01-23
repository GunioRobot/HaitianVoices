class User < ActiveRecord::Base
  acts_as_authentic

  def self.roles
    [["user", 0], ["moderator", 1], ["admin", 2]]
  end

  roles.each do |r|
    (class << self; self end).send(:define_method, "#{r.first}_role") { r.last }
  end

  roles.each do |r|
    define_method("#{r.first}?") { role == r.last }
  end
  
  def role_name
    self.class.roles[role].first.titleize
  end
  
end
