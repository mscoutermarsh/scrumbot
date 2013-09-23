class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :new
  before_action :correct_user, only: [:edit, :update, :show]

  def new
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update  
    flash[:success] = "Profile updated" if @user.update_attributes(user_params)
    render 'edit'
  end

  protected
    def user_params
      params.require(:user).permit(:email, :skip_weekends, :time_zone)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
