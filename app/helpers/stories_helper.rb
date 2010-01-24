module StoriesHelper
  def display(text)
    text.gsub("\n",'<br/>')
  end

  def story_date_sort
    if params[:sort]
      sort = params[:sort].downcase  == 'desc' ? 'asc' : 'desc'
    else
      sort = 'asc'
    end
    link_to 'Date', stories_path(:sort => sort), :class => "sort #{sort.downcase}"
  end

  def story_filter
    select_tag "filter", options_for_select([["All", 'all'], 
                                             ["Text", 'text'], 
                                             ["Video", 'video']], 
                                            :selected => params[:filter])
  end

  def youtube_embed(story, width=425, height=350)
    return unless story.url
    markup =  "<object width='#{width}' height='#{height}'>"
    markup << "<param name='movie' value='#{story.youtube_embed_url}' align='left'></param>"
    markup << "<embed src='#{story.youtube_embed_url}' type='application/x-shockwave-flash' width='#{width}' height='#{height}'></embed>"
    markup << "</object>"
  end

  def langs
    @langs ||= Language.find(:all, :order => 'title').map{ |lang| [lang.title, lang.id]} 
  end
  
end
