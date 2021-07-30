require 'rails_helper' 

RSpec.describe 'Merchants Item Index Page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Tom Holland')
    @merchant2 = Merchant.create!(name: 'Mary Jane')
    
    @item1 = Item.create!(name: 'spider suit', description: 'saves lives', unit_price: '10000', merchant_id: @merchant1.id)
    @item2 = Item.create!(name: 'web shooter', description: 'shoots webs', unit_price: '5000', merchant_id: @merchant1.id)
    @item3 = Item.create!(name: 'upside down kiss', description: 'That Mary jane Swag', unit_price: '15000', merchant_id: @merchant2.id)

    visit merchant_items_path(@merchant1.id)
  end

  it 'is on the correct page' do 
    expect(current_path).to eq(merchant_items_path(@merchant1.id))
    expect(page).to have_content("Merchant Items")
  end

  it 'can display all of the merchants items' do 
    expect(page).to have_content('Merchants Items')

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to_not have_content(@item3.name)
  end
end 