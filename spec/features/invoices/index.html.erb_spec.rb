require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        customers: nil,
        status: ""
      ),
      Invoice.create!(
        customers: nil,
        status: ""
      )
    ])
  end
end
