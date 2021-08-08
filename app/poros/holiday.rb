class Holiday
  attr_reader :name1,
              :date1,
              :name2,
              :date2,
              :name3,
              :date3
  def initialize(repo_data)
    @name1 = repo_data[0][:name]
    @date1 = repo_data[0][:date]
    @name2 = repo_data[1][:name]
    @date2 = repo_data[1][:date]
    @name3 = repo_data[2][:name]
    @date3 = repo_data[2][:date]
  end
end