require 'rails_helper'

RSpec.describe Contributors do
  it 'Exists and has expected attributes' do
    data = [ {login: "zel-imbriaco"}, {login: "scottsullivanltd"}]
    contributors = Contributors.new(data)

    expect(contributors.logins).to eq(data.map { |contributor| contributor[:login] })
    expect(contributors).to be_an_instance_of(Contributors)
  end
end