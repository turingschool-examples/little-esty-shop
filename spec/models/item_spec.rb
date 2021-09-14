require 'rails_helper'
# rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do
  describe 'relationships' do
    let(:item) { create :item }
    it { should belong_to(:merchant) }
  end
end
