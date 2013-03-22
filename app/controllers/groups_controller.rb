class GroupsController < ApplicationController

  def index

  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])

    if @group.save
      Membership.create(user_id: current_user.id, group_id: @group.id)
      redirect_to dashboard_path, :notice => "Your group has been created."
    else
      flash[:alert] = "Group has not been created."
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:notice] = "Your group has been updated."
      redirect_to @group
    else
      flash[:alert] = "Your group has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @membership = Membership.where(group_id: @group.id)
    @membership.each do |membership|
      membership.destroy
    end
    @group.destroy
    flash[:notice] = "Your group has been deleted."
    redirect_to '/'
  end

end
