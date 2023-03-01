require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do

before(:each) do 
  repo_call = File.read('spec/fixtures/repo_call.json')
  stub_request(:get, 'https://api.github.com/repos/hadyematar23/little-esty-shop')
  .with(
    headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>"Bearer #{ENV['github_token']}",
      'User-Agent'=>'Faraday v2.7.4'
       }
  )
  .to_return(status: 200, body: repo_call, headers: {})

  @merchant1 = Merchant.create!(name: "Hady", uuid: 1) 
  @merchant2 = Merchant.create!(name: "Malena", uuid: 2) 

  @item_1 = @merchant1.items.create(name: "Salt", description: "it is salty", unit_price: 12)
  @item_2 = @merchant1.items.create(name: "Pepper", description: "it is peppery", unit_price: 11)
  @item_3 = @merchant2.items.create(name: "Spices", description: "it is spicy", unit_price: 13)
  @item_4 = @merchant2.items.create(name: "Sand", description: "its all over the place", unit_price: 14)
  @item_5 = @merchant2.items.create(name: "Water", description: "see item 1, merchant 1", unit_price: 15)

  @customer_1 = Customer.create(first_name: "Steve", last_name: "Stevinson")
  @customer_2 = Customer.create(first_name: "Steve", last_name: "Stevinson")

  @invoice_1 = @customer_1.invoices.create(status: 0)
  @invoice_2 = @customer_1.invoices.create(status: 0)
  @invoice_3 = @customer_1.invoices.create(status: 0)
  
end 

  describe "as an admin" do 
    describe "visit admin invoices index" do 
      it "see list of invoice IDs in the system" do 

        visit "/admin/invoices"
        expect(page).to have_content('little-esty-shop')
        expect(page).to have_link("Invoice Number #{@invoice_1.id}", href: "/invoices/#{@invoice_1.id}")
        expect(page).to have_link("Invoice Number #{@invoice_2.id}", href: "/invoices/#{@invoice_2.id}")
        expect(page).to have_link("Invoice Number #{@invoice_3.id}", href: "/invoices/#{@invoice_3.id}")
      end
    end
  end 
end 