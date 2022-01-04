require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant}
end
