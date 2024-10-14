class GithubCreateCommentAction < Sublayer::Actions::Base
  def initialize(repo:, pr_number:, body:)
    @repo = repo
    @pr_number = pr_number
    @body = body
    @client = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def call
    @client.add_comment(@repo, @pr_number, @body)
  end
end
