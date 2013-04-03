class GroupsController < ApplicationController
before_filter :find_group, :only => [:show,
                                       :edit,
                                       :update,
                                       :destroy]
  def index

  end

  def show
    @tasks = @group.tasks
    @memberships = Membership.where(group_id: @group.id)
  end

  def new
    @group = Group.new
    @membership = @group.memberships.build
  end

  def create
    @group = Group.new(params[:group])
    @membership = @group.memberships.build(email: current_user.email)
    if @group.save
      @membership.save
      redirect_to dashboard_path, :notice => "Your group has been created."
    else
      flash[:alert] = "Group has not been created."
      render "new"
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(params[:group])
      flash[:notice] = "Your group has been updated."
      redirect_to @group
    else
      flash[:alert] = "Your group has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @membership = Membership.where(group_id: @group.id).where(email: current_user.email)
    @membership.each do |membership|
      membership.destroy
    end
    flash[:notice] = "Your group has been deleted."
    redirect_to '/'
  end

  private
    def find_group
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The group you were looking for could not be found."
      redirect_to root_path
    end
end
