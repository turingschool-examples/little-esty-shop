require "rails_helper"

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @mer_1 = create(:merchant)
    @mer_2 = create(:merchant, name: "Target" )
  end

  it "shows merchant names on the dashboard" do
    visit merchant_dashboard_index_path(@mer_1)

    expect(page).to have_content("#{@mer_1.name}")
  end
end


# As a merchant,
# When I visit my merchant dashboard (/merchant/merchant_id/dashboard)
# Then I see the name of my merchant
