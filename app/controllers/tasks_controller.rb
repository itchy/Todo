class TasksController < ApplicationController
  before_filter :authenticate
  before_filter :scope_task_to_user_lists, :except => [:index, :new, :create] 
  
  def index
    @show = params[:show] || 'active'
    if @show and @show[/any|open|pending|closed|active/i]
      @tasks = Task.send(@show.to_sym).paginate(:page => params[:page])
    else  
     @tasks = Task.active.paginate(:page => params[:page])
    end
    @task = current_user.tasks.build
    @task.status = 'Open'
  end
  
  def show

  end

  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit

  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])
    if @task.save
      flash.now[:notice] = 'Task was successfully created.'
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
    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task was successfully updated.'
      redirect_to action: :index
    else
      render action: "edit" 
    end
  end
  
  # PUT /tasks/1/close
  def close    
    # format this for AJAX 
    if @task.update_attributes(:status => "Closed")
      respond_to do |format|
        format.html { redirect_to action: "index", show: params[:show] }
        format.js 
      end  
    else
      render action: "index" 
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.active = 0
    @task.save
    redirect_to tasks_url
  end

private
  def scope_task_to_user_lists
    # right now the tasks are not scoped to any list, basically there is only one list
    # but it will be important to fix this once multiple lists are available
    @task = Task.find(params[:id]) if params[:id]
  end  
end
