require "base64"

require "sublayer"
require "jira-ruby"
require "octokit"

# Load all Sublayer Actions, Generators, and Agents
Dir[File.join(__dir__, "actions", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "generators", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "agents", "*.rb")].each { |file| require file }

Sublayer.configuration.ai_provider = Sublayer::Providers::Gemini
Sublayer.configuration.ai_model = "gemini-1.5-pro-latest"
Sublayer.configuration.logger = Sublayer::Logging::DebugLogger.new

# Add custom Github Action code below:
repo = "sublayerapp/crm"

issues = JiraGetProjectIssuesAction.new(project_key: "CRM", jql_filter: "status = 'ready'").call
description = JiraGetIssueDescriptionAction.new(issue_key: issues.first.key).call

project_context = GetContextAction.new(path: "#{ENV['GITHUB_WORKSPACE']}/crm").call

issue_branch_name = "issue-#{issues.first.id}"

GithubCreateBranchAction.new(repo: repo, base_branch: "main", new_branch: issue_branch_name).call
GithubCreatePRAction.new(
  repo: repo,
  base: "main",
  head: issue_branch_name,
  title: issues.first.summary,
  body: description
).call

cucumber_branch_name = "#{issue_branch_name}-cucumber"
GithubCreateBranchAction.new(repo: repo, base_branch: issue_branch_name, new_branch: cucumber_branch_name).call

cucumber_files = CucumberTestsGenerator.new(
  project_context: project_context,
  story_title: issues.first.summary,
  story_details: description
).generate

GithubCreateFileAction.new(
  repo: repo,
  branch: cucumber_branch_name,
  file_path: cucumber_files.feature_file_path,
  file_content: cucumber_files.feature_file_content
).call

GithubCreateFileAction.new(
  repo: repo,
  branch: cucumber_branch_name,
  file_path: cucumber_files.step_file_path,
  file_content: cucumber_files.step_file_content
).call

GithubCreatePRAction.new(
  repo: repo,
  base: issue_branch_name,
  head: cucumber_branch_name,
  title: "Add Cucumber tests for #{issues.first.summary}",
  body: "This PR adds Cucumber tests for the JIRA story #{issues.first.key}:\n #{cucumber_files.high_level_feature_description}"
)
