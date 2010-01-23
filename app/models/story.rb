class Story < ActiveRecord::Base

  acts_as_taggable_on :tags

  belongs_to :user, :class_name => "User", :foreign_key => "approved_by"
  belongs_to :language
  belongs_to :user, :class_name => "User", :foreign_key => "approved_by"

  has_many :pictures

  attr_protected :approved, :approved_by, :approved_on

  attr_accessor :picture_files

  #named_scope :by_date, :order => "created_at DESC"
  named_scope :by_date, lambda { |sort| { :order => "created_at #{sort}"} }
  named_scope :approved, :conditions => { :approved => true }

  named_scope :search, lambda {|q| {:conditions => ["body like ?", "%#{q}%"]}}

  before_save :add_pictures

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
  
  def add_pictures
    unless picture_files.blank?
      picture_files.each do |f|
        pictures << pictures.build(:photo => f)
      end
    end
  end
end
