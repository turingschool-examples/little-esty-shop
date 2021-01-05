require "rails_helper"

describe Item, type: :model do
  describe "relations" do
    it {should have_many :invoice_items}
    it {should have_many :invoices}
    it {should belong_to :merchant}
  end
end
