class TasksController < ApplicationController
  before_filter :authenticate
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])
    
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render action: "edit" 
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
  end
end
