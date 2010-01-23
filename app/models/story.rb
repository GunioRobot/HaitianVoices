class Story < ActiveRecord::Base

  belongs_to :user, :class_name => "User", :foreign_key => "approved_by"

  attr_protected :approved, :approved_by, :approved_on

  named_scope :by_date, :order => "created_at DESC"
  named_scope :approved, :conditions => { :approved => true }

  def self.random
    if (c = count) > 0
      first(:offset => rand(c)) 
    end    
  end

  def truncated_body
    @truncated_body ||= truncate_words( body, 100 )
  end

  def truncate_words(text, length = 30, end_string = ' …')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
  


end
