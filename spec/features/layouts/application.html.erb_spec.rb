require 'rails_helper'

RSpec.describe 'Application layout' do

  it 'shows github info on all pages' do
    github_info = GithubService.new
    render file: "app/views/layouts/application.html.erb"
    expect(rendered).to have_content(github_info.repo_name)
    expect(rendered).to have_content("BrianZanti: 51, Henchworm: 42, croixk: 22, dylan-harper: 49, jacksonvaldez: 10, jamisonordway: 1, scottalexandra: 3, timomitchel: 9")
    expect(rendered).to have_content(github_info.all_merged)
  end

end
