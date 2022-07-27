require 'rails_helper'

RSpec.describe 'admin merchant index' do 
    it 'shows the name of each merchant in the system' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now)
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now)
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now)
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now)

        visit '/admin/merchants'

        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
        expect(page).to have_content("#{merchant_4.name}")
        expect(page).to have_content("#{merchant_5.name}")
    end 

     it 'has an admin merchant show page when you click on the merchant name' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now)
        
        visit '/admin/merchants'

        click_on("#{merchant_1.name}")

        expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
        expect(page).to have_content("#{merchant_1.name}")
    end 

    it 'has two sections - enabled and disabled - with a button next to each merchant based on category' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")
        merchant_2 = Merchant.create!(name: "Bobs Cranes", created_at: Time.now, updated_at: Time.now)
        merchant_3 = Merchant.create!(name: "Joe-Schmo Railroads", created_at: Time.now, updated_at: Time.now)
        merchant_4 = Merchant.create!(name: "Allison Bugaboo", created_at: Time.now, updated_at: Time.now)
        merchant_5 = Merchant.create!(name: "Castanza George", created_at: Time.now, updated_at: Time.now, status: "enabled")

        visit '/admin/merchants'

        within (".disabled_merchants") do 
            expect(page).to have_button("Enable")
            expect(page).to have_content("Bobs Cranes")
            expect(page).to have_content("Joe-Schmo Railroads")
            expect(page).to have_content("Allison Bugaboo")
        end 
        
          within (".enabled_merchants") do 
            expect(page).to have_button("Disable")
            expect(page).to have_content("Schroeder-Jerde")
            expect(page).to have_content("Castanza George")
        end 
    end 

    it 'has two sections - enabled and disabled - with a button next to each merchant based on category' do 
        merchant_1 = Merchant.create!(name: "Schroeder-Jerde", created_at: Time.now, updated_at: Time.now, status: "enabled")

        visit '/admin/merchants'

        within (page.all(".enabled_merchant_buttons")[0]) do 
            click_button("Disable")
        end 

        within (page.all(".disabled_merchant_buttons")[0]) do 
            expect(page).to have_button("Enable")
            expect(page).to have_content("Schroeder-Jerde")

            click_button("Enable")
        end 

        within (page.all(".enabled_merchant_buttons")[0]) do 
            expect(page).to have_button("Disable")
            expect(page).to have_content("Schroeder-Jerde")
        end 
    end 

end 