require 'rails_helper'

RSpec.describe 'API helper module' do
  describe '#gh_user_names' do
    it 'returns an array of all users working on a GitHub repository' do
      
      expect(gh_user_names).to eq(["Alan Krumholz", "Alana Kneiling", "Astrid Hecht", "Jake Kim"])
    end
  end
end