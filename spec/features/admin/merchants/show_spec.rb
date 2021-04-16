RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants show' do
    it 'can show the name of the merchant' do
      merchant1 = create(:merchant)

      visit "/admin/merchants/#{merchant1.id}"

      expect(page).to have_content(merchant1.name)
    end
  end
end
