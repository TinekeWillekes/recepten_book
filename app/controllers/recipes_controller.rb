class RecipesController < ApplicationController
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  
  def index
    if params[:search]
      @recipes = current_user.recipes.search(params[:search])
                                     .paginate(page: params[:page])
                                     .order(sort_column + " " + sort_direction)
    else
      @recipes = current_user.recipes.paginate(page: params[:page])
                                     .order(sort_column + " " + sort_direction)
    end
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
    @list_of_ingredients = @recipe.quantities.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      flash[:success] = "Added new recipe"
      redirect_to recipes_path
    else
      flash.now[:error] = "Make sure you filled out all the forms."
      render "new"
    end
  end
  
  def edit
    @recipe = current_user.recipes.find(params[:id])
  end
  
  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      flash[:success] = "Recipe updated"
      redirect_to recipes_path
    else
      render 'edit'
    end
  end
  
  def destroy
    current_user.recipes.find(params[:id]).destroy
    flash[:success] = "Recipe deleted."
    redirect_to recipes_path
  end
  
  def activate
		@recipe = current_user.recipes.find(params[:id]);
		@recipe.update_attributes({:active => 1})
		redirect_to recipes_path
	end
	
	def deactivate
		@recipe = current_user.recipes.find(params[:id]);
		@recipe.update_attributes({:active => 0})
		redirect_to recipes_path
	end
  
  private

  def recipe_params
    params.require(:recipe).permit(:id, :_destroy, :title, :directions, 
      :number_of_persons, :cooking_time, :recipe_image, :tip, :history, :category_id,
                                    :quantities_attributes => [:id, :_destroy, :amount, :recipe_id, :ingredient_id,
                                    :ingredient_attributes => [:id, :_destroy, :name]])
  end
  
  def sort_column
    Recipe.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
