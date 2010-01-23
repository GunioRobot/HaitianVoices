class Admin::LanguagesController < AdminController
  def index
    @langs = Language.find(:all)
    @newLang = Language.new
  end

  def edit
    @lang = Language.find(params[:id])
  end

  def create
    @lang = Language.new(params[:language])

    if @lang.save
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end

  def update
    @lang = Language.find(params[:id])

    if @lang.update_attributes(params[:language])
      flash[:notice] = 'Language was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end

  def destroy
    Language.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
