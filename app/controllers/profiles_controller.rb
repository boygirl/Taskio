class ProfilesController < ApplicationController
  before_filter :find_profile, except: [:index, :show]

  def index
    @profile = Profile.find_or_create_by_user_id(user_id: current_user.id)
  end

  def show
    @profile = Profile.find_or_create_by_user_id(user_id: current_user.id)
  end

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "Your profile has been updated."
      redirect_to @profile
    else
      flash[:alert] = "Your profile has not been updated."
      render action: :edit
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_profile
    @profile = Profile.find(params[:id])
  end
end
