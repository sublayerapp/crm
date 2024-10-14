class GithubCreateEmptyCommitAction < Sublayer::Actions::Base
  def initialize(repo:, branch:, commit_message: "Empty commit")
    super(repo: repo)
    @repo = repo
    @branch = branch
    @commit_message = commit_message
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end

  def call
    begin
      latest_commit = @client.ref(@repo, "heads/#{@branch}").object.sha
      @client.create_commit(@repo, @commit_message, latest_commit, latest_commit)
      ref = @client.update_ref(@repo, "heads/#{@branch}", latest_commit)
      commit_url = ref.object.url
      Sublayer.configuration.logger.log(:info, "Empty commit created successfully on branch #{@branch}: #{commit_url}")
      commit_url
    rescue Octokit::Error => e
      error_message = "Error creating empty commit: #{e.message}"
      Sublayer.configuration.logger.log(:error, error_message)
      raise StandardError, error_message
    end
  end
end
