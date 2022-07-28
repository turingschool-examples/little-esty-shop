require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard' do 
    it 'has the name of the merchant' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_content('Spongebob The Merchant')
        expect(page).to_not have_content('Jon Doe')
    end

    it 'on the merchant dashboard I see a link to my items index page' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_link('Spongebob The Merchant Item Index')
        expect(page).to_not have_content('Jon Doe Item Index')
    end

    it 'on the merchant dashboard I can click on the link and be sent to items index page' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        click_link ('Spongebob The Merchant Item Index')

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    end

    it 'on the merchant dashboard I see a link to my invoice index page' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        expect(page).to have_link('Spongebob The Merchant Invoice Index')
        expect(page).to_not have_content('Jon Doe Invoice Index')
    end

    it 'on the merchant dashboard I can click on the link and be sent to invoices index page' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
        merchant_2 = Merchant.create!(name: 'Jon Doe')
        
        visit "/merchants/#{merchant_1.id}/dashboard"

        click_link ('Spongebob The Merchant Invoice Index')

        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
    end
end 