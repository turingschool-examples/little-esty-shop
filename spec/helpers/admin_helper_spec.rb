require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AdminHelper. For example:
#
# describe AdminHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AdminHelper, type: :helper do
  xit 'returns the date formated like Monday, March 20, 1991' do
    # active record timestamps are of type ActiveSupport::TimeWithZone
    # using Time.zone.now to simulate this
    time = Time.zone.now
    string = AdminHelper.format_date time
  end
end
