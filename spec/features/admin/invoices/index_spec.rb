require 'rails_helper'

describe "Admin Invoices Index Page" do
  describe "As an admin" do
    describe "When I visit the admin Invoices index ('/admin/invoices')" do

      before :each do
        @merchant = Merchant.create!(name: "Carlos Jenkins") 
        @cust1 = Customer.create!(first_name: "Laura", last_name: "Fiel")
        @cust2 = Customer.create!(first_name: "Bob", last_name: "Fiel")
        @cust3 = Customer.create!(first_name: "John", last_name: "Fiel")
        @cust4 = Customer.create!(first_name: "Tim", last_name: "Fiel")
        @cust5 = Customer.create!(first_name: "Linda", last_name: "Fiel")
        @cust6 = Customer.create!(first_name: "Lucy", last_name: "Fiel")
        @inv1 = @cust1.invoices.create!(status: 1)
        @inv2 = @cust2.invoices.create!(status: 1)
        @inv3 = @cust3.invoices.create!(status: 1)
        @inv4 = @cust4.invoices.create!(status: 1)
        @inv5 = @cust6.invoices.create!(status: 1)
        @inv6 = @cust5.invoices.create!(status: 0)
        @inv7 = @cust6.invoices.create!(status: 0)
        @inv8 = @cust6.invoices.create!(status: 0)
        @inv9 = @cust4.invoices.create!(status: 0)
      end

      it 'Then I see a list of all Invoice ids in the system' do
        visit '/admin/invoices' 

        expect(page).to have_content(@inv1.id)
        expect(page).to have_content(@inv2.id)
        expect(page).to have_content(@inv3.id)
        expect(page).to have_content(@inv4.id)
        expect(page).to have_content(@inv5.id)
        expect(page).to have_content(@inv6.id)
        expect(page).to have_content(@inv7.id)
        expect(page).to have_content(@inv8.id)
        expect(page).to have_content(@inv9.id)
      end

      it 'Each id links to the admin invoice show page' do
        visit '/admin/invoices' 

        expect(page).to have_link("#{@inv1.id}")
        expect(page).to have_link("#{@inv2.id}")
        expect(page).to have_link("#{@inv3.id}")
        expect(page).to have_link("#{@inv4.id}")
        expect(page).to have_link("#{@inv5.id}")
        expect(page).to have_link("#{@inv6.id}")
        expect(page).to have_link("#{@inv7.id}")
        expect(page).to have_link("#{@inv8.id}")
        expect(page).to have_link("#{@inv9.id}")

        click_link("#{@inv1.id}")

        expect(page.current_path).to eq("/admin/invoices/#{@inv1.id}")
      end
    end
  end
end