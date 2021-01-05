require "rails_helper"

describe Customer, type: :model do
  describe "relations" do
    it { should have_many :invoices }
  end
end
