class ImplementationPlanGenerator < Sublayer::Generators::Base
  llm_output_adapter type: :single_string,
    name: "implementation_plan",
    description: "A detailed implementation plan for the given issue and cucumber specs"

  def initialize(pr_info:, issue_info:, repo_context:)
    @pr_info = pr_info
    @issue_info = issue_info
    @repo_context = repo_context
  end

  def generate
    super
  end

  def prompt
    <<-PROMPT
    You are an expert software developer tasked with creating a detailed implementation plan.

    Issue Information:
    #{@issue_info}

    PR Information (including Cucumber feature and specs):
    #{@pr_info}

    Repository Context:
    #{@repo_context}

    Based on the above information, create a detailed implementation plan that includes:
    1. A brief overview of the changes required
    2. A list of all files that need to be changed or created
    3. For each file, provide a detailed description of the changes or additions required
    4. Any potential challenges or considerations for the implementation

    Format your response as plain text with a paragraph and bullet points for each section, use no additional formatting
    PROMPT
  end
end
