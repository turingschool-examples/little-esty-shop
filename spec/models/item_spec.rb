require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
  end
end
