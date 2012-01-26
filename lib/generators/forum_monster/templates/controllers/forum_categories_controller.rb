class ForumCategoriesController < ApplicationController
  def index
    @forum_categories = ForumCategory.all
  end
  
  def new
    @forum_category = ForumCategory.new
  end
  
  def create
    @forum_category = ForumCategory.new(params[:category])
    
    if @forum_category.save
      flash[:notice] = "Category was successfully created."
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum_category = ForumCategory.find(params[:id])
  end
  
  def update
    @forum_category = ForumCategory.find(params[:id])
    
    if @forum_category.update_attributes(params[:category])
      flash[:notice] = "Category was updated successfully."
      redirect_to forums_url
    end
  end
  
  def destroy
    @forum_category = ForumCategory.find(params[:id])
    
    if @forum_category.destroy
      flash[:notice] = "Category was deleted."
      redirect_to forums_url
    end
  end
end