RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants show' do
    before :each do
      @merchant1 = create(:merchant)

      visit admin_merchant_path(@merchant1)
    end
    it 'can show the name of the merchant' do

      expect(page).to have_content(@merchant1.name)
    end

    it 'shows a link to update the merchant' do
      within('#merchant-info') do
        expect(page).to have_link('Update Merchant')
        click_link('Update Merchant')

        expect(current_path).to eq(edit_admin_merchant_path(@merchant1))
      end
    end
  end
end
