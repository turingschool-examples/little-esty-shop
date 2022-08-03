require 'rails_helper'

class Contributor

  attr_reader :login

  def initialize(data)
    @login = data[:login]
  end

end