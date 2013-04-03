class MembershipsController < ApplicationController
  before_filter :find_group
  before_filter :find_membership, only: [:show, :edit, :update, :destroy]

  def show
  end

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

  def edit
  end

  def update
    if @membership.update_attributes(params[:membership])
      flash[:notice] = "Membership updated."
      redirect_to @group
    else
      flash[:alert] = "Membership was not updated."
      render action: :edit
    end
  end

  def destroy
    @membership.destroy
    flash[:notice] = "Membership deleted."
    redirect_to @group
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The group you were looking " +
                "for could not be found."
    redirect_to root_path
  end

  def find_membership
    @membership = Membership.find(params[:id])
  end
end
