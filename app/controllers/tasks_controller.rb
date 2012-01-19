class TasksController < ApplicationController
  before_filter :authenticate
  
  def index
    show = params[:show] || nil
    if show and show[/any|open|pending|closed|active/i]
      @tasks = Task.send(show.to_sym).paginate(:page => params[:page])
    else  
     @tasks = Task.active.paginate(:page => params[:page])
    end
    @task = current_user.tasks.build
    @task.status = 'Open'
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
      flash[:notice] = 'Task was successfully created.'
      respond_to do |format|
        format.html { redirect_to action: "index" }
        format.js
      end
       
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
  
  # PUT /tasks/1/close
  def close
    @task = Task.find(params[:id])
    
    # format this for AJAX 
    if @task.update_attributes(:status => "Closed")
      redirect_to action: "index", show: params[:show]
    else
      render action: "index" 
    end
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.active = 0
    @task.save
    redirect_to tasks_url
  end
  
end
