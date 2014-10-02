def leave_review(comment, rating)
  visit '/restaurants'
  click_link 'Review Pret'
  fill_in "Comment", with: comment
  select rating, from: 'Rating'
  click_button 'Submit Review'
end

def add_restaurant(name, cuisine = '', description = '')
  visit '/restaurants'
  click_link "Add a restaurant"
  fill_in "Name", with: name
  fill_in "Cuisine", with: cuisine
  fill_in "Description", with: description
  click_button 'Create Restaurant'
end