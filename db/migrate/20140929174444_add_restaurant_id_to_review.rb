class AddRestaurantIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :restaurant_id, :integer
  end
end
