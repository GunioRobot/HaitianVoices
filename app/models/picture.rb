class Picture < ActiveRecord::Base
  belongs_to :story

  # Paperclip
  has_attached_file :photo,
    :styles => {
      :thumb  => "100x100#",
      :small  => "320x240>",
      :medium => "480x360>",
      :large  => "720x540>" }

end
