require 'rails_helper'

RSpec.describe "Admin merchant edit feature" do
  describe 'edit page' do
    visit admin_merchant_path(@merchant_1)

    click_link "Update #{@merchant_1.name}"

    expect(current_path).to eq(edit_admin_merchant_path)
  end
end
