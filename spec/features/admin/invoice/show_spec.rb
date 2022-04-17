require 'rails_helper'

RSpec.describe "Invoice Show Page" do
    before :each do 
        @customer_1 = Customer.create!(
            first_name: "Malcolm",
            last_name: "Jordan",
            created_at: Date.current,
            updated_at: Date.current
        )
        @invoice_1 = @customer_1.invoices.create!(
            status: 1,
            created_at: Date.new(2020,12,12),
            updated_at: Date.current
        )
        visit "/admin/invoices/#{@invoice_1.id}"
    end

    it "contains information about the invoice" do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content("Monday, July 18, 2019")
    expect(page).to have_content("Malcolm Jordan")
    end 

end 