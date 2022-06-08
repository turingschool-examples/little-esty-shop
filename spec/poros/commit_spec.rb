require 'rails_helper'

RSpec.describe Commit do
  it "exists and has attributes" do
    data = "commit": {"author": {"login": "Eric",}
    commit = Commit.new(data)
    expect(commit).to be_an_instance_of(Commit)
    expect(commit.count).to eq(1)
  end
end
