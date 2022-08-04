class Commit

  attr_reader :name,
              :contributions

  def initialize(data)
    @name = data["login"]
    @contributions = data["contributions"]
  end
end
