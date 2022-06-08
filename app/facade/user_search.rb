require './app/service/esty_service'

class UserSearch

  def repo_usernames
    username_array = []
    expected = ["devAndrewK", "tjhaines-cap", "CoryBethune", "StephenWilkens", "ColinReinhart"]
    service.repo_usernames.each do |user|
      if expected.include?(user[:login])
        username_array << user[:login]
      end
    end
    username_array
  end

  def service
    EstyService.new
  end
end