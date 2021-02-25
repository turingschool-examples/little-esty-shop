require "rails_helper"

RSpec.describe 'As an admin' do
  describe "when I visit the admin merchants index" do
    it "it displays the names of all the merchants" do
      @mer_1 = create(:merchant)
      @mer_2 = create(:merchant)
      @mer_3 = create(:merchant)
      @mer_4 = create(:merchant)
      @mer_5 = create(:merchant)
      @mer_6 = create(:merchant)

      visit '/admin/merchants'
      expect(page).to have_content(@mer_1.name)
      expect(page).to have_content(@mer_2.name)
      expect(page).to have_content(@mer_3.name)
      expect(page).to have_content(@mer_4.name)
      expect(page).to have_content(@mer_5.name)
      expect(page).to have_content(@mer_6.name)
    end
  end  
end
