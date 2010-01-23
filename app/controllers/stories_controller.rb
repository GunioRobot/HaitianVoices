class StoriesController < ApplicationController

  def index
    @stories = Story.approved.by_date(params[:sort]).tagged_with(params[:tag]).paginate(pagination_options)
    @tags = Tag.all
    
    respond_to do |format|
      format.json { render :json => @stories }
      format.xml  { render :xml => @stories }
      format.html
    end
  end

  def show
    @story = Story.find(params[:id])
    
    respond_to do |format|
      format.json { render :json => @story }
      format.xml  { render :xml => @story }
      format.html
    end    
  end
  
  def new
    @story = Story.new
    @langs = Language.find(:all, :order => 'title').map{ |lang| [lang.title, lang.id]} 
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
