class Repo
  attr_reader :name

  def initialize(data)
    if data.class == Array
       @name = data[1]
    else
       @name = data[:name]
    end
  end
end
