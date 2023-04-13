require 'rails_helper'

RSpec.describe 'Merchant Items Index Page', type: :feature do
  before(:each) do
    visit merchant_items_path(@merchant_1.id)
  end

  it 'has a header' do
    expect(page).to have_content("#{@merchant_1.name} Items")
  end

  it 'it has invoice ids as links' do
  

    visit merchant_items_path(@merchant_1)

    within "#item-#{@item_1.id}" do
      expect(page).to have_link(@item_1.name)
    end
  end
end

