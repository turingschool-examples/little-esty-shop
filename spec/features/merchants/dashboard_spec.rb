require 'rails_helper'

RSpec.describe 'Merchant Dashboard Feature Spec' do
before(:each) do 
  @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
  @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

end 

  describe "as a visitor" do #user story 1 
    describe "visit merchant dashboard" do 
      it "the visitor will see the name of the merchant" do 

        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content("Merchant Name: #{@merchant1.name}")

        visit "/merchants/#{@merchant2.id}/dashboard"

        expect(page).to have_content("Merchant Name: #{@merchant2.name}")

      end

      it "see the link to merchant items index" do 
        
        visit "/merchants/#{@merchant1.id}/dashboard" 

        expect(page).to have_link("#{@merchant1.name}'s Items", href: "/merchants/#{@merchant1.id}/items")

        expect(page).to have_link("#{@merchant1.name}'s Invoices", href: "/merchants/#{@merchant1.id}/invoices")

      end
    end
  end


end 
