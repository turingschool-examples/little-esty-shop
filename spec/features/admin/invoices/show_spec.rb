require 'rails_helper'

RSpec.describe 'admin invoice show' do
    let!(:joey) { Customer.create!(first_name: "Joey", last_name: "Ondricka")}

    let!(:invoice1) { joey.invoices.create!(status: 2) }
    let!(:invoice2) { joey.invoices.create!(status: 1) }
    let!(:invoice3) { joey.invoices.create!(status: 0) }
    let!(:invoice4) { joey.invoices.create!(status: 2) }
    # let!(:item1) { invoice1.items.create!(status: 2) }
    # let!(:item2) { invoice4.items.create!(status: 2) }
    
end