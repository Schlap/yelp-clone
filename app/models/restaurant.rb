class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    if self.reviews.count == 0
      'N/A'
    else
      (self.reviews.inject(0) { |sum, review| sum + review.rating }) / self.reviews.count
    end
  end

end
