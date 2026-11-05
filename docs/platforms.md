# Platforms

## Claude app (web, desktop, mobile)
- Install: download `prismatize.zip` from the latest release, then Customize > Skills > "+" > Create skill > Upload a skill.
- Code execution must be enabled.
- Available on all plans. On Team and Enterprise, a skill can be shared with colleagues or published to the organization's library.
- Full mode when the session can run subagents. Otherwise Prism runs in reduced mode and says so.
- All roles use the model selected in the app. Pick the best one available.

## Claude Code
```bash
claude plugin marketplace add <owner>/prismatize
claude plugin install prism@prismatize
```
Full mode: advisors and reviewers run as parallel subagents. The plugin ships one agent per role with its own model: `prism:advisor` and `prism:ranker` on Sonnet, `prism:gap-finder`, `prism:chairman` and `prism:checker` on Opus. Cheaper than running everything on the top model, with judgement kept where it matters.

## Other agents that read SKILL.md
Some agents install skills straight from a GitHub folder (TypingMind, for example). Point them at `plugins/prism/skills/prismatize`.

## ChatGPT, Gemini and plain chat
Paste the content of `SKILL.md` and `style.md` into a project's or custom assistant's instructions. Without subagents, Prism runs in reduced mode: one analysis, a separate attack pass, then the verdict. It's labeled "Reduced Prism" because the five advisors can't be independent in a single response.

## Reduced vs full mode
- **Full:** five advisors answer without seeing each other. Their agreement is a real signal.
- **Reduced:** everything is written in one context, so angles influence each other. Still useful, less independent.
