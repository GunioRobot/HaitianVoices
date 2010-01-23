class Admin::UsersController < AdminController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account created"
      redirect_to [:admin, @user]
    else
      render :action => :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
 
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated"
      redirect_to [:admin, @user]
    else
      render :action => :edit
    end
  end
end