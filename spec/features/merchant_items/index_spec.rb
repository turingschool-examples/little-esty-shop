require 'rails_helper'

RSpec.describe 'the mechant items index' do
  describe 'display' do
    it 'visit' do
      visit merchant_items_path(@merchant1)
      save_and_open_page
    end
  end
end
