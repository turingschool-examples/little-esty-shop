require 'rails_helper'

RSpec.describe 'admin merchant index page' do
  before :each do
    names_array = {'gjcarew' => 22, 'stephenfabian' => 25, 'Rileybmcc' => 22, 'KevinT001' => 11}
    allow(GithubFacade).to receive(:commits).and_return(names_array)
  end

  before :each do
    @merchant1 = Merchant.create(name: "Robespierre")
    @merchant2 = Merchant.create(name: "BFranklin")
  end

  it 'can display merchant name on show page' do
    visit "/admin/merchants/#{@merchant1.id}"

    expect(page).to have_content("Robespierre")
  end

end
