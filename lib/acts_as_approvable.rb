module ActsAsApprovable
  
  def acts_as_approvable
    belongs_to :reviewer, :class_name => "User", :foreign_key => "approved_by"
    
    attr_protected :approved, :approved_by, :approved_on
    
    named_scope :pending, :conditions => { :reviewed_at => nil }
    
    # Not declared as a named scope because there's no easy way to
    # combine the {} and [] ways of declaring conditions.
    def approved
      self.scoped(:conditions => {:approved => true}).scoped(:conditions => ["#{self.table_name}.reviewed_at is not null"])
    end
    
    # Not declared as a named scope because there's no easy way to
    # combine the {} and [] ways of declaring conditions.
    def disapproved
      self.scoped(:conditions => {:approved => false}).scoped(:conditions => ["#{self.table_name}.reviewed_at is not null"])
    end
    
    include ActsAsApprovable::InstanceMethods
  end
  
  module InstanceMethods
    # Updates :reviewer, :approved, and :reviewed_at appropriately.
    #
    # Does *not* save the model.
    def approved_by!(user)
      self.reviewer = user
      self.reviewed_at = Time.now
      self.approved = true
    end
    
    # Updates :reviewer, :approved, and :reviewed_at appropriately.
    #
    # Does *not* save the model.
    def disapproved_by!(user)
      self.reviewer = user
      self.reviewed_at = Time.now
      self.approved = false
    end
  end
  
end

ActiveRecord::Base.extend ActsAsApprovable
