class StoriesController < ApplicationController

  def index
    scope = Story.approved.by_date(params[:sort])
    scope = scope.tagged_with(params[:tag]) if params[:tag].present?
    scope = scope.search(params[:q]) if params[:q].present?
    if params[:filter] == 'text'
      scope = scope.text
    elsif params[:filter] == 'video'
      scope = scope.video
    end
    @stories = scope.paginate(pagination_options)
    
    respond_to do |format|
      format.html do
        @tags = Tag.all # only load the tags for the HTML version
      end
      format.json { render :json => @stories }
      format.xml  { render :xml => @stories }
    end
  end

  def show
    @story = Story.find(params[:id])
    @requestedLanguage = params[:language] ? Language.find_by_title(params[:language].capitalize) : @story.language
    @langs = [@story.language] + @story.translations.approved.map(&:language)
    if @story.language != @requestedLanguage
      @translation = @story.translations.approved.select { |s| s.language == @requestedLanguage }.first
      if @translation
        @story.title = @translation.title
        @story.body = @translation.body
        @story.language = @translation.language
      end
    end

    respond_to do |format|
      format.html
      format.json { render :json => @story }
      format.xml  { render :xml => @story }
    end    
  end
  
  def new
    @story = Story.new
  end
  
  def create

    @story = Story.new(params[:story])

    if verify_recaptcha
      if @story.save
        flash[:notice] = "Thank you for sharing your story with Haitian Voices.  Our team of moderators review every story that comes before making them live on the website.  This process may take up to 2-3 days."
        redirect_to story_path( @story )
      else
        render :action => "new"
      end
    else
      flash[:error] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
      render :action => "new"
    end
  end
  
  # renders HTML or XML for the selected picture; sizes other than default can be selected
  # by passing the appropriate parameter (e.g. "<url>?size=L" for Large)
  def get_picture
    @story = Story.find(params[:story_id])
    @picture = Picture.find(params[:picture_id])
    @size = Picture::SIZE_PARAMS[(params[:size] || Picture::DEFAULT_SIZE_PARAM)]
    respond_to do |format|
      format.html { render :html => @picture }
      format.json { render :json => @picture }
      format.xml  {  }  # call XML builder file
    end    
  end
  
end
