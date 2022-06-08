require 'rails_helper'

RSpec.describe 'tests for API service methods' do
  xit 'can display the total number of merged pull requests' do
    visit '/admin'
    expect(page).to have_content("Pull Requests: ")
  end

  xit 'can display all contributor usernames' do
    visit '/admin/merchants'
    expect(page).to have_content("devAndrewK")
    expect(page).to have_content("tjhaines-cap")
    expect(page).to have_content("CoryBethune")
    expect(page).to have_content("StephenWilkens")
    expect(page).to have_content("ColinReinhart")
  end
end