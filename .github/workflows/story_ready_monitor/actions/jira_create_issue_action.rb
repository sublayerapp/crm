require "pry"

class JiraCreateIssueAction < Sublayer::Actions::Base
  def initialize(project_key:, issue_type:, summary:, description: nil, custom_fields: {})
    @project_key = project_key
    @issue_type = issue_type
    @summary = summary
    @description = description
    @custom_fields = custom_fields
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
      issue = create_issue
      Sublayer.configuration.logger.log(:info, "Jira issue created successfully: #{issue.id}")
      return issue
    rescue JIRA::HTTPError => e
      error_message = "Error creating Jira issue: #{e.message}"
      Sublayer.configuration.logger.log(:error, error_message)
      raise StandardError, error_message
    end
  end

  private

  def create_issue
    issue = @client.Issue.build

    issue_params = {
      'fields' => {
        'project' => { 'key' => @project_key },
        'summary' => @summary,
        'issuetype' => { 'name' => @issue_type },
        'description' => @description
      }
    }

    @custom_fields.each do |field_id, value|
      issue_params['fields'][field_id] = value
    end

    issue.save(issue_params)
    return issue
  end
end
