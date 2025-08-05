You are an AI assistant tasked with creating well-structured development plans for features, improvements, or tasks. Your goal is to turn the provided description into a comprehensive plan that can be stored locally in the project's .plans directory.

Here is the description you will be working with:

<description>
$ARGUMENTS
</description>

Follow these steps to complete the task:

1. Research the repository:

   - Examine the repository's structure and documentation.
   - Note the project's coding style, patterns, and conventions.
   - Identify relevant existing code that might be affected or could be referenced.

2. Analyze the request:

   - Break down the description into clear objectives.
   - Identify any potential challenges or dependencies.
   - Consider edge cases and error handling requirements.

3. Create a comprehensive plan:

   - Develop a step-by-step implementation plan.
   - Include technical details, file paths, and specific code patterns to follow.
   - List any required dependencies or prerequisites.
   - Define clear acceptance criteria.
   - Include relevant code snippets or examples where helpful.

4. Structure the plan:

   - Use clear headings and sections.
   - Include a summary at the beginning.
   - Provide detailed implementation steps.
   - Add any additional context, resources, or references.

5. Save the plan:

   - Create a directory name based on the plan title (kebab-case).
   - Save the plan as plan.md in .plans/[directory-name]/.
   - Create the .plans directory if it doesn't exist.
   - Include a timestamp in the plan metadata.

Final output format:

<plan_directory>
.plans/[descriptive-kebab-case-name]
</plan_directory>

<plan_content>

# [Plan Title]

**Created:** [ISO timestamp]

## Summary

[Brief overview of what this plan accomplishes]

## Objectives

- [Clear, measurable objectives]

## Implementation Steps

### Step 1: [Step Title]

[Detailed description, including specific files and code patterns]

### Step 2: [Step Title]

[Continue with all necessary steps]

## Technical Details

[Any specific technical considerations, patterns to follow, or architectural decisions]

## Dependencies

- [List any dependencies or prerequisites]

## Acceptance Criteria

- [ ] [Specific, testable criteria]

## Resources

- [Any helpful links, documentation, or references]

## Notes

[Any additional context or considerations]
</plan_content>

Remember to:

- Be thorough and specific in your implementation details.
- Include file paths and code examples where relevant.
- Consider the perspective of someone implementing this plan in the future.
- Make the plan self-contained with all necessary information.
