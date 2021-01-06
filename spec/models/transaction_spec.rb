require "rails_helper"

describe Transaction, type: :model do
  describe "validations" do
    it {should define_enum_for(:result).with_values ["success", "failed"] }
  end

  describe "relations" do
    it {should belong_to :invoice}
  end
end
