require "rails_helper"

RSpec.describe 'As an admin' do
  describe "when I click on the name of a merchant from the admin merchants index page" do
    it "redirects me to that merchant's admin show page and renders the name of the merchant" do
      @mer_1 = create(:merchant)

      visit '/admin/merchants'
      click_link(@mer_1.name)
      expect(page).to have_current_path("/admin/merchants/#{@mer_1.id}")
      expect(page).to have_content("#{@mer_1.name}")
    end
  end
end
