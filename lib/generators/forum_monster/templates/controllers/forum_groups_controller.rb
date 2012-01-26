class ForumGroupsController < ApplicationController
  def index
    @forum_groups = ForumGroup.all
  end
  
  def new
    @forum_group = ForumGroup.new
  end
  
  def create
    @forum_group = ForumGroup.new(params[:forum_group])
    
    if @forum_group.save
      flash[:notice] = "Forum Group was successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum_group = ForumGroup.find(params[:id])
  end
  
  def update
    @forum_group = ForumGroup.find(params[:id])
    
    if @forum_group.update_attributes(params[:forum_group])
      flash[:notice] = "Forum Group was updated successfully."
      redirect_to forums_url
    end
  end
  
  def destroy
    @forum_group = ForumGroup.find(params[:id])
    
    if @forum_group.destroy
      flash[:notice] = "Forum Group was deleted."
      redirect_to forums_url
    end
  end
end