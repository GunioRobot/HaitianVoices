require 'acts_as_approvable'

class Translation < ActiveRecord::Base
  belongs_to :story
  belongs_to :language
  
  acts_as_approvable

  named_scope :by_date, :order => "#{self.table_name}.created_at DESC"

  def truncated_body
    @truncated_body ||= truncate_words( body, 100 )
  end

  def truncate_words(text, length = 30, end_string = ' …')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
end
