class Book < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title, length: { maximum: 30 }, presence: true
  validates :author, length: { maximum: 30 }, presence: true
  validates :year_of_publication, presence: true, numericality: true

end
