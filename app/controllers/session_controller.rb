class SessionController < ApplicationController
  # before_filter :authenticate, :except => [:login, :register, :create, :logout]
  
  def login
    if params[:user] && params[:user][:email]
      user = User.find_by_email(params[:user][:email])
    end
    
    if user && user.authenticate(params[:user][:password])
      set_current_user(user)
      redirect_to tasks_path
    else
      flash[:login_error] = "Invalid email/password combination!"
      redirect_to "/"
    end      
  end
  
  def register
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      set_current_user(@user)
      redirect_to user_path(current_user)
    else
      render :register
    end    
  end
  
  def logout
    exit
  end
  
end
