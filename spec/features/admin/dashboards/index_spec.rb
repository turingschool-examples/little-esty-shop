require 'rails_helper' 

RSpec.describe 'Admin Dashboard Index Page' do 
  before :each do 
    visit ("/admin")
  end

  describe "When admin visit the admin dashboard (/admin)" do
    it "Then I see a header indicating that I am on the admin dashboard" do
      expect(page).to have_content("Admin")
    end
    
    it "has a link to the admin merchants index (/admin/merchants)" do
      click_on "Merchants"
      expect(current_path).to_not eq("/merchants")
      expect(current_path).to eq("/admin/merchants")
    end

    it "has links to the admin invoices index (/admin/invoices)" do
      click_on "Invoices"
      expect(current_path).to_not eq("/invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
end