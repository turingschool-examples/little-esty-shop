first_model = 'no'
model_sing = 'transaction'
model_plural = 'transactions'

#make controller
Dir.chdir('app')
Dir.chdir("controllers")
Dir.chdir("admin")
system "touch #{model_plural}_controller.rb"
writer = File.write("#{model_plural}_controller.rb",
  "# app/controllers/#{model_sing}_controller.rb

class #{model_plural.capitalize}Controller < ApplicationController

  def create
    #{model_sing.capitalize}.create(#{model_sing}_params)
    redirect_to '/#{model_plural}'
  end

  def destroy
    #{model_sing} = #{model_sing.capitalize}.find(params[:id])
    #{model_sing}.destroy
    redirect_to '/#{model_plural}'
  end

  def edit
    @#{model_sing} = #{model_sing.capitalize}.find(params[:id])
  end

  def index
    @#{model_plural} = #{model_sing.capitalize}.all
  end

  def new
  end

  def show
  @#{model_sing} = #{model_sing.capitalize}.find(params[:id])
  end

  def update
    #{model_sing} = #{model_sing.capitalize}.find(params[:id])
    #{model_sing}.update(#{model_sing})
    #{model_sing}.save\n
    redirect_to action: 'show', id: params[:id]
  end

  private

  def #{model_sing}_params
    params.permit(#add params here in :name, :age format)
  end
end")

#make views
Dir.chdir('..')
Dir.chdir('..')
Dir.chdir("views")
Dir.chdir("admin")
system "mkdir #{model_plural}"
Dir.chdir "#{model_plural}"
system "touch index.html.erb"
system "touch edit.html.erb"
system "touch new.html.erb"
system "touch show.html.erb"

#make spec files
Dir.chdir('..')
Dir.chdir('..')
Dir.chdir('..')
Dir.chdir('..')
Dir.chdir("spec")
if first_model == 'yes'
  system "mkdir features"
  system "mkdir models"
end
  Dir.chdir("features")
  Dir.chdir("admin")
  system "mkdir #{model_plural}"
  Dir.chdir "#{model_plural}"

  #set up index_spec.rb
system "touch index_spec.rb"
writer = File.write("index_spec.rb",
"require 'rails_helper'

RSpec.describe '#{model_plural} index page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
  end

  describe 'page functionality' do
  end
end")

    #set up edit_spec.rb
    system "touch edit_spec.rb"
writer = File.write("edit_spec.rb",
"require 'rails_helper'

RSpec.describe '#{model_plural} edit page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
  end

  describe 'page functionality' do
  end
end")

    #set up new_spec.rb
    system "touch new_spec.rb"

writer = File.write("new_spec.rb",
"require 'rails_helper'

RSpec.describe '#{model_plural} new page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
  end

  describe 'page functionality' do
  end
end")

    #set up show_spec.rb
    system "touch show_spec.rb"

writer = File.write("show_spec.rb",
"require 'rails_helper'

RSpec.describe '#{model_plural} show page', type: :feature do
  before(:each) do
  end

  describe 'page appearance' do
  end

  describe 'page functionality' do
  end
end")

