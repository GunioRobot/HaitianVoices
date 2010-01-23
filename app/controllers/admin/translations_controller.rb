class Admin::TranslationsController < ApplicationController
  # GET /admin_translations
  # GET /admin_translations.xml
  def index
    @admin_translations = Admin::Translation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_translations }
    end
  end

  # GET /admin_translations/1
  # GET /admin_translations/1.xml
  def show
    @translation = Admin::Translation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /admin_translations/new
  # GET /admin_translations/new.xml
  def new
    @translation = Admin::Translation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /admin_translations/1/edit
  def edit
    @translation = Admin::Translation.find(params[:id])
  end

  # POST /admin_translations
  # POST /admin_translations.xml
  def create
    @translation = Admin::Translation.new(params[:translation])

    respond_to do |format|
      if @translation.save
        flash[:notice] = 'Admin::Translation was successfully created.'
        format.html { redirect_to(@translation) }
        format.xml  { render :xml => @translation, :status => :created, :location => @translation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_translations/1
  # PUT /admin_translations/1.xml
  def update
    @translation = Admin::Translation.find(params[:id])

    respond_to do |format|
      if @translation.update_attributes(params[:translation])
        flash[:notice] = 'Admin::Translation was successfully updated.'
        format.html { redirect_to(@translation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_translations/1
  # DELETE /admin_translations/1.xml
  def destroy
    @translation = Admin::Translation.find(params[:id])
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to(admin_translations_url) }
      format.xml  { head :ok }
    end
  end
end
