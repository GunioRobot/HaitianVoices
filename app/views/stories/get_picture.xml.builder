xml.instruct!
xml.picture do
  xml.id       pic_url_as_id(@picture.photo.url(:thumb))
  xml.photo    @picture.photo.url(@size)
  xml.caption  @picture.caption
end
