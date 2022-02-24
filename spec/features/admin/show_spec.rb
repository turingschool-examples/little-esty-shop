require 'rails_helper'

RSpec.describe 'the admin dashboard' do
  it 'exists' do
    visit '/admin'
  end
end
