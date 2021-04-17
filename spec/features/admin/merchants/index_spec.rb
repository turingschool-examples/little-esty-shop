require 'rails_helper'

RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants index' do
    before :each do
      @merchant1 = create(:merchant, status: true)
      @merchant2 = create(:merchant, status: true)
      @merchant3 = create(:merchant, status: false)
      @merchant4 = create(:merchant, status: false)

      visit admin_merchants_path
    end

    it 'can show the name of each merchant in the system' do

      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
      expect(page).to have_content(@merchant4.name)
    end

    it "has links to take me to a merchant's show page" do
      within("#admin_merchants-#{@merchant1.id}") do
        click_on("Link to #{@merchant1.name}")
      end

      expect(current_path).to eq(admin_merchant_path("#{@merchant1.id}"))
    end

    it "Then next to each merchant name I see a button to disable or enable that merchant." do
      within("#admin_merchants-#{@merchant4.id}") do
        expect(page).to have_button("Enable")
       end

       within("#admin_merchants-#{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end
    end

    it "When I click this button I am redirected back to the admin merchants index" do
      within("#admin_merchants-#{@merchant1.id}") do
       click_button("Disable")
      end
      expect(current_path).to eq(admin_merchants_path)

      within("#disabled_merchants") do
        expect(page).to have_content(@merchant1.name)
      end

      within("#enabled_merchants") do
        expect(page).to_not have_content(@merchant1.name)
      end
    end
  end
end
