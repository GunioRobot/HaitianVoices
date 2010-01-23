module StoriesHelper
  def display(text)
    text.gsub("\n",'<br/>')
  end

  def story_date_sort
    sort = params[:sort] == 'DESC' ? 'ASC' : 'DESC'
    link_to 'Date', stories_path(:sort => sort), :class => "sort #{sort.downcase}"
  end
end
