class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = current_user.categories.find(:all, :include => :recipes )
  end

end
