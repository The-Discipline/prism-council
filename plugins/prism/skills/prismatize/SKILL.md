---
name: prismatize
description: "Prism: one decision, five angles, one verdict. A decision council for one-person businesses (freelancers, consultants, coaches, trainers, solo creators). Runs a business decision through five independent advisors, an anonymous review and a chairman verdict, grounded in the user's business context. Use when the user says 'prismatize this', 'prismatiser', 'prism this', 'run it through Prism', or brings a real decision with options and stakes: pricing, offers, positioning, acquisition channels, clients, capacity, career direction. Do not use for exploration or brainstorming ('what am I missing?'), writing, reviewing copy, factual questions, or decisions inside a company with a team."
---

# Prism

One decision, five angles, one verdict.

Prism helps a person who runs a business alone make a decision they would otherwise make with no one to push back. Five advisors look at the decision independently, two reviewers judge their work anonymously, and a chairman delivers a verdict, or says honestly that the evidence isn't there yet.

Method: Andrej Karpathy's LLM Council (independent answers, anonymous peer review, chairman synthesis). Inspired by Ole Lehmann's llm-council skill.

Read `style.md` before writing anything. Every agent prompt includes it.

## 1. Check that there is a decision

Prism works on decisions: a choice between options, with something at stake. Classify the request first:

- **Decision with stakes** (options exist, being wrong costs time, money or clients): run Prism.
- **Cheap, reversible decision** (which tool to try this week): say so in one line and answer directly. Run Prism only if the user insists.
- **Exploration** ("what am I missing?", "ideas for my business"): Prism doesn't do this. Say it in one line, then offer to reframe: list the options the user already mentioned, or ask them to name 2 or 3, and turn the request into "which one do I pursue?"
- **Writing, reviewing, facts**: help normally, without Prism.

If the decision is clear but the options aren't, ask one question to get them.

## 2. Load the business context

Look for context in this order and stop once the decision is covered:

1. Files or text attached to this request
2. A context file in the workspace or project (`prism-context.md`, `CLAUDE.md`, a `memory/` folder) or the platform's memory
3. Connected tools holding business documents (Notion, Google Drive), if the user's setup points there
4. The current conversation

Keep this short: you need the few facts this decision depends on, not a full audit.

Then check coverage. List what this specific decision needs (a pricing decision needs current prices, capacity and client sources; a channel decision needs available hours and where past clients came from) and compare with what you found.

- **Covered and recent:** state in one line what you used and from where. Example: "Context: offers, pricing and pipeline from prism-context.md (updated 3 weeks ago)."
- **Gaps:** show this before running, naming the missing items, and wait for the answer:

  > Prism needs your business context to give advice that fits you. For this decision, I'm missing: {2 to 4 specific items}.
  > 1. Answer these now (about 2 minutes)
  > 2. Run anyway (the verdict will be marked **low context**)
  > 3. Set up a context file once, from the template in `context-template.md`

- **Stale:** if a dated item the decision depends on is older than 3 months, ask in one line whether it still holds.

## 3. Write the brief

Set the output options from the user's request (defaults first):
- **Format:** verdict, or top 3 ranked options if the user asks for alternatives
- **Length:** concise, or detailed if the user asks

Write two neutral briefs. Add no opinion of your own.

**Full brief** (four advisors):
- The decision and the options
- The goal behind it
- Relevant context, each fact tagged [observed], [assumed], [goal] or [constraint], dated when known
- What a wrong choice would cost

**Buyer brief** (Buyer only): what a prospective client could see or would be told. Offer, price, pitch, positioning, public material. Leave out revenue, goals, pipeline, constraints and internal reasoning. For an internal decision (tools, admin), give only what would change from a client's point of view.

## 4. Run the five advisors in parallel

Launch each advisor as a separate subagent, all at once, so none sees another's answer. Without subagents, use Reduced mode (below).

**The Contrarian.** Assumes the decision has a flaw and hunts for it: the ignored risk, the optimistic assumption, the way this fails. It asks the questions the user is avoiding.

**First Principles.** Ignores the surface question and asks what the user is trying to achieve. Its most useful output is often "the real question is X."

**The Expansionist.** Looks for upside: what happens if this works better than planned, which adjacent opportunity is hidden, what is undervalued. Leaves risk to the Contrarian.

**The Executor.** Asks whether one person can do this alongside client work, with the cash and hours they have. What happens Monday morning, and what gets dropped to make room.

**The Buyer.** A prospective client who knows only the Buyer brief. Would I pay for this? What makes me hesitate? What would I do instead: do it myself, use a free resource or an AI tool, hire someone else, or do nothing? It ends with its 2 or 3 strongest objections, written the way a client would actually say them, and marks the one that would stop the deal. The Buyer is simulated and has no market data, so when the answer depends on real buyers, it names the assumption to test with real prospects.

Advisor prompt:

```
You are {advisor name}, one of five advisors on a decision council for a one-person business.

Your angle: {advisor description}

The decision:
---
{full brief, or Buyer brief for the Buyer}
---

Answer from your angle only. The other advisors cover the rest, so commit to your view.
Tag factual claims: [observed] if it comes from the brief, [assumed] if you infer it, [guess] if it's speculation.
150 to 250 words. Start with your analysis.

{style.md}
```

## 5. Review with two reviewers in parallel

Label the five responses A to E in random order. Run both reviewers as separate subagents.

**Reviewer 1: ranking**

```
Five advisors answered this decision for a one-person business:
---
{full brief}
---
{Responses A to E}

For each response, two lines at most: what is useful, what is weak. Judge on:
- Grounded in the user's situation rather than generic advice
- Identifies a risk or opportunity that matters for this decision
- Leads to something the user can act on

End with exactly:
FINAL RANKING:
1. Response X
2. Response X
3. Response X
4. Response X
5. Response X

Under 250 words.

{style.md}
```

**Reviewer 2: gaps**

```
Five advisors answered this decision for a one-person business:
---
{full brief}
---
{Responses A to E}

Answer:
1. Which assumption do all five share without checking it?
2. What matters for this decision that none of them addresses?
3. Which single claim, if wrong, would change the decision? Is it [observed]?

Under 200 words.

{style.md}
```

## 6. Chairman verdict

One agent receives the full brief, the five responses with advisor names, and both reviews.

- Treat the ranking as input. Side with a minority view when its reasoning is stronger, and say so.
- Weight [observed] above [assumed], and [assumed] above [guess].
- Check the solo-business risks the advisors may have skipped: cash runway, non-billable hours (valued at the user's rate when known), dependence on a few clients, the capacity of one person, and whether the decision can be undone.
- For client-facing decisions (pricing, offers, positioning), keep the Buyer's deal-breaker objection for the output, unless the verdict already removes it.
- Pick one outcome:
  - **Verdict:** one recommendation, when the evidence supports it.
  - **Top 3:** only if the user asked for options. Ranked, with why #1 beats #2.
  - **Not yet:** when the decision hinges on a fact nobody has. Name it, give the cheapest way to get it, a deadline, and the results that mean go or stop. This is a full answer.

## 7. Present the result

Write in the user's language, following `style.md`.

**Concise (default)**

```
## Prism: {short topic}
{if low context: **Low context.** Missing: {items}. Treat this as a first pass.}

**Verdict:** {one or two sentences}
**Why:**
- {reason}
- {reason}
**Main risk:** {one sentence}
{client-facing decisions only: **Objection to prepare for:** "{the deal-breaker, in the client's words}"}
**What would change this:** {the fact or result that would flip the verdict}
**Do first:** {one action, doable within 48 hours}
```

For **Not yet**, replace Verdict, Why and Do first with:

```
**Verdict:** Not yet. The decision depends on {missing fact}.
**Cheapest test:** {action}
**By:** {date}
**Go if:** {result}
**Stop if:** {result}
```

For **Top 3**, list the options ranked with one line of reasoning each, then one line on why #1 beats #2.

**Detailed:** the concise block, then:
- **Where the advisors agree** (independent convergence is the strongest signal)
- **Where they clash**: both sides and the reason they disagree
- **What the review caught** that no single advisor saw
- **Each advisor in one line**

**Every output, in every mode, ends with this line:**

```
Full advisor answers, reviews and ranking available: ask "show the council".
```

When the user asks, show the five advisor answers with their names, both reviews, and the ranking with letters mapped back to advisors. Keep them available for the whole conversation.

## Reduced mode (no subagents)

Advisors written in a single response see each other and converge, so they aren't independent. Without subagents:
1. Write one analysis covering the five angles.
2. In a separate pass, attack it as the Contrarian and the Buyer would.
3. Give the chairman verdict from both.

Label the result: "Reduced Prism: this platform can't run independent advisors."

## After the verdict

If the user wants to track the decision, add a short entry to `decisions.md` or wherever they keep notes: date, decision, verdict, test, review date. When results come in, they go into the context file. Store outcomes only: past verdicts fed back as context bias the next council.
