RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
#lets you use factorybot methods like #create! in rspec files without explicitly calling FactoryBot before it