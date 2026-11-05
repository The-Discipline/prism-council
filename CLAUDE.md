# CLAUDE.md: Prism

Context for any Claude Code session working on this repo. Read it fully before changing the skill.

## What Prism is

A Claude skill: a decision council for one-person businesses. One decision goes in, five independent advisors answer, two reviewers judge anonymously, a chairman gives a verdict and one action, a checker tests it before delivery.

- Name: Prism (the brand). Every technical identifier is `prismatize`: repo, skill, ZIP. Claude Code command: `/prism:prismatize`. Triggers: "prismatize this", "prism this", "prismatiser".
- "council" lives in descriptions and topics for search, never as a name.
- Tagline: "One decision, five angles, one verdict."
- Landing tagline: "The advisory board for businesses of one."
- Owner: Virgile Gouala (goua.la). Product from day one, tested on real decisions first.
- Method credit: Andrej Karpathy's LLM Council. Inspired by Ole Lehmann's llm-council skill. Prism is written from scratch, no text copied from either (neither repo has a license).

## Repo map

- `plugins/prism/skills/prismatize/`: the skill (SKILL.md, style.md, context-template.md). This folder is also what gets zipped for Claude app upload.
- `.claude-plugin/marketplace.json` + `plugins/prism/.claude-plugin/plugin.json`: make the repo a Claude Code plugin marketplace.
- `docs/`: how it works (diagrams), platforms, context guide, examples, identity brief.
- `examples/`: fictional filled context; run example (to do, from a real run).
- `scripts/`: style check, ZIP build.

## Locked decisions (with the reason)

- **Scope: one-person businesses, decisions only.** "Business in general" is what the original skill already does. Exploration produces interesting text that changes nothing. A gate at step 1 enforces this, the description repeats it, the README explains it.
- **Advisors:** Contrarian, First Principles, Expansionist, Executor, Buyer. The Buyer replaces the original Outsider, which claimed zero context but received full context. The Buyer only gets what a prospect would see.
- **No Competitor advisor.** An LLM has no competitor data; it would duplicate the Contrarian. Alternatives belong to the Buyer ("what would I do instead"). Real competitor research is a possible future evidence step.
- **Two reviewers, not five.** Ole's five reviewers were identical prompts. Reviewer 1 ranks (Karpathy's FINAL RANKING format, evaluation before ranking). Reviewer 2 hunts gaps (shared assumption, missing topic, the claim that flips the decision). No aggregate average rank: false precision with two reviewers.
- **Chairman has four outcomes:** Verdict, Top 3 (only on request), Not yet (missing fact + cheapest test + deadline + go/stop), Escalate (legal/tax/regulatory, binding high-stakes commitments, or decisions shared with a partner or family: name who decides, questions to bring, what not to do before). Ole's version forbade "it depends", which pushed confident verdicts on guesses.
- **Verdict check (from a software-factory review loop):** a checker agent tests the chairman's draft on 7 points, answers PASS or CHANGES, one revision max. More rounds make a verdict more convincing, not better. Pure legal/tax questions skip the council and go straight to Escalate.
- **Model per role in Claude Code:** plugin agents in `plugins/prism/agents/` (advisor and ranker on sonnet; gap-finder, chairman, checker on opus). Claude app runs everything on the selected model.
- **Claim tags:** [observed], [assumed], [guess] in advisor output; [observed], [assumed], [goal], [constraint] in context. Chairman weights observed over assumed over guess.
- **Solo-business checklist in the chairman:** cash runway, non-billable hours at the user's rate, client concentration, one-person capacity, reversibility.
- **Two output flags:** verdict vs top 3; concise (default) vs detailed. No multi-council router, no exploration mode in v1.
- **Context is owned by the user, not shipped in the skill.** Any document works; the template is a checklist. Suggested file name: `prismatize-context.md`. The skill defines a template, a loading order (attachments, context file, connectors, conversation), a coverage check, a callout when gaps exist (answer now / run anyway marked "low context" / set up file), and a staleness check (3 months).
- **Transparency (from Karpathy):** every output ends with: `Full advisor answers, reviews and ranking available: ask "show the council".`
- **Reduced mode** when no subagents: one analysis, a separate attack pass as Contrarian and Buyer, chairman verdict, a self-check pass on the same 7 points, labeled "Reduced Prism".
- **Learning loop:** store outcomes in the context file, never Prism's own verdicts (anchoring).
- **Model recommendations live in the README, dated, as "tested with".** Never in SKILL.md. Plain advice: best model in the picker, thinking on.
- **Distribution:** GitHub repo as source of truth and Claude Code marketplace; a ready-to-upload ZIP on each GitHub Release for Claude app users; goua.la page for explanation; Notion version of the context template on the website, not in the repo. Submit to Anthropic's plugin directory only after testing.

## Rejected ideas (don't reintroduce without a new reason)

- Multiple councils (marketing, sales, pricing) and a router
- Exploration mode
- Numeric confidence scores ("78%")
- Weighted scoring tables for options
- Names: Cabinet (means toilet in French), Quorum (several LLM council skills already use it), Council (same as the original), Comity (false friend), Horde, Conciliabule, Agora, Arbiter, MosAIc, Voices (kept for the future voice skill)

## Open questions

- **Proposed, not applied:** one Buyer per segment when the options are different client segments (cap 3); otherwise one Buyer playing the target client from context.
- 3-month staleness: probably per section (pricing changes rarely, pipeline weekly).
- Buyer for career decisions (CDI vs freelance): the buyer is a hiring manager, not a client. Not handled yet.
- First Principles is the only advisor without a "The ...-er" name. "The Questioner" proposed for visual consistency.

## Writing rules for this repo

Apply `plugins/prism/skills/prismatize/style.md` to every file, docs included:
- No em dashes. Run `scripts/check-style.sh` before committing.
- No "it's not X, it's Y". No rhythmic lists of three. Say each thing once.
- Bullet points over tables.
- Each instruction appears once in SKILL.md. Repetition dilutes the rules that matter.

## Future project

A cross-platform "voice bible" writing skill (voice, anti-patterns). It should reuse `style.md` as its base and read the same user context source. Possible name: Voices.
