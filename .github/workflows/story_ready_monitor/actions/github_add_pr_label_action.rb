class GithubAddPRLabelAction < GithubBase
  def initialize(repo:, pr_number:, label:)
    super(repo: repo)
    @pr_number = pr_number
    @label = label
  end

  def call
    begin
      @client.add_labels_to_an_issue(@repo, @pr_number, [@label])
      Sublayer.configuration.logger.log(:info, "Label '#{@label}' successfully added to PR ##{@pr_number} in #{@repo}")
      true
    rescue Octokit::Error => e
      error_message = "Error adding label to PR: #{e.message}"
      Sublayer.configuration.logger.log(:error, error_message)
      false
    end
  end
end
