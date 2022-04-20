class RepoName
  attr_reader :name
  def initialize(data)
    @name = data['name']
  end

  def is_esty
    if @name == "little-esty-shop"
      puts @name
    end
  end
end
