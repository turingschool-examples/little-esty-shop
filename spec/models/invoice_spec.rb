require "rails_helper"

describe Invoice do
  describe "relationships" do
    it {should belong_to :customer}
  end
end
