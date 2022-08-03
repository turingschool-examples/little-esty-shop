class Commit

  attr_reader :name,
              :contributions

  def initialize(data)
    binding.pry
    @name = data["login"]
    @contributions = data["contributions"]
  end
end
