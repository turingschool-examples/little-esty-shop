require 'rails_helper'

RSpec.describe Holiday do
  it 'exists and has attributes' do
    data = { name: 'Holiday Season', date: "02-21-22"}
    repo = Holiday.new(data)

    expect(repo).to be_an_instance_of(Holiday)
    expect(repo.name).to eq(data[:name])
    expect(repo.date).to eq(data[:date])
  end
end
