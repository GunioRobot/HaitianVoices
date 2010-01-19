class PagesController < ApplicationController

  def show_page
    render :action => params[:page_name]
  end

end
