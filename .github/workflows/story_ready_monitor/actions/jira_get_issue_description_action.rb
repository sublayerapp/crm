class JiraGetIssueDescriptionAction < Sublayer::Actions::Base
  def initialize(issue_key:)
    @issue_key = issue_key
    @client = JIRA::Client.new(
      username: ENV['JIRA_USERNAME'],
      password: ENV['JIRA_API_TOKEN'],
      site: ENV['JIRA_SITE'],
      context_path: '',
      auth_type: :basic
    )
  end

  def call
    begin
      issue = @client.Issue.find(@issue_key)
      description = issue.description
      Sublayer.configuration.logger.log(:info, "Successfully retrieved description for Jira issue #{@issue_key}")
      description
    rescue JIRA::HTTPError => e
      error_message = "Error fetching Jira issue description: #{e.message}"
      Sublayer.configuration.logger.log(:error, error_message)
      raise StandardError, error_message
    end
  end
end
