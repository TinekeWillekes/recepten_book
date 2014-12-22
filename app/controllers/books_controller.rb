class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes )
    
  end
  
  def update_row_order
    @recipe = Recipe.find(recipe_params[:id])
    @recipe.row_order_position = recipe_params[:row_order_position]
    @recipe.update_attributes(recipe_params)
      render nothing: true 
  end
  
  def download_book
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes )
      respond_to do |format|
        format.html
        format.pdf do
          render pdf:           "Recepten boek",
                 layout:        'layouts/application.pdf.haml',  # layout used
                 orientation:   'Landscape',
                 cover:         'Receptenboek',
                 toc: {
                                disable_dotted_lines: true,
                                level_indentation: 5,
                                header_text: 'Inhoudsopgave',
                                },
                 footer:        { :right => '[page]' },
                 show_as_html:  params[:debug].present?    # allow debuging
        end 
      end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:id, :_destroy, :title, :directions, 
      :number_of_persons, :cooking_time, :recipe_image, :tip, :history, :category_id, :active, :row_order_position,
                                    :quantities_attributes => [:id, :_destroy, :amount, :recipe_id, :ingredient_id,
                                    :ingredient_attributes => [:id, :_destroy, :name]])
  end

end
