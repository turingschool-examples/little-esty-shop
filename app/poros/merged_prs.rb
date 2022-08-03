require './app/poros/pull_request'
require './app/services/github_service'

class MergedPrs
    def pr_info
        service.prs.map do |data|
            PullRequest.new(data)
        end
    end

    def count
        pr_counts = {}
        prs = pr_info.map{|x| x.user}.group_by(&:to_s)
        prs.each do |k,v|
            pr_counts[k] = v.count
        end
        pr_counts
    end

    def service
        GithubService.new
    end
end
