require 'rails_helper'

describe "Admin Invoice Show Page" do
  describe "As an admin" do
    describe "When I visit an admin invoice show page" do
      describe 'I see information related to that invoice including' do
        before :each do
          w = Date.new(2019, 7, 18)
          @cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
          @inv1 = @cust1.invoices.create!(status: 1, created_at: w)
        end

        it 'Invoice ID' do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@inv1.id)
        end

        it "Invoice Status" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@inv1.status)
        end

        it "Invoice created_at date in the format 'Monday, July 18, 2019'" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content("Thursday, July 18, 2019")

        end

        it "Customer first and last name" do
          visit "/admin/invoices/#{@inv1.id}"

          expect(page).to have_content(@cust1.first_name)
          expect(page).to have_content(@cust1.last_name)
        end
      end
    end
  end
end