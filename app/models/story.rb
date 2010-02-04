require 'acts_as_approvable'

class Story < ActiveRecord::Base

  # TODO AB: #url is just a placholder for a video relationship
  # I needed something to sort on the stories page. If you are doing
  # the video integration, this field can be removed.
  #
  acts_as_taggable_on :tags
  
  acts_as_approvable
  
  belongs_to :language

  has_many :pictures
  has_many :translations

  attr_accessor :picture_files
  attr_accessor :picture_captions

  SAFE_SORT_DIRECTIONS = /^(asc|desc)$/i
  
  named_scope :by_date, lambda { |sort|
    sort = 'DESC' unless sort =~ SAFE_SORT_DIRECTIONS
    { :order => "#{Story.table_name}.created_at #{sort}" }
  }

  named_scope :pending, :conditions => { :approved => false }

  named_scope :search, lambda {|q| {:conditions => ["body like ?", "%#{q}%"]}}
  named_scope :text, lambda {|q| {:conditions => ["url is null"]}}
  named_scope :video, lambda {|q| {:conditions => ["url is not null"]}}

  before_save :add_pictures

  def self.random
    if (c = count) > 0
      first(:offset => rand(c)) 
    end    
  end

  # TODO AB: refactor (there is a view helper for this)
  def truncated_body
    @truncated_body ||= truncate_words( body, 100 )
  end

  # TODO AB: refactor (there is a view helper for this)
  def truncate_words(text, length = 30, end_string = ' …')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end

  def youtube_embed_url
    url.gsub('watch?v=', 'v/')
  end
  
  def add_pictures
    unless picture_files.blank?
      picture_files.each_with_index do |f, i|
	pic_caption ||= (picture_captions.is_a? Array) && picture_captions[i]
        pictures << pictures.build(:photo => f, :caption => pic_caption)
      end
    end
  end
end
