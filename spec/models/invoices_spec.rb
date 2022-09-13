require "rails_helper"


RSpec.describe(Invoice, type: :model) do
  let(:invoice) { Invoice.new(    customer_id: 1,     status: "in progress") }

  it("is an instance of invoice") do
    expect(invoice).to(be_instance_of(Invoice))
  end
end
