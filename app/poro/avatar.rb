class Avatar
  attr_reader :avatar_urls

  def initialize(parsed)
    expected = ["ColinReinhart", "StephenWilkens", "CoryBethune", "tjhaines-cap", "devAndrewK"]
    urls = []
    parsed.each do |hash|
      if expected.include?(hash[:login])
        urls << hash[:avatar_url]
      end
    end
    @avatar_urls = urls
  end
end
