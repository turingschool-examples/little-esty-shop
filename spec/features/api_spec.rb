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

  xit "displays the repo name" do
    visit "admin/merchants"

    expect(page).to have_content("Repo: little-esty-shop")

  end

  xit "displays each users amount of commits" do
    visit '/'

    expect(page).to have_content("devAndrewK has _ commits")
    expect(page).to have_content("tjhaines-cap has _ commits")
    expect(page).to have_content("CoryBethune has _ commits")
    expect(page).to have_content("StephenWilkens has _ commits")
    expect(page).to have_content("ColinReinhart has _ commits")
  end
end
