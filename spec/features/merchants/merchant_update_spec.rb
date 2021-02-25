require "rails_helper"

RSpec.describe 'As an admin' do
  describe "when I visit a merchant's admin show page" do
    it "renders a link to update the merchant's information" do
      @mer_1 = create(:merchant, id: 1, name: 'Hanks Ski Shop')
      visit 'admin/merchants/1'
      expect(page).to have_link('Update Merchant')
    end

    describe "when I click on the link" do
      it "it redirects me to a page to edit the merchant's information" do
        @mer_1 = create(:merchant, id: 1, name: 'Hanks Ski Shop')
        visit 'admin/merchants/1'
        click_link('Update Merchant')
        expect(page).to have_current_path('/admin/merchants/1/edit')
      end

      describe "when you fill out form and click submit" do
        it "redirects me to the merchant show page, where I see the updated information and a message saying that is was updated" do
          @mer_1 = create(:merchant, id: 1, name: 'Hanks Ski Shop')
          visit '/admin/merchants/1/edit'
          fill_in(:name, with: "Tonys Ski Shop")
          click_button('Submit')
          expect(page).to have_current_path('/admin/merchants/1')
          expect(page).to have_content('Tonys Ski Shop')
          expect(page).to have_content('Merchant updated successfully')
        end
      end
    end
  end
end
