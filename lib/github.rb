class Github
  def self.search(source, name)
    "https://api.github.com/search/#{source}?q=#{name}&#{Github.envs}"
  end

  def self.show(source, name)
    "https://api.github.com/#{source}/#{name}?#{Github.envs}"
  end

  def self.envs
    if ENV['github_client_id'] && ENV['github_client_secret']
      "client_id=#{ENV['github_client_id']}&client_secret=#{ENV['github_client_secret']}"
    end
  end
end
