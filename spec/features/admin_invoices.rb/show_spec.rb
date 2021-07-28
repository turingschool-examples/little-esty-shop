require 'rails_helper' 

RSpec.describe 'Admin Invoice Show Page' do 
  before :each do 
    @customer = Customer.create(first_name: 'Tom', last_name: 'Holland')
    @i = Invoice.create!(status: 2, customer_id: @customer.id)   

    visit "/admin/invoices/#{@i.id}"
  end

  it 'is on the correct page' do 
    expect(current_path).to eq("/admin/invoices/#{@i.id}")
    expect(page).to have_content("Invoice Id: #{@i.id}")
  end

  it 'can take user to invoice edit page' do 
    click_link "Edit"

    expect(current_path).to eq("/admin/invoices/#{@i.id}/edit")
    expect(page).to have_content('Editing Admin Invoice')
  end
end 