require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bobby", last_name: "Mendez")
    @invoice1 = Invoice.create!(status: "in progess", customer_id: @customer1.id)

    visit "/admin/invoices/#{@invoice1.id}"
  end
  
  it 'can show information related to that specific invoice' do


    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice1.status)    
    expect(page).to have_content(@invoice1.created_at.strftime("%A, %B %d, %Y"))    
    expect(page).to have_content(@customer1.first_name)
    expect(page).to have_content(@customer1.last_name)
  end

    # When I visit an admin invoice show page
    # Then I see all of the items on the invoice including:
    # - Item name
    # - The quantity of the item ordered
    # - The price the Item sold for
    # - The Invoice Item status
  xit '' do
    
  end
  
  # it '' do
  #   expect(page).to have_link("#{@invoice1.id}", href: "/admin/invoices/#{@invoice1.id}") 

  #   click_on "#{@invoice1.id}"

  #   expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
  # end
end