# Critique Rubric — Detailed Reference

This document provides the full detail behind each critique dimension.
Read this when running the Critique Pipeline for precise evaluation guidance.

---

## Dimension 1: Factual Accuracy (Critical Weight)

This is the highest-priority dimension. A hallucinated result or mischaracterized paper is worse
than any other flaw because it destroys the student's credibility and cannot be submitted.

**What "Strong" looks like:**
- Every quantitative claim (percentages, bug counts, benchmarks) matches what the user stated
  or what appears in source files
- Paper descriptions accurately reflect what the tool/method does
- No embellished or extrapolated results
- Method descriptions match the actual technique (e.g., not calling something "static analysis"
  when it's really "dynamic testing")

**What "Adequate" looks like:**
- Most facts are correct but 1-2 claims are vaguely phrased in ways that could mislead
- A result is described in slightly different terms than the user used (paraphrased but not wrong)

**What "Needs Work" looks like:**
- Fabricated numbers ("achieves 35% improvement" when no such number was provided)
- Mischaracterized methods ("uses deep learning" when the tool is rule-based)
- Invented tool capabilities beyond what was described
- Made-up evaluation details (benchmark names, bug counts, comparison baselines)

**How to check:**
For each factual claim about the user's own work, ask: "Did the user say this, or did I read
this in a file?" If neither, flag it as [UNVERIFIED]. Common hallucination patterns:
- Inventing specific numbers for results only described qualitatively
- Adding capabilities to a tool beyond what was described
- Describing a paper's method using techniques from a different subfield
- Claiming a tool was evaluated on benchmarks that were never mentioned

---

## Dimension 2: Vision Coherence (High Weight)

**What "Strong" looks like:**
- The opening paragraph frames a single, compelling research question or gap
- Every subsequent section clearly serves this framing
- The reader finishes and can state the proposal's core idea in one sentence
- Prior work, proposed work, and future directions all feel like chapters of the same story

**What "Adequate" looks like:**
- The vision is present but buried (appears in paragraph 2-3 instead of leading)
- Some sections feel loosely connected — the proposed work serves the vision but the future
  directions wander
- The reader can identify the idea but has to work for it

**What "Needs Work" looks like:**
- Multiple competing ideas without a unifying thread
- Sections read as independent mini-proposals
- The opening is generic ("Software is important...") rather than specific to this research

**Common failure pattern:** The student lists 3-4 unrelated projects they've done, then proposes
2-3 unrelated future projects. There's no through-line. Fix: find the thread that connects them,
even if it requires reframing past work.

---

## Dimension 2: Audience Accessibility (High Weight)

**What "Strong" looks like:**
- A CS professor outside your subfield reads it and understands the problem, approach, and impact
- Technical terms are introduced with brief context on first use
- Analogies or examples make abstract concepts concrete
- No sentence requires specialist knowledge to parse

**What "Adequate" looks like:**
- Mostly accessible but 2-3 sentences require subfield knowledge
- Jargon is present but could be decoded from context with effort
- The problem is clear but the approach description gets too technical

**What "Needs Work" looks like:**
- Dense with acronyms and subfield terminology
- Assumes the reader knows your specific area
- Would confuse a systems person reading an SE proposal (or vice versa)

**Jargon test:** For each technical term, ask: "Would a CS professor who works in a *different*
subfield understand this without looking it up?" If no, either define it inline or replace it.

**Calibration examples:**
- OK for broad CS: "gradient descent", "regression testing", "side-channel attack"
- Needs context: "fuzzing campaign", "abstract syntax tree", "taint analysis"
- Too jargon-heavy: "concolic execution engine", "LLVM IR pass", "neuromorphic acceleration"

---

## Dimension 3: Novelty & Boldness (High Weight)

**What "Strong" looks like:**
- The opening makes the reader think "huh, I hadn't thought about it that way"
- The contribution is clearly differentiated from existing work
- The framing reveals a gap that, once stated, seems obvious but wasn't before

**What "Adequate" looks like:**
- Incremental improvement on existing approaches
- The contribution is real but the framing doesn't make it feel exciting
- "We do X but better/faster/on more data"

**What "Needs Work" looks like:**
- The reader's reaction is "so what?" or "hasn't this been done?"
- No clear differentiation from related work
- The opening is a textbook summary rather than a provocative framing

---

## Dimension 4: Feasibility (High Weight)

**What "Strong" looks like:**
- Preliminary results demonstrate the approach works at small scale
- Clear methodology that a reviewer can imagine executing
- Scope fits the fellowship timeline (1-3 years depending on fellowship)
- Collaborators, datasets, or infrastructure are named specifically

**What "Adequate" looks like:**
- Feasibility is plausible but undemonstrated
- "We will apply X to Y" without evidence that X works for Y-type problems
- Timeline is vague

**What "Needs Work" looks like:**
- Proposed work is purely speculative with no preliminary evidence
- Scope is wildly ambitious for the timeline
- Methods are hand-waved ("we will use deep learning to...")

**The #1 rejection reason** across all fellowships: proposals that raise too many questions about
whether the student can actually do what they're proposing.

---

## Dimension 5: Funder Alignment (Medium Weight)

**What "Strong" looks like:**
- Explicit sentences connecting research to the funder's stated mission or research areas
- Awareness of the funder's current work (e.g., referencing Google's AI Principles,
  Meta's open-source AI work, Microsoft's responsible AI initiatives)
- The alignment feels natural, not forced

**What "Adequate" looks like:**
- Generic alignment ("this research is relevant to [Company]'s interests")
- The connection exists but isn't made explicit
- The funder's name could be swapped for any other company without changing the text

**What "Needs Work" looks like:**
- No mention of the funder's mission, values, or research areas
- The proposal reads as funder-agnostic
- Misalignment with the funder's actual priorities

---

## Dimension 6: Prior Work as Scaffold (Medium Weight)

**What "Strong" looks like:**
- Each mentioned publication serves the narrative: "This work demonstrated X, which motivates Y"
- The reader sees a trajectory of deepening expertise
- Publications are evidence, not credentials

**What "Adequate" looks like:**
- Prior work is mentioned but the connection to the proposal is implicit
- Some publications feel listed for padding rather than narrative purpose

**What "Needs Work" looks like:**
- A paragraph that reads as a mini-CV: "I published A at venue X, B at venue Y, C at venue Z"
- Prior work and proposed work feel disconnected
- "I have N publications" without explaining what they mean for the research vision

**The CV-listing detector:** Any paragraph where you can draw a vertical line through the structure
and it looks like a bulleted list masquerading as prose — flag it.

---

## Dimension 7: Future Excitement (Medium Weight)

**What "Strong" looks like:**
- Future directions feel like natural extensions that the reader wants to see happen
- Speculative enough to be exciting, grounded enough to be credible
- Shows the student thinks beyond the immediate thesis

**What "Adequate" looks like:**
- Future work is mentioned but feels perfunctory
- "In the future, we could also apply this to other domains"

**What "Needs Work" looks like:**
- No future directions at all
- Future work is a repeat of proposed work with minor variations
- Disconnected moonshots with no grounding in demonstrated capability

---

## Dimension 8: Specificity (Medium Weight)

**What "Strong" looks like:**
- Claims are backed by numbers, citations, or concrete examples
- "Our tool found 12 previously unknown bugs in GCC" not "Our tool is effective"
- Methods are described concretely enough to be reproducible

**What "Adequate" looks like:**
- Mix of specific and vague claims
- Some results are quantified but others are hand-waved

**What "Needs Work" looks like:**
- All claims are vague: "significant improvement", "state-of-the-art results", "novel approach"
- No concrete evidence for any assertion
- "Show don't tell" is violated throughout

---

## Dimension 9: Structure & Skimmability (Low Weight)

**What "Strong" looks like:**
- Bold section headers that serve as a readable outline
- Key terms and results bolded for scanning
- Adequate whitespace — not a wall of text
- A figure or diagram if it genuinely aids understanding

**What "Adequate" looks like:**
- Headers exist but are generic ("Background", "Methods")
- Some formatting but inconsistent
- Readable but doesn't invite skimming

**What "Needs Work" looks like:**
- No headers, one continuous block of text
- Dense paragraphs with no visual breaks
- Formatting that fights readability (e.g., too many fonts, colors, boxes)

---

## Dimension 10: Formatting Compliance (Low Weight)

**What to check:**
- Page count within fellowship limit
- Font size at or above minimum (usually 10pt)
- Margins at or above minimum (usually 1 inch / 2.5 cm)
- References excluded from page count if rules allow
- Single PDF format if required
- English language

**This is binary:** either compliant or not. Non-compliance is disqualifying at most fellowships.

---

## Second-Pass Escalation

When running critique a second time after revisions:

1. Assume all "Needs Work" items from the first pass are fixed. Don't re-flag them unless they
   genuinely persist.
2. Promote previous "Adequate" items to the spotlight — these are now the priority.
3. Look for **new issues** that emerge from revisions:
   - Did fixing one section break coherence with another?
   - Did the revisions introduce new jargon?
   - Is the flow between sections smooth after individual section edits?
4. Apply **higher-order critique:**
   - Does the overall narrative arc land? (Not just individual sections)
   - Would a reviewer remember this proposal after reading 20 others?
   - Is there a single sentence that captures the "so what"?
5. If the first pass had mostly "Adequate" scores, the second pass bar for "Strong" stays the same.
   Do not lower it just because progress was made.

---

## Dimension 11: Human Voice (High Weight)

**What "Strong" looks like:**
- Reads like a human researcher wrote it, not an AI assistant
- Zero em dashes used as clause connectors
- No semicolons joining simple independent clauses
- None of the banned words from the skill's list appear
- Sentence length varies naturally (some 5-word sentences, some 30-word)
- Paragraph length varies (2-sentence paragraphs mixed with 5-sentence ones)
- No tricolon patterns ("X, Y, and Z" as a default grouping)
- Transitions use plain language: "But," "And," "So," "Still," not "Furthermore," "Moreover"
- The voice feels direct and personal, like a conference conversation

**What "Adequate" looks like:**
- Mostly clean but 3-5 AI tells slip through
- A few em dashes or semicolons
- One or two banned words ("robust," "comprehensive")
- Generally varied cadence but a section or two falls into uniform rhythm

**What "Needs Work" looks like:**
- Dense with em dashes connecting clauses
- Semicolons used as default conjunction substitutes
- Multiple banned words ("delve," "pivotal," "multifaceted," "tapestry")
- Uniform sentence length throughout
- "Furthermore," "Moreover," "Additionally" as paragraph openers
- Tricolon lists ("research, collaboration, and innovation") as default
- Reads like it was generated by ChatGPT

**How to check:**
1. Count em dashes. More than 1 in the entire proposal is a flag.
2. Count semicolons. Each one: is this genuinely complex enough to need a semicolon? If not, flag.
3. Grep for banned words from the skill's list. Any match is a flag.
4. Check sentence length variance. If the standard deviation is low, flag.
5. Look for tricolon patterns (X, Y, and Z). More than 2 in the proposal is a flag.
6. Check paragraph openers. If "Furthermore/Moreover/Additionally/Consequently" appears, flag.

---

## Dimension 12: Thrust Connectivity (High Weight)

**What "Strong" looks like:**
- Each thrust explicitly names what it inherits from or contributes to adjacent thrusts
- A technique, insight, or finding from Thrust 1 reappears as a building block in Thrust 2
- The reader can trace a causal or methodological chain across all thrusts
- Removing any one thrust would visibly break the narrative logic of the others

**What "Adequate" looks like:**
- Thrusts share a vision statement but the connections between them are implicit
- The reader can see why they belong together but has to infer the links
- "Both study software assurance" level connection

**What "Needs Work" looks like:**
- Thrusts read as independent mini-proposals under a shared umbrella
- No explicit methodological or conceptual link between them
- You could reorder the thrusts without the reader noticing
- Removing one thrust would not affect the coherence of the others
