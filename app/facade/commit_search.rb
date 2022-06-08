require './app/poro/commit'
require './app/service/esty_service'

class CommitSearch
  def commit_information
    commit_counter = {"ColinReinhart" => 0, "StephenWilkens" => 0, "devAndrewK" => 0, "tjhaines-cap" => 0, "CoryBethune" => 0}
    page_number = 1
    commit_response = service.commits("https://api.github.com/repos/ColinReinhart/little-esty-shop/commits?per_page=100&page=#{page_number}")
    while commit_response != []
      commit_response.each do |commit|
        if commit[:author] != nil && commit_counter[commit[:author][:login]]
          commit_counter[commit[:author][:login]] += 1
        end
      end
      page_number += 1
      commit_response = service.commits("https://api.github.com/repos/ColinReinhart/little-esty-shop/commits?per_page=100&page=#{page_number}")
    end
    return commit_counter
  end

  def service
    EstyService.new
  end

end
