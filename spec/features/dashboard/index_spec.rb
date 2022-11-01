require 'rails_helper'

RSpec.describe 'merchant dashboard show page' do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}
  let!(:tyty) {Merchant.create!(name: "TyTy's Grub")}

  describe 'visit merchant dashboard' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(nomi)

      expect(page).to have_content(nomi.name)
    end
  end
end