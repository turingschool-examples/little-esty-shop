require 'rails_helper'

RSpec.describe 'application helper' do
  describe '#price_round' do
    it "formats prices from cents to dollars"do
      expect(helper.price_round(12345)).to include('$')
      expect(helper.price_round(12345)).to eq('$123.45')
      expect(helper.price_round(123)).to eq('$1.23')
      expect(helper.price_round(12)).to eq('$0.12')
      expect(helper.price_round(1)).to eq('$0.01')
    end
  end

  describe '#get_names' do
    it 'returns the collaborators names in an array' do
      expect(helper.get_names).to eq(["cemccabe", "beddings81", "anthonytallent", "Adrlloyd"])
    end
  end

  describe '#repo_name' do
    it 'returns the repo name' do
      expect(helper.repo_name).to eq("anthonytallent/little-esty-shop")
    end
  end

  describe '#pull_request' do
    it 'returns the Pull Requests as an integer' do
      expect(helper.pull_request).to be_a(Integer)
    end
  end

  describe '#get_commits' do
    it 'returns an array of all the commits' do
      expect(helper.get_commits).to be_a(Array)
    end
  end

  describe 'commit_count' do
    it 'counts up the commits by users and displys it in a hash' do
      expect(helper.commit_count).to be_a(Hash)
    end
  end
end