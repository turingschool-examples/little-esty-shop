require 'rails_helper'

RSpec.describe 'Admin Merchant show page' do 
  before :each do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones", status: "Disabled")
    @whb = Merchant.create!(name: "WHB", status: "Enabled")
    @lisa_frank = Merchant.create!(name: 'Lisa Frank Knockoffs', status: 'Enabled')
    @burger = Merchant.create!(name: 'Burger King', status: 'Disabled')
  
  end 

  it 'As an admin, when I click on the name of a merchant from the admin merchant index page' do
    visit admin_merchants_path
    expect(page).to have_link("#{@burger.name}")
    click_link("#{@burger.name}")
    expect(current_path).to eq(admin_merchant_path(@burger))
  end 
  
  it " After clicking on merchant from index page, I am taken to the merchant admin show page, and I see the name of that merchant" do 
    visit admin_merchant_path(@burger.id)
    expect(page).to have_content(@burger.name)
    expect(page).to have_content(@burger.status)
  end

  
   
end 

