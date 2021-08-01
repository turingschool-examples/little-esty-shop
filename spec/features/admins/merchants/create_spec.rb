require 'rails_helper'

RSpec.describe 'merchant creation' do
  before :each do
    visit new_admin_merchant_path
  end

  describe 'the merchant new' do
    it 'renders the new form' do

      expect(page).to have_content('Create A New Merchant')
      expect(find('form')).to have_content('Name')
    end
  end

  describe 'the merchant create' do
    context 'given valid data' do
      it 'creates a merchant a redirects back to the merchant index page' do

        fill_in 'Name', with: 'Clif and Co'

        click_button 'Create Merchant'

        expect(page).to have_content('Clif and Co')
        expect(current_path).to eq(admin_merchants_path)
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do

        click_button 'Create Merchant'

        expect(current_path).to eq(new_admin_merchant_path)
        expect(page).to have_content("Error: Field Cannot Be Left Blank")
      end
    end
  end
end
