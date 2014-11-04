class CategoriesController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  
  def index
    if params[:search]
      @categories = current_user.categories.search(params[:search])
                                   .paginate(page: params[:page])
                                   .order(sort_column + " " + sort_direction)
    else
      @categories = current_user.categories.paginate(page: params[:page])
                                .order(sort_column + " " + sort_direction)
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
    @category.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end

  
  private

  def category_params
    params.require(:category).permit(:id, :name, :user_id, :row_order_position, :_destroy, :name)
  end
  
    # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end
  
  def sort_column
    Recipe.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
