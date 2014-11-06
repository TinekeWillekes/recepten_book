class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = current_user.categories.all( :include => :recipes )
  end

end
