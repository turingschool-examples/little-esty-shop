require "rails_helper"

describe Invoice, type: :model do
  describe "validations" do
    it {should define_enum_for(:status).with ['in progress', 'completed', 'cancelled'] }
  end

  describe "relations" do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :transactions}

    it {should have_many :invoice_items}
    it {should have_many :items}
  end
end
