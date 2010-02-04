module ActsAsApprovable
  
  def acts_as_approvable
    belongs_to :approver, :class_name => "User", :foreign_key => "approved_by"
    attr_protected :approved, :approved_by, :approved_on
    named_scope :approved, :conditions => { :approved => true }
    include ActsAsApprovable::InstanceMethods
  end
  
  module InstanceMethods
    # Updates :approver, :approved, and :approved_on appropriately.
    #
    # Does *not* save the model.
    def approved_by!(user)
      self.approver = user
      self.approved = true
      self.approved_on = Time.now
    end
  end
  
end

ActiveRecord::Base.extend ActsAsApprovable
