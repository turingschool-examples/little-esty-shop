require 'rails_helper'

RSpec.describe 'Merchant Dashboard Page', type: :feature do 

  it "lists the name of the merchant" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    visit "/merchants/#{merchant1.id}/dashboard"

    within "div#merchant" do 
      expect(page).to have_content("#{merchant1.name}") 
    end

    visit "/merchants/#{merchant2.id}/dashboard"
    within "div#merchant" do 
      expect(page).to have_content("#{merchant2.name}") 
    end

    visit "/merchants/#{merchant3.id}/dashboard"
    within "div#merchant" do 
      expect(page).to have_content("#{merchant3.name}") 
    end
  end

  it "can list a link to merchant items and invoices indexes" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes")
		merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
		merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)
    item4 = Item.create!(name: "macrame runner", description: 'handmade macrame runner', unit_price: 2500, merchant_id: merchant3.id)

    visit "/merchants/#{merchant1.id}/dashboard"
    
    within "div#merchants" do 
      expect(page).to have_link("#{merchant1.name}'s Item Index")
      expect(page).to have_link("#{merchant1.name}'s Invoice Index")
    end

    visit "/merchants/#{merchant2.id}/dashboard"

    within "div#merchants" do  
      expect(page).to have_link("#{merchant2.name}'s Item Index")
      expect(page).to have_link("#{merchant2.name}'s Invoice Index") 
    end

    visit "/merchants/#{merchant3.id}/dashboard"

    within "div#merchants" do 
      expect(page).to have_link("#{merchant3.name}'s Item Index")
      expect(page).to have_link("#{merchant3.name}'s Invoice Index")
    end
  end
end
