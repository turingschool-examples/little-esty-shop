require 'rails_helper'

RSpec.describe NagerService do
  it 'exists' do
    ns = NagerService.upcoming_holidays

    expect(ns).to be_a(Array)
  end
end
