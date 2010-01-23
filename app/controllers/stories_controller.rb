class StoriesController < ApplicationController

  def index
    @stories = Story.approved.by_date(params[:sort]).paginate(pagination_options)
    
    respond_to do |format|
      format.html
      format.json { render :json => @stories }
      format.xml  { render :xml => @stories }
    end
  end

  def show
    @story = Story.find(params[:id])
    
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
        redirect_to story_path( @story )
      else
        flashe[:notice] = "Thank you for sharing your story with Haitian Voices.  Our team of moderators review every story that comes before making them live on the website.  This process may take up to 2-3 days."
        render :action => "new"
      end
    else
      flash[:error] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
      render :action => "new"
    end
  end
  
end
