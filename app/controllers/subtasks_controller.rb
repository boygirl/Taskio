class SubtasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_task
  before_filter :find_subtask, :only => [:show, :edit, :update, :destroy]

  def new
    @subtask = @task.subtasks.build
  end

  def create
    @subtask = @task.subtasks.build(params[:subtask])
    # @subtask.user = current_user
    if @subtask.save
      flash[:notice] = "Subtask has been created."
      redirect_to @task.group
    else
      flash[:alert] = "Subtask has not been created."
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @subtask.update_attributes(params[:subtask])
      flash[:notice] = "Subtask has been updated."
      redirect_to @task.group
    else
      flash[:alert] = "Subtask has not been updated."
      render :action => :edit
    end
  end

  def destroy
    @subtask.destroy
    flash[:notice] = "Your subtask has been deleted."
    redirect_to @task.group
  end

private
  def find_task
    @task = Task.find(params[:task_id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The task you were looking " +
                "for could not be found."
    redirect_to root_path
  end

  def find_subtask
    @subtask = @task.subtasks.find(params[:id])
  end
end
