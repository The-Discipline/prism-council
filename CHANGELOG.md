# Changelog

## 0.6.0 (2026-11-05)
- Verdict check: a checker agent tests the chairman's draft on seven points (main risk resolved, coherent "what would change this", doable action, facts over assumptions, Gap Finder's key claim addressed, right outcome, style). CHANGES triggers one revision, never more.
- New outcome, Escalate: for decisions that hinge on legal, tax or regulatory rules, binding high-stakes commitments, or that belong partly to a partner or family. Prism names who should decide and prepares the conversation. Pure legal or tax questions skip the council.
- Claude Code plugin agents with a model per role: advisor and ranker on Sonnet; gap-finder, chairman and checker on Opus.
- Context: any document works, the template is a checklist. Suggested file renamed `prismatize-context.md` (the old name still works).

## 0.5.0 (2026-10-30)
- New businesses: a "Starting out" section in the context template. Prism no longer flags missing revenue or client history as gaps for someone with no clients yet.
- Optional market check: when the decision depends on the market and web search is available, Prism looks up 3 to 5 comparable offers before the council, tagged [observed], shared with the Buyer as alternatives.
- Example questions by business stage.

## 0.4.0 (2026-10-30)
- Renamed to `prismatize` everywhere: repo, skill, ZIP, marketplace. Claude Code command: `/prism:prismatize`.
- New triggers: "prismatize this", "prismatiser". Dropped "council this" to avoid clashing with other council skills.

## 0.3.0 (2026-10-30)
- The Buyer ends with its 2 or 3 strongest objections, in the client's words, and marks the deal-breaker.
- Concise output adds "Objection to prepare for" on pricing, offer and positioning decisions.
- MIT license.

## 0.2.0 (2026-10-30)
- Every output ends with a "show the council" line, in all modes. On request, shows the five advisors by name, both reviews, and the ranking mapped back to advisors.

## 0.1.0 (2026-10-30)
- First version, written from scratch.
- Five advisors (Contrarian, First Principles, Expansionist, Executor, Buyer), two reviewers (Ranker, Gap Finder), chairman with three outcomes (Verdict, Top 3, Not yet).
- Decision gate, context loading and coverage check, claim tags, solo-business checklist, reduced mode, shared style rules, context template.
