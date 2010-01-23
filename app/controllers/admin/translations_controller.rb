class Admin::TranslationsController < AdminController
  def index
    @translations = Translation.all
  end

  def destroy
    @translation = Translation.find(params[:id])
    @translation.destroy

    redirect_to admin_translations_url
  end
  
  def show
    @translation = Translation.find(params[:id], :include => :story)
    @story = @translation.story
  end
  
  def approve
    @translation = Translation.find(params[:id])
    @translation.update_attribute( :approved, true )
    @translation.update_attribute( :approved_by, current_user )
    redirect_to admin_translation_path( @translation )
  end

  def disapprove
    @translation = Translation.find(params[:id])
    @translation.update_attribute( :approved, false ) 
    redirect_to admin_story_path( @translation )   
  end
end
