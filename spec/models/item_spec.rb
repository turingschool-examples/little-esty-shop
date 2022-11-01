require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:nomi) {Merchant.create!(name: "Naomi LLC")}

  let!(:stickers) {nomi.items.create!(name: "Anime Stickers", description: "Random One Piece and Death Note stickers", unit_price: 599)}
  let!(:lamp) {nomi.items.create!(name: "Lava Lamp", description: "Special blue/purple wax inside a glass vessel", unit_price: 2000)}

  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'instance methods' do
    describe '#current_price' do
      it 'returns the current price of the item in dollars' do
        expect(lamp.current_price).to eq(20.0)
        expect(stickers.current_price).to eq(5.99)
      end 
    end
  end
end
