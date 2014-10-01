class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    if self.reviews.count == 0
      'N/A'
    else
      (self.reviews.map { |x| x.rating }.inject(:+)) / self.reviews.count
    end
  end

end
