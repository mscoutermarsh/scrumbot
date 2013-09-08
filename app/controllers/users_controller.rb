class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :new

  def new
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    @accounts = @user.accounts
  end

  def update
    @user = current_user
    if @user.update(params[:user])
      flash[:notice] = "Settings updated!"
      redirect_to settings_path
    else
      flash[:error] = "error!"
      render action: 'edit'
    end
  end
end
