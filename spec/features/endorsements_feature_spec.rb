require 'rails_helper'
require_relative './helpers/application_spec_helper'

describe 'endorsing reviews' do

  before do
    pret = create :pret
    ethel = create :ethel
    login_as ethel, scope: :user
    leave_review "Average", '★★★'
  end

  it 'displays the updated review endorsement count immediately', js: true do
    visit '/restaurants'
    vincent = create :vincent
    login_as vincent, scope: :user
    click_link 'Endorse this review'
    expect(page).to have_content '1 endorsement'
  end

end