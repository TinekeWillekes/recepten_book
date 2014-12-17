class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if params[:search]
      @categories = current_user.categories.rank(:row_order).search(params[:search])

    else
      @categories = current_user.categories.rank(:row_order).paginate(page: params[:page])

    end
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:success] = "Added new category"
      redirect_to categories_path
    else
      flash.now[:error] = "Make sure you filled out all the forms."
      render "new"
    end
  end
  
  def edit
    @category = current_user.categories.find(params[:id])
  end
  
  def update
    @category = current_user.categories.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to categories_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted."
    redirect_to categories_path
  end
  
  def update_row_order
    @category = Category.find(category_params[:id])
    @category.row_order_position = category_params[:row_order_position]
    @category.update_attributes(category_params)
      render nothing: true 
  end

  
  private

  def category_params
    params.require(:category).permit(:id, :name, :user_id, :row_order_position, :_destroy, :name)
  end
  
    # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

end
