require 'rails_helper' 

RSpec.describe 'Admin Dashboard Index Page' do 

  describe "When admin visit the admin dashboard (/admin)" do
    it "Story 19 - Then I see a header indicating that I am on the admin dashboard" do
      visit ("/admin")

      expect(page).to have_content("Admin Dashoard")
    end
  
  
  
  end
end