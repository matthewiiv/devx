- Always use gt for source control
- Never add comments to Linear, always just update the existing issue
- Use `gt add .`, `gt modify` and `gt sumbit` commands when you have changes you want to commit to the current branch
- If you're doing a refactor, adding types to something that doesn't have types, don't be afraid to change the APIs to work better with the newly typed code
- When working with Typescript. Never use `as` or cast.
- Whenever you create a PR. Ask a sub agent to review the PR. Be brutally honest.

When creating scripts, use the following rules:

- Make the script idempotent.
- Make the script dry run by default.
- Make the script batch process the data.
