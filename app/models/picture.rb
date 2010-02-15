class Picture < ActiveRecord::Base
  belongs_to :story

  SIZE_PARAMS = {'S' => :small, 'M' => :medium, 'L' => :large }
  DEFAULT_SIZE_PARAM = 'L'
  
  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb  => "100x100#",
      :small  => "320x240>",
      :medium => "480x360>",
      :large  => "720x540>" }

end
