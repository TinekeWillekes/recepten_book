class Category < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  
  belongs_to :user
  has_many :recipes
  
  validates :user_id, presence: true
  validates :name, length: { maximum: 30 }, presence: true
  
  self.per_page = 10

  private
  
  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
end
