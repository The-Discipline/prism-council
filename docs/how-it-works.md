# How Prism works

All diagrams in Mermaid. GitHub renders them directly in README files.

## 1. Overview: the full run

```mermaid
flowchart LR
    Q["Your decision"] --> C["Business context"]
    C --> B["Brief"]
    B --> A1["Contrarian"]
    B --> A2["First Principles"]
    B --> A3["Expansionist"]
    B --> A4["Executor"]
    B -. "client view only" .-> A5["Buyer"]
    A1 & A2 & A3 & A4 & A5 --> R["Anonymous review<br/>Ranker + Gap Finder"]
    R --> CH["Chairman"]
    CH --> V["Verdict + one action"]
```

## 2. The gate: is this a Prism question?

```mermaid
flowchart TD
    S["Your request"] --> G{"Is there a decision<br/>with options and stakes?"}
    G -- "Yes" --> P["Run Prism"]
    G -- "Cheap and reversible" --> D["Direct answer<br/>Prism only if you insist"]
    G -- "Exploration" --> X["Offer to reframe:<br/>name 2 or 3 options"]
    X --> P
    G -- "Writing, review, facts" --> N["Normal help, no Prism"]
    P --> O{"Options clear?"}
    O -- "No" --> Q1["One question to get them"] --> CTX["Load context"]
    O -- "Yes" --> CTX
```

## 3. Context check

```mermaid
flowchart TD
    L["Look for context:<br/>attachments, context file,<br/>connected tools, conversation"] --> C{"Covers this decision?"}
    C -- "Yes, recent" --> OK["One line: what was used"] --> RUN["Run the council"]
    C -- "Older than 3 months" --> ST["Ask: still true?"] --> RUN
    C -- "Gaps" --> CO["Callout: what's missing"]
    CO --> O1["1. Answer now"] --> RUN
    CO --> O2["2. Run anyway"] --> LOW["Run, verdict marked<br/>low context"]
    CO --> O3["3. Set up context file"] --> RUN
```

## 4. The three outcomes

```mermaid
flowchart TD
    CH["Chairman"] --> E{"Does the evidence<br/>support a choice?"}
    E -- "Yes" --> T{"Did you ask<br/>for options?"}
    T -- "No" --> V["Verdict<br/>why, main risk,<br/>what would change it, do first"]
    T -- "Yes" --> T3["Top 3<br/>ranked, why #1 beats #2"]
    E -- "No, a key fact is missing" --> NY["Not yet<br/>cheapest test, deadline,<br/>go if / stop if"]
    V & T3 & NY --> L{"Length"}
    L -- "Default" --> CON["Concise"]
    L -- "On request" --> DET["Detailed: agreement,<br/>clashes, what review caught,<br/>each advisor in one line"]
```

## 5. Full mode vs reduced mode

```mermaid
flowchart TD
    P["Platform check"] --> S{"Subagents available?"}
    S -- "Yes" --> F["Full Prism<br/>5 independent advisors<br/>2 reviewers, 1 chairman"]
    S -- "No" --> R1["One analysis<br/>covering five angles"]
    R1 --> R2["Separate attack pass<br/>as Contrarian and Buyer"]
    R2 --> R3["Chairman verdict"]
    R3 --> LBL["Labeled: Reduced Prism"]
```

## 6. The learning loop

```mermaid
flowchart LR
    D["Decision"] --> P["Prism verdict"]
    P --> T["Test or action"]
    T --> O["Observed outcome"]
    O --> CF["Context file"]
    CF --> D
    P -. "never stored as context" .-> CF
```
