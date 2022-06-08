require 'rails_helper'

RSpec.describe 'tests for API service methods' do
  xit 'can display the total number of merged pull requests' do
    visit '/admin'
    expect(page).to have_content("Pull Requests: ")
  end

  xit "can display the avatars for all the team members on every page" do
    visit '/admin/invoices'
    

    expect(page).to have_css("img[src='https://avatars.githubusercontent.com/u/98759023?v=4']")
    expect(page).to have_css("img[src='https://avatars.githubusercontent.com/u/60715457?v=4']")
    expect(page).to have_css("img[src='https://avatars.githubusercontent.com/u/95403666?v=4']")
    expect(page).to have_css("img[src='https://avatars.githubusercontent.com/u/98788282?v=4']")
    expect(page).to have_css("img[src='https://avatars.githubusercontent.com/u/97638081?v=4']")
  end
end
