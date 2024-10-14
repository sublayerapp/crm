require "base64"

require "sublayer"
require "jira-ruby"
require "octokit"

# Load all Sublayer Actions, Generators, and Agents
Dir[File.join(__dir__, "actions", "*.rb")].each { |file| require file }
Dir[File.join(__dir__, "generators", "*.rb")].each { |file| require file }

Sublayer.configuration.ai_provider = Sublayer::Providers::Gemini
Sublayer.configuration.ai_model = "gemini-1.5-pro-latest"

# Add custom Github Action code below:

repo = "sublayerapp/crm"
issue_number = ENV['GITHUB_REF'].split('/').last.split('-').last
puts "GITHUB REF: #{ENV['GITHUB_REF']}"
puts "ISSUE NUMBER: #{issue_number}"
pr_number = ENV['PR_NUMBER']

pr_info = GetPRChangesAction.new(repo: repo, pr_number: pr_number).call
issue_info = JiraGetIssueDescriptionAction.new(issue_key: issue_number).call
project_context = GetContextAction.new(path: "#{ENV['GITHUB_WORKSPACE']}/crm").call

implementation_plan = ImplementationPlanGenerator.new(
  pr_info: pr_info,
  issue_info: issue_info,
  repo_context: repo_context
).generate

new_pr = GithubCreatePRAction.new(
  repo: repo,
  base: 'main',
  head: "issue-#{issue_number}",
  title: "Implementing Jira Story #{issue_number}",
  body: issue_info
).call

GithubCreateCommentAction.new( repo: repo, pr_number: new_pr.number, body: implementation_plan).call
GithubAddPRLabelAction.new(repo: repo, pr_number: new_pr.number, label: "ai-generated").call
