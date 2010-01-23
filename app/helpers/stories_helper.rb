module StoriesHelper
  def display(text)
    text.gsub("\n",'<br/>')
  end

  def story_date_sort
    sort = params[:sort] == 'DESC' ? 'ASC' : 'DESC'
    link_to 'Date', stories_path(:sort => sort), :class => "sort #{sort.downcase}"
  end

  def story_filter
    select_tag "filter", options_for_select(["All", "Text", "Audio", "Video"])
  end

  def youtube_embed(story, width=425, height=350)
    return unless story.url
    markup =  "<object width='#{width}' height='#{height}'>"
    markup << "<param name='movie' value='#{story.youtube_embed_url}' align='left'></param>"
    markup << "<embed src='#{story.youtube_embed_url}' type='application/x-shockwave-flash' width='#{width}' height='#{height}'></embed>"
    markup << "</object>"
  end
  
end
