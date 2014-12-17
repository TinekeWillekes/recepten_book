class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes )
  end
  
  def download_book
    @categories = current_user.categories.order('row_order ASC').all( :include => :recipes )
    @recipes = current_user.recipes.active.all( :include => :quantities)
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

end
