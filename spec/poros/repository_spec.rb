# poro stands for plain old ruby object
require 'rails_helper'

RSpec.describe Repository do
  it 'exists and has attributes' do
    data = { name: 'Ruby Rhods Rails Renegades Test Repo'} # will probably add to this
    repo = Repository.new(data)
  
    expect(repo).to be_an_instance_of(Repository)
    expect(repo.name).to eq(data[:name])
  end
end
