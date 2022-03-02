require 'rails_helper'

RSpec.describe 'github api index' do

xit 'displays name of project repository' do 
    visit "/github_api/"

    expect(page).to have_content("stevenjames-turing/little-esty-shop")
end 

xit 'displays usernames of all users with 1 or more commits' do
    visit "/github_api/"
    
    within("#contributors") do 
        expect(page).to have_content("mbrandt00")
        expect(page).to have_content("stevenjames-turing")
        expect(page).to have_content("samlsmith424")
        expect(page).to have_content("Tross0208")
    end
end

xit 'displays the total count of Pull Requests for repo' do 
    visit "/github_api/"
    
    expect(page).to have_content("Pull Requests:")
    
  end
end
