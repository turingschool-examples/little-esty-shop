require 'rails_helper'

<<<<<<< HEAD
RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: "Pabu")

    visit merchant_dashboard_index_path(@merchant1)
  end

  it 'shows merchant name' do
    expect(page).to have_content(@merchant1.name)
  end
  it 'has link to merchant item index' do
    within("#index-buttons") do
      click_button "Items Index"
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end
  end
  it 'has link to merchant invoices index' do
    click_button "Invoices Index"
    expect(current_path).to eq(merchant_invoices_path(@merchant1))
  end
=======
RSpec.describe 'Merchant items index' do
  before do

    visit "merchant/#{@merchant.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

      expect(page).to have_current_path('/applications')
      expect(page).to have_content(@application_1.name)

    end
  end
>>>>>>> 3443533 (Test: spec files for merchant index and merchant item index)
end
