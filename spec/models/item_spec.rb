require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    # it { should validate_presence_of(:status) } <<<<<<<< tbd if we should add this in. I don't think so because there is no status column in our items csv. I added a status column in order to update the item's status when clicking enabled/disabled
  end
end
