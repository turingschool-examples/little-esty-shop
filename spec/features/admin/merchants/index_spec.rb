require 'rails_helper'

describe "Admin Merchants Index Page" do

  before :each do
    @merchants = []
    5.times {@merchants << create(:merchant) }
    visit "/admin/merchants"
  end

  it "has a list of the name of each merchant in the system" do
    expect(page).to have_content(@merchants[0].name)
    expect(page).to have_content(@merchants[1].name)
    expect(page).to have_content(@merchants[2].name)
    expect(page).to have_content(@merchants[3].name)
    expect(page).to have_content(@merchants[4].name)
  end

end
