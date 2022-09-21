require 'rails_helper'

RSpec.describe Contributor do
  it 'does exist' do
    user = Contributor.new(login: "Clever Name", contributions: 999)
    expect(user).to be_instance_of(Contributor)
    expect(user.login).to eq("Clever Name")
    expect(user.commits).to eq(999)
  end
end
