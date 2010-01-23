class Language < ActiveRecord::Base
  has_many :stories
  has_many :translations
end
