# Contributing to 20EQ

## Scope

20EQ is a demonstration program. It is a small Halloween-themed command-line
game that exists to show what an application written in
[Harn](https://harnlang.com) looks like end to end: a turn policy, a model
route, a private-text boundary, and a test suite that runs without a model or a
wall clock. It is not a product, it has no users to keep compatible, and
nothing depends on it.

**External contributions are not accepted.** The game's design, its character,
and its twenty-turn structure are settled, and a feature added here would carry
maintenance cost against a demo. If the game breaks, or the README's setup
steps do not work on your machine, an issue on this repository is welcome and
useful, because a demo that does not run fails at the one job it has.

If Harn itself is what you want to change, that work belongs in
[`burin-labs/harn`](https://github.com/burin-labs/harn), where it reaches every
Harn program instead of this one.

## Running it yourself

The README covers installing the Harn toolchain and pointing the game at a
local model. You need both before the game will start.

## Verifying a change

CI runs these, and they are the authoritative gate. Run them before you push:

```sh
harn fmt --check 20eq.harn lib/game.harn tests/game_test.harn
harn check --strict-types 20eq.harn lib/game.harn tests/game_test.harn
harn lint --strict 20eq.harn lib/game.harn tests/game_test.harn
harn test tests/ --parallel
harn package check
```

The tests cover the turn policy deterministically. They do not call a model, so
a green test run tells you the policy is intact and tells you nothing about how
the character reads. Play a round before claiming a prompt change is an
improvement.

## Pull request titles

Title every pull request `[Area] Sentence case`. The area is one bracketed word
naming the part you touched, and the sentence that follows says what the change
does, capitalized like a sentence and with no trailing period.

```
[Game] End the round when the candle burns out early
[Prompts] Tighten the dossier reveal
[CI] Pin the Harn toolchain to the version file
```

Common areas here are `Game`, `Prompts`, `CI`, and `Docs`. Describe the change
in three to five sentences in the body and say which command you ran to verify
it.
