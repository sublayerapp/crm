class CucumberTestsGenerator < Sublayer::Generators::Base
  llm_output_adapter type: :named_strings,
    name: "cucumber_files",
    description: "List of Cucumber feature and step definition files",
    attributes: [
      { name: "high_level_feature_description", description: "A high level description of the feature"},
      { name: "feature_file_path", description: "The file path for the Cucumber feature file" },
      { name: "feature_file_content", description: "The content of the Cucumber feature file" },
      { name: "step_file_path", description: "The file path for the Cucumber step definition file" },
      { name: "step_file_content", description: "The content of the Cucumber step definition file" }
    ]

  def initialize(project_context:, story_title:, story_details:)
    @project_context = project_context
    @story_title = story_title
    @story_details = story_details
  end

  def generate
    super
  end

  def prompt
    <<-PROMPT
    You are an expert Ruby on Rails developer and Cucumber test writer. Your task is to generate Cucumber feature and step definition files based on a Rails application context and a JIRA story.

    Rails application context:
    #{@project_context}

    JIRA story title:
    #{@story_title}

    Story details and Acceptance criteria:
    #{@story_details}

    Please generate the following Cucumber files:
    1. A feature file that describes the functionality from the JIRA story and includes scenarios for each acceptance criterion.
    2. A step definitions file that implements the steps for the feature file

    For the feature file, make sure to cover all steps in the acceptance criteria
    For the step file, make sure to implement all steps that are needed to pass the feature file

    Ensure that the feature file uses Gherkin syntax and the step definitions file includes the necessary Ruby code to implement the steps.
    Use the Rails application context to inform your step implementations, referencing appropriate models, controllers, or other components as needed.

    Remember to make the Cucumber tests as specific and detailed as possible while keeping them readable and maintainable.
    PROMPT
  end
end
