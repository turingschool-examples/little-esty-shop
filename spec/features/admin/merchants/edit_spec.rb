require 'rails_helper'

RSpec.describe 'admin merchant update page' do
  describe '#edit' do
    it 'edit form contains current merchant information' do

      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      visit "admin/merchants/#{merchant_1.id}/edit"

      expect(page).to have_field('Merchant Name', with: 'Spongebob The Merchant')
    end
  end
end