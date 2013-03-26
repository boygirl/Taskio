class MembershipsController < ApplicationController
  before_filter :find_group

  def new
    @membership = @group.memberships.build
  end

  def create
    @membership = @group.memberships.build(params[:membership])
    if @membership.save
      flash[:notice] = "Your collaborator has been added."
      redirect_to @group
    else
      flash[:alert] = "Your collaborator has not been added."
      render :action => "new"
    end
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The group you were looking " +
                "for could not be found."
    redirect_to root_path
  end
end
