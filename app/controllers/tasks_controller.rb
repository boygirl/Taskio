class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_group
  before_filter :find_task, :only => [:show, :edit, :update, :destroy]

  def new
    @task = @group.tasks.build
  end

  def create
    @task = @group.tasks.build(params[:task])
    if @task.save
      flash[:notice] = "Your task has been created."
      redirect_to @group
    else
      flash[:alert] = "Your task has not been created."
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update_attributes(params[:task])
      flash[:notice] = "Your task has been updated."
      redirect_to @group
    else
      flash[:alert] = "Your task has not been updated."
      render :action => :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "Your task has been deleted."
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

  def find_task
    @task = @group.tasks.find(params[:id])
  end
end
