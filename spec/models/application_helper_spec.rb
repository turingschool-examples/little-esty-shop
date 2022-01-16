require 'rails_helper'

RSpec.describe ApplicationHelper, type: :module do
  include ApplicationHelper

  describe 'money_honey' do
    xit "takes integers that represent dollars in cents and translates them into formatted currency strings" do
      expect(money_honey(100)).to eq('$1.00')
      expect(money_honey(0)).to eq('$0.00')
      expect(money_honey(1000000)).to eq('$10,000.00')
    end
  end
end
