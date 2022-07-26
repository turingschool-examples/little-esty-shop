require 'rails_helper'

RSpec.describe Transaction do

  describe 'enums' do
    define_enum_for(:result).with([success, failed])
  end





end
