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
end