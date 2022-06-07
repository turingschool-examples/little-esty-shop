require 'rails_helper'

RSpec.describe Contributor do
  it 'exists and has attributes' do
    data = {login: 'lukeswenson06, casefaz, wesatt, sage-skaff' } # will probably add to this
    repo = Contributor.new(data)
    # RepositoryFacade.contributor
    expect(repo).to be_an_instance_of(Contributor)
    expect(repo.login).to eq(data[:login])
  end
end
