require 'rails_helper'

RSpec.describe 'Merchant items index' do
  before do

    visit "merchant/#{@merchant.id}/items"
  end

  describe 'Displays' do
    it 'lists names of all merchant items' do

      expect(page).to have_current_path('/applications')
      expect(page).to have_content(@application_1.name)

    end
  end
end
