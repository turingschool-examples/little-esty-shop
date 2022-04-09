require "rails_helper"

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:status)}
    it { should validate_numericality_of(:unit_price)}
    it { should validate_presence_of(:enabled)}
  end
end
