require 'rails_helper'

 RSpec.describe Template do
 	before(:each) do
 		@instance = Template.new(attribute)
 	end

 	it 'exists' do
 		expect(@instance).to be_a Template
 	end

 	it 'has attributes' do
 		expect(@instance.attribute).to eq (attribute)
 	end
 end
