class Admin::StoriesController < AdminController

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
  end

  def create
    @story = Story.new(params[:story])

    if @story.save
      redirect_to admin_story_path( @story )
    else
      render :action => "new"
    end
  end

  def update
    @story = Story.find(params[:id])

    if @story.update_attributes(params[:story])
      flash[:notice] = 'Story was successfully updated.'
      redirect_to admin_story_path( @story )
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy

    redirect_to( admin_stories_url)
  end
  
  def approve
    @story = Story.find(params[:id])
    @story.update_attribute( :approved, true )
    @story.update_attribute( :approved_by, current_user )
    redirect_to admin_story_path( @story )
  end
  
  def disapprove
    @story = Story.find(params[:id])
    @story.update_attribute( :approved, false ) 
    redirect_to admin_story_path( @story )   
  end
  
end
