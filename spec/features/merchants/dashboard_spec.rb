require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
    @item_1 = @merchant_1.items.create!(name: 'Axe', description: 'Chop stuff', unit_price: 1000)
    @item_2 = @merchant_1.items.create!(name: 'Hammer', description: 'Hit stuff', unit_price: 1500)
    @item_3 = @merchant_1.items.create!(name: 'Drill', description: 'Drill stuff', unit_price: 5000)
    @item_4 = @merchant_2.items.create!(name: 'Wrench', description: 'Turn stuff', unit_price: 900)
    @item_5 = @merchant_2.items.create!(name: 'Nail', description: 'Nail stuff', unit_price: 50)
    visit "/merchants/#{@merchant_1.id}/dashboard"
  end
  it 'displays merchant name' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_no_content(@merchant_2.name)
  end
  
  it 'displays merchent items index link' do
    expect(page).to have_link('Merchant Items')
  end

  it 'has merchant items link go to correct page' do
    click_on 'Merchant Items'
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
  end

  it 'has merchant invoices link' do
    expect(page).to have_link('Merchant Invoices')
  end

  it 'has merchant invoices link go to correct page' do
    click_on 'Merchant Invoices'
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices")
  end

  xit 'has top 5 customers' do
  end

  xit 'has total successful transactions with merchants' do
  end

  xit 'displays items ready to ship' do
  end

  xit 'displays invoices by least recent' do
  end

end