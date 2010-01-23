class Translation < ActiveRecord::Base
  belongs_to :story
  belongs_to :language
  belongs_to :user, :class_name => "User", :foreign_key => "approved_by"
  
  attr_protected :approved, :approved_by, :approved_on

  named_scope :by_date, :order => "created_at DESC"
  named_scope :approved, :conditions => { :approved => true }
  
end
