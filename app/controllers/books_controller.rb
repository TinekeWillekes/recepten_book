class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes ) 
  end
  
  def show
    @book = current_user.book()
  end
  
  def new
    @book = current_user.build_book()
    @user = User.find(current_user.id)
  end
  
  def create
    @book = current_user.build_book(book_params)
    @user = User.find(current_user.id)
    if @book.save
      flash[:success] = "Added book information"
      redirect_to books_path
    else
      flash.now[:alert] = "Make sure you filled out all the necessary forms."
      render "new"
    end
  end
  
  def edit
    @book = current_user.book()
  end
  
  def update
    @book = current_user.book()
    if @book.update_attributes(book_params)
      flash[:success] = "Updated book information"
      redirect_to books_path
    else
      render "edit"
    end
  end
  
  def update_row_order
    @recipe = Recipe.find(recipe_params[:id])
    @recipe.row_order_position = recipe_params[:row_order_position]
    @recipe.update_attributes(recipe_params)
      render nothing: true 
  end
  
  def download_book
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes )
    @book = current_user.book()
      WickedPdf.new.pdf_from_string(
        render pdf:    'Receptenboek',
        footer:        { :content => render_to_string(:template => 'layouts/footer.pdf.erb')},
        layout:        'layouts/application.pdf.erb',  # layout used
        margin:        {:top => 10, :bottom =>10 },
        orientation:   'Landscape',
        cover:         render_to_string(:template => 'layouts/cover.pdf.erb'),
        toc: {
                       disable_dotted_lines: true,
                       level_indentation: 5,
                       header_text: 'Inhoudsopgave',
                       },
        show_as_html:  params[:debug].present? # allow debuging
      )
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, :foreword, :author, :blurb, :year_of_publication, :user_id)  
  end
  
  def recipe_params
    params.require(:recipe).permit(:id, :_destroy, :title, :directions, 
      :number_of_persons, :cooking_time, :recipe_image, :tip, :history, :category_id, :active, :row_order_position,
                                    :quantities_attributes => [:id, :_destroy, :amount, :recipe_id, :ingredient_id,
                                    :ingredient_attributes => [:id, :_destroy, :name]])
  end

end
