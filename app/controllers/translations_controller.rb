class TranslationsController < ApplicationController
  def index
    redirect_to :controller => 'stories'
  end
  
  def new
    redirect_to :action => 'index' unless params[:story]
    @story = Story.find(params[:story])
    @translation = Translation.new
    @langs = Language.find(:all,
      :conditions => ["id != ?", @story.language_id],
      :order => 'title DESC').map { |lang| [lang.title, lang.id] }
  end
  
  def create
    @translation = Translation.new(params[:translation])
    @translation.story_id = params[:story_id]
    
    if verify_recaptcha
      if @translation.save
        flash[:notice] = "Thank you for translating this story. Our team of moderators review every story that comes before making them live on the website.  This process may take up to 2&ndash;3 days."
        redirect_to story_path( @translation.story )
      else
        render :action => "new"
      end
    else
      flash[:error] = "There was an error with the recaptcha code below. Please re&ndash;enter the code and click submit."
      render :action => "new"
    end  
  end
  
  def destroy
    
  end
end
