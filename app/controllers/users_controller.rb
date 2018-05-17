class UsersController < ApplicationController
  #GET /users/:id
  def show
    @user = User.first
    @user = User.find(params[:id])
    # =>app/views/users/show.html.erb
    # debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # =>これだけだとセキュリティ上の穴になってしまう（パラメタの中身を精査していないため）
    #@user.name  = params[:user][name]
    #@user.email = params[:user][email]
    #params[:user][password]のこと
    if @user.save # => Validation
      log_in @user
      #Sucess
      #redirect_to users_path(@user.id)
      #redirect_to users_path(@user) 
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # =>GET "/users/#{@user.id}"  =>show
    else
      # Failure
      render 'new'
    end
  end
  
  def user_params
    params.require(:user).permit(
      :name, :email, :password, 
      :password_confirmation)
  end
  
end