class AfterSignupController < ApplicationController
  include Wicked::Wizard

  before_filter :authenticate_user!

  steps :basic_settings, :link_github, :link_google

  def show
    @user = current_user
    @current_step = current_step_index + 1
    @total_steps = steps.count
    render_wizard
  end

  def update
    @user = current_user
    @user.update_params(params[:user])

    render_wizard @user
  end
end