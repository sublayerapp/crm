class GithubGetPRBranchNameAction < Sublayer::Actions::Base
  def initialize(repo:, pr_number:)
    @repo = repo
    @pr_number = pr_number
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  def call
    pr = @client.pull_request(@repo, @pr_number)
    pr.head.ref
  end
end
