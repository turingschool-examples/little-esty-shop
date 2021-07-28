require 'rails_helper' 

RSpec.describe 'Merchants Item Index Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')


    visit merchant_items_path(@merchant1.id)
  end

  it 'is on the correct page' do 
    expect(current_path).to eq(merchant_items_path(@merchant1.id))
    expect(page).to have_content("Merchant Items")
  end
end 