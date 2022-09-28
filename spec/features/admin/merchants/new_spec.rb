require 'rails_helper'

RSpec.describe 'admin merchant new page' do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)

    pull_requests_count = 3
    allow(GithubFacade).to receive(:pull_requests).and_return(pull_requests_count)
  end

  it 'can create new merchant' do
    visit 'admin/merchants/new'

    fill_in("Name", with: "Costa Coffee")
    click_on 'Submit'

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("Costa Coffee")
  end

end
