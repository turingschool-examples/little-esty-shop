require 'rails_helper'

RSpec.describe "Layouts", type: :feature do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)
  end

  it 'should have contributer usernames' do
    visit admin_merchants_path
    expect(page).to have_content("Username: gjcarew")
  end

  it 'should have number of commits by user' do
    visit admin_merchants_path
    expect(page).to have_content("Username: gjcarew || Commits: 22")
  end

  
end