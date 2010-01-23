module StoriesHelper
  def display(text)
    text.gsub("\n",'<br/>')
  end
end
