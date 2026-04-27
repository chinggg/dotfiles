---
name: fellowship-proposal
description: >
  Write, critique, and revise PhD fellowship research proposals (Google, Meta, Microsoft, Apple, NVIDIA, Bloomberg, etc.).
  Use this skill whenever the user wants to draft a fellowship research proposal, get feedback on an existing proposal draft,
  critique or review a research statement, revise a proposal, or asks about writing fellowship applications.
  Also trigger when the user mentions "proposal", "fellowship", "research statement", or "grant application" in the context
  of PhD fellowship documents. This skill covers research proposals only — not essays, CVs, or recommendation letters.
---

# Fellowship Research Proposal Skill

Help PhD students write competitive fellowship research proposals through an adaptive pipeline:
guided drafting when starting from scratch, adversarial critique when a draft exists, and always
dual output in Markdown + LaTeX.

## Core Philosophy

Fellowship proposals that win tell a **research vision**, not list CV achievements. Every piece of
prior work mentioned must serve the narrative — building toward "why this research matters, why now,
why me." This is non-negotiable and the single most common mistake in losing proposals.

Fellowship acceptance rates are 2-5%. The median reviewer is tired, skimming, and looking for
reasons to say no. Write — and critique — accordingly.

---

## Entry Point

On invocation:

1. **Detect existing drafts** — scan the working directory for `proposal.tex`, `proposal.md`, or
   similar files. Read them if found.
2. **Ask which fellowship** — needed for funder-specific criteria (page limits, research areas,
   evaluation rubric, mission alignment). If the user already specified, skip.
3. **Route to mode:**
   - No draft found → **Guided Drafting Pipeline**
   - Draft found → **Critique Pipeline**
   - User explicitly says "draft from scratch" → Guided Drafting regardless
   - User explicitly says "critique" or "review" → Critique Pipeline regardless

---

## Guided Drafting Pipeline

Walk through 5 sections in order. Each section follows a **Draft → Critique → Revise** micro-cycle
before moving on.

### Ground Truth First: Read Before You Write

Before drafting anything, gather factual information about the user's research. This prevents
hallucination, which is the most damaging failure mode. A reviewer who spots a fabricated result
or mischaracterized paper will reject the proposal outright.

**Step 1: Scan the working directory** for papers, abstracts, or prior proposals. Look for:
- PDF files of the user's publications
- `.tex` or `.md` files with paper content, abstracts, or prior proposals
- A bibliography file (`.bib`) with the user's publications
- Any `README` or notes describing the research

**Step 2: For each paper the user mentions, ask them to provide:**
- A 2-3 sentence summary of what the paper actually does (method + key result)
- The main quantitative result (e.g., "found 12 bugs in GCC" or "30% improvement over baseline")
- What the paper does NOT do (to prevent over-claiming)

**Step 3: Only use facts the user confirmed or that appear verbatim in source files.**
Never infer, extrapolate, or embellish what a paper does based on its title. If you don't know
a specific number, ask. If you don't know the method, ask. Writing "our tool achieves a 35%
improvement" when the user never said that is worse than leaving a [TODO] placeholder.

**Hard rule: Every factual claim about the user's own work must be traceable to either:**
- Text the user typed in this conversation
- Content read from a file in the working directory

If neither source exists for a claim, do not write it. Ask instead.

**The plausibility trap:** The most dangerous hallucinations are plausible ones. A claim that
sounds reasonable given the paper title but was never stated by the user is still fabricated.
Do not fill in details you weren't given, even if they seem obvious. "Plausible but unstated"
is not a source.

After drafting each section, re-read every sentence that describes the user's own work and ask:
"Did the user actually say this specific thing, or am I inferring it?" If inferring, replace
with [VERIFY: specific claim] and ask the user to confirm or correct.

### Proposal Structure

| # | Section | Purpose | Principles |
|---|---------|---------|------------|
| 1 | **Vision Statement** | Bold opening — "why now, why this matters" | Snappy hook grounded in citation. One cohesive idea. No jargon. Make a non-specialist care within 3 sentences. Frame as an "arrow pointing unambiguously" toward the research goal. |
| 2 | **Prior Work** | Own published work as evidence | Each project connects back to vision. Reuse best writing from papers. Show capability through narrative, not credential listing. "I did X, then Y, then Z" without vision connection is a red flag. |
| 3 | **Proposed Work** | 2-3 concrete research thrusts | Feasibility with preliminary results. Scope fits fellowship timeline. Methods clear but not over-detailed. Show "why now? why me?" not defense against every pitfall. |
| 4 | **Future Directions** | Speculative, exciting extensions | Lofty ideas excite readers and get them to fund you. Ground in prior work but speculate boldly. These half-baked directions show you think beyond the immediate. |
| 5 | **Impact & Funder Alignment** | Why this funder should care | Explicit connection to funder's research areas and mission. Real-world impact in plain terms anyone understands. "Better software" is not impact; "keeping planes from falling out of the sky" is. |

### Per-Section Micro-Cycle

For each section:

1. **Ask** — 2-3 targeted questions about content for this section (core argument, results to
   highlight, key references, etc.)
2. **Draft** — Write the section in both Markdown and LaTeX simultaneously
3. **Integrated Critique** — Immediately evaluate the draft against these 6 checks:
   - **Factual accuracy**: Is every claim about the user's papers traceable to what they said
     or what was read from files? Flag any sentence that describes the user's work using details
     they never provided. This is the highest-priority check.
   - **Audience clarity**: Would a CS-adjacent reviewer (not your subfield) follow this?
   - **Vision vs CV listing**: Is this narrative or credential enumeration?
   - **Specificity**: Show don't tell — evidence over claims?
   - **Coherence**: Does it connect back to the vision statement?
   - **Funder alignment**: Would the funder see their mission reflected?
4. **Revise** — Fix every issue found. Do not present "suggestions" — fix them.
5. **User Approval** — Show the revised section. Move to next only after user confirms.

### Writing Guidelines (from 20+ fellowship winner sources)

These guidelines are distilled from advice by Bloomberg, Microsoft Research, NSF GRFP, and Google
fellowship winners, plus faculty guides from UW, Brown, CMU, Yale, and MIT:

- **Open boldly.** Start with a snappy, non-subjective, citation-backed statement about the world
  that grips the reader. Not a gimmicky hook ("I couldn't believe my eyes...") but a compelling
  framing of why the problem matters.
- **One cohesive overarching idea.** It is better to convey one solid, well thought-out idea with
  several sub-directions than a maze of fifty unrelated ideas.
- **Build every proposed idea off prior work.** Show you can complete projects. Your track record
  is the evidence that the proposed work is feasible.
- **Write for a broad audience.** Your reviewers are likely not specialists in your subfield.
  "Gradient descent" is OK for a broad CS audience. "Learning parameters of a distribution from
  samples" is too jargon-heavy — say "fitting a model to data." When in doubt, simpler.
- **Spend real estate on "why now? why me?"** not defending against every methodological pitfall.
  Reviewers want to see why the problem and approach are exciting.
- **Include preliminary results** to validate your direction. The #1 rejection reason is proposals
  that raise too many questions about feasibility.
- **Reuse your best writing.** This is a closed publication — nobody sees it outside the committee.
  If you have a perfect paragraph in a paper, use it. Don't re-hash entire papers, but verbatim
  snippets are fine.
- **Tie interests to the sponsor's interests.** Research what the funder cares about. Add explicit
  sentences connecting your work to their mission and research areas.
- **Format for skimmability.** Bold section headers, bold keywords, whitespace. Reviewers are busy
  and will skim. A well-formatted proposal signals clear thinking.
- **Funders fund people, not projects.** Demonstrate you are capable, motivated, and clear-headed
  about your direction, not just that the project is interesting.
- **Connect thrusts through narrative, not adjacency.** Each research thrust must explicitly build
  on the previous one or share a named technique/insight. "Thrust 1 revealed X; this insight
  directly motivates Thrust 2" is a connection. Placing two thrusts next to each other under the
  same vision statement is not. The reader must see why these thrusts belong together beyond
  sharing an author.

### Writing Voice: Sound Human, Not AI-Generated

Fellowship reviewers are academics who read AI output daily. If your proposal reads like ChatGPT
wrote it, credibility drops instantly. This matters because reviewers form impressions fast and
AI-sounding text signals "the student didn't write this themselves."

**Punctuation rules:**
- Do not use em dashes (--) to connect clauses. Use commas, periods, or parentheses instead.
  Em dashes are the single most recognized AI writing tell.
- Do not use semicolons to join simple clauses. Use conjunctions (and, but, so, yet) or split
  into two sentences. Semicolons are fine only for genuinely complex compound sentences or lists.
- Vary sentence length deliberately. Mix short punchy sentences with longer ones. Do not write
  paragraphs where every sentence is 15-25 words.

**Banned words and phrases** (these appear 5-50x more often in AI text than human text):
- delve, tapestry, landscape (metaphorical), pivotal, underscore, testament, intricate,
  meticulous, nuanced, multifaceted, embark, spearhead, bolster, garner, interplay, realm,
  labyrinth, symphony (metaphorical), beacon, harness, facilitate, illuminate, showcase,
  seamlessly, cutting-edge, game-changer, profound, holistic, robust (unless describing a
  statistical method), comprehensive (unless describing a survey/benchmark)
- "It is important to note that...", "It's worth noting that...", "At its core...",
  "In an era of...", "In today's...", "This is particularly...", "From a broader perspective..."
- "Furthermore," "Moreover," "Additionally," "Consequently," "Nevertheless," "Subsequently,"
  "Notably" as sentence openers. Use plain transitions: "But," "And," "Also," "So," "Still."
  Academic writing permits starting sentences with conjunctions.

**Structural patterns to avoid:**
- Rule of three (tricolon): Do not default to groups of three adjectives, nouns, or items.
  Use two, or four, or just one. "Research, collaboration, and problem-solving" screams AI.
- "Not X, but Y" parallel negation: "Not because of A, but because of B." Just state B.
- Rhetorical question + immediate answer: "What does this mean? It means..." Just say what it
  means.
- Tidy paragraph endings: Not every paragraph needs a neat concluding sentence. Let some ideas
  flow into the next paragraph.
- Uniform paragraph length: Vary it. Some paragraphs can be 2 sentences. Others can be 6.
- Inflation of importance: "This represents a pivotal moment" / "marking a key turning point."
  State facts plainly. Let the reader judge importance.

**What to do instead:**
- Write like you would explain your research to a smart friend at a conference. Direct, specific,
  occasionally informal.
- Use concrete verbs: "We found," "This breaks," "The compiler leaks," not "We leveraged an
  innovative approach to illuminate."
- Allow imperfection: a slightly awkward transition is more human than a polished-but-generic one.
- Read your draft aloud. If it sounds like a press release, rewrite it.

---

## Critique Pipeline (Adversarial Reviewer Panel)

When a draft exists (or after drafting completes), run a simulated fellowship reviewer panel.
Default to **harsh, not kind**. The goal is to simulate the skeptical reviewer looking for reasons
to say no at a 2-5% acceptance rate.

### 10 Critique Dimensions

Evaluate each dimension and assign a score:

| # | Criterion | What to Check | Weight |
|---|-----------|---------------|--------|
| 1 | **Factual accuracy** | Every claim about the user's work traceable to provided sources? No hallucinated results, methods, or numbers? | Critical |
| 2 | **Vision coherence** | One unified narrative. Every section points back to opening. | High |
| 3 | **Audience accessibility** | Jargon level. Would a CS-adjacent reviewer follow? | High |
| 4 | **Novelty & boldness** | Does the opening grab? Is the contribution clearly novel? | High |
| 5 | **Feasibility** | Preliminary results cited? Realistic scope? Methods clear? | High |
| 6 | **Funder alignment** | Explicit connection to funder's mission, areas, values? | Medium |
| 7 | **Prior work as scaffold** | Own work builds the case, not listed as credentials? | Medium |
| 8 | **Future excitement** | Speculative directions that excite, grounded in capability? | Medium |
| 9 | **Specificity** | Evidence over claims? Concrete examples over generalities? | Medium |
| 10 | **Structure & skimmability** | Headers, bold keywords, whitespace, no text walls? | Low |
| 11 | **Formatting compliance** | Page limit, font size, margins match fellowship rules? | Low |
| 12 | **Human voice** | Does it sound AI-generated? Em dashes, semicolons, banned words, tricolons, uniform cadence? | High |

### Scoring Calibration

- **Strong** = Would survive a top-5% acceptance rate panel. Genuinely impressive.
- **Adequate** = Technically fine but won't stand out. **At 2-5% acceptance, Adequate means
  rejection.** Say this explicitly: "Adequate at this acceptance rate is not a pass."
- **Needs Work** = Active weakness giving reviewers a reason to reject.

The bar for "Strong" should be high. Most sections in most drafts should score Adequate or below
on first pass. If everything scores Strong on the first critique, the bar is too low.

### Rigor Mechanisms

These are the tools that keep the critique honest and harsh:

1. **Hallucination detector** — For every factual claim about the user's own research (results,
   numbers, methods, tool names), verify it against what the user actually said or what was read
   from files. Any claim that cannot be traced to a source is flagged as Critical. This is the
   most important check because a hallucinated result destroys credibility if the reviewer
   happens to know the actual work, and the student cannot submit a proposal with fabricated
   claims. Mark hallucinated claims with [UNVERIFIED] and ask the user to confirm or correct.
2. **Devil's advocate** — For every claim: "where's the evidence?" and "so what?" Unsupported
   claims are red flags, not yellow.
2. **Zero-tolerance jargon detector** — Any term a CS-adjacent reviewer wouldn't immediately
   understand gets flagged. Not "consider simplifying" but "this will lose your reviewer."
3. **Paragraph 1 test** — If the opening paragraph doesn't make a non-specialist care about the
   problem within 3 sentences, it fails. Period.
4. **CV-listing detector** — Any paragraph that reads as "I did X, then I did Y, then I did Z"
   without connecting to the vision gets flagged as a structural problem.
5. **Comparative anchoring** — Critique against the standards of known winning proposals. Ask:
   would this section hold up next to a Bloomberg/MSR/Google fellow's proposal?
6. **AI-voice detector** — Scan for em dashes, semicolons joining simple clauses, banned words
   from the list above, tricolon patterns, and uniform sentence/paragraph length. Each instance
   flagged individually with a concrete rewrite. This dimension is High weight because a proposal
   that sounds AI-generated undermines the student's credibility.
7. **Thrust-connection checker** — Verify that each research thrust explicitly names what it
   inherits from or shares with adjacent thrusts. "Thrust 1 and Thrust 2 both study software"
   is not a connection. "The intent-mining technique from Thrust 1 becomes the oracle generator
   in Thrust 2" is.
8. **Second-pass escalation** — If the user runs critique again after revisions, get *stricter*.
   Assume easy problems are fixed. Hunt for subtler issues: flow between sections, whether the
   "so what" lands, whether the future directions feel earned by the prior work.

### Critique Output Format

Present critique as:

```
## Reviewer Panel Assessment

### Overall Verdict: [Strong / Adequate / Needs Work]
[One paragraph summary written as an actual panel reviewer would — blunt, specific]

### Per-Criterion Scores
| Criterion | Score | Key Issue |
|-----------|-------|-----------|
| Vision coherence | Strong | — |
| Audience accessibility | Adequate | Lines 12-15: "temporal..." jargon |
| ... | ... | ... |

### Specific Feedback (highest-impact first)
1. **[Section, Lines]**: "[exact quote]"
   Problem: [what's wrong]
   Fix: [concrete revision]

2. ...

### Priority Revision List
1. [Most impactful fix]
2. [Second most impactful]
3. ...
```

### Post-Critique Options

After presenting critique, offer:
- **Auto-revise all** — Fix every flagged issue, show diff
- **Revise specific sections** — User picks which to fix
- **Show diff** — Between original and revised version

---

## Output Format

### Dual Output

Always produce both formats simultaneously:

**Markdown (`proposal.md`):**
- Clean, readable, good for sharing with advisor
- Section headers, bold key terms

**LaTeX (`proposal.tex`):**
- If an existing `.tex` file with a preamble exists in the working directory, reuse its preamble
  and custom commands
- If not, use the default template from `references/latex-template.tex`
- Compiles to submission-ready PDF

### Fellowship-Specific Formatting Checks

Always validate:
- Page count against the fellowship's limit
- Font size compliance (minimum 10pt for most fellowships)
- Margin compliance (1-inch / 2.5cm for most)
- Reference section excluded from page count where rules allow

---

## What This Skill Does NOT Do

- Short essays (350-word fellowship essay prompts)
- CV tailoring
- Fellowship selection or discovery
- Recommendation letter advice
- Non-research-proposal documents
