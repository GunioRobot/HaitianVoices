class StoriesController < ApplicationController

  def index
    if params[:filter] == 'text'
      scope = Story.approved.text.by_date(params[:sort]).tagged_with(params[:tag])
    elsif params[:filter] == 'video'
      scope = Story.approved.video.by_date(params[:sort]).tagged_with(params[:tag])
    else
      scope = Story.approved.by_date(params[:sort]).tagged_with(params[:tag])
    end
    scope = scope.search(params[:q]) unless params[:q].blank?
    @stories = scope.paginate(pagination_options)
    @tags = Tag.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @stories }
      format.xml  { render :xml => @stories }
      format.html
    end
  end

  def show
    @story = Story.find(params[:id])
    @requestedLanguage = params[:language] ? Language.find_by_title(params[:language]) : @story.language
    @langs = [@story.language] + @story.translations.approved.map(&:language)
    if @story.language != @requestedLanguage
      @translation = @story.translations.approved.select { |s| s.language == @requestedLanguage }.first
      @story.title = @translation.title
      @story.body = @translation.body
      @story.language = @translation.language
    end

    respond_to do |format|
      format.html
      format.json { render :json => @story }
      format.xml  { render :xml => @story }
      format.html
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
  
end
