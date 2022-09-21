require 'rails_helper'

RSpec.describe PullRequest do
  it 'does exist' do
    pulls_count = PullRequest.new(total_count: 999)
    expect(pulls_count).to be_instance_of(PullRequest)
    expect(pulls_count.total_count).to eq(999)
  end
end
