class ItemsController < ApplicationController
  respond_to :json
  
  def index
    respond_with Item.all
  end
  
  def show
    respond_with Item.find(params[:id])
  end
  
  def create
    respond_with Item.create(params[:item]) 
  end
  
  def update
    respond_with Item.update(params[:id], params[:item])
  end
  
  def destroy
    respond_with Item.destroy(params[:id])
  end
end
