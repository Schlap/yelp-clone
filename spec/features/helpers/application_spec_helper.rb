def leave_review(comment, rating)
  visit '/restaurants'
  click_link 'Review Pret'
  fill_in "Comment", with: comment
  select rating, from: 'Rating'
  click_button 'Submit Review'
end