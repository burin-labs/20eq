# AGENTS.md

<!-- BEGIN HARN SHARED AGENT CONTRACT: managed by harn-bump-fleet -->

## Ecosystem working agreement

- Pursue the ambitious product outcome; make the seams boring with small typed
  interfaces, explicit invariants, and deterministic projections.
- Give each behavior one semantic owner. Generate or parity-test other surfaces
  instead of maintaining competing implementations.
- Work autonomously inside approved scope. Pause for destructive, production,
  high-spend, ambiguous, or authority-expanding actions—not routine reversible work.
- Treat stop, wait, stand down, and pivot as control events for long-lived work.
- Match evidence to the claim: exercise the canonical user path, state the
  falsifier, verify liveness and recovery, and record residual blind spots.
- "Ship" means landed on main with required deploy and post-merge checks complete.

<!-- END HARN SHARED AGENT CONTRACT -->

<!-- Repository-specific guidance below. The fleet manages only the block above. -->

## Pull request titles

Title every pull request `[Area] Sentence case`, for example
`[Game] End the round when the candle burns out early`. Common areas here are
`Game`, `Prompts`, `CI`, and `Docs`. See
[`CONTRIBUTING.md`](CONTRIBUTING.md) for the verification commands.


## This repository

20EQ is one Harn package: a terminal chat game whose deterministic turn policy
lives in `lib/game.harn` and whose character prompt and terminal loop live in
`20eq.harn`.

- The entry point is `pub fn main(harness: Harness)` in `20eq.harn`. It must
  stay `pub`, because `[exports].main` in `harn.toml` documents that symbol.
- Route every effect through `harness.*`. Pass the narrowest handle a helper
  needs: `print_candle` and `header` take `HarnessStdio`, `hex_options` takes
  `HarnessEnv`.
- Model routing has one owner, `hex_options`. It reads `TWENTY_EQ_MODEL`
  through `model_from_env` and returns a `{provider, model}` record. Do not
  pass a `provider:model` string to an LLM call, and do not hard-code a route
  at a call site.
- The private notebook boundary has one owner too: `SECRET_OPEN` and
  `SECRET_CLOSE` in `lib/game.harn`. The streaming call hides it live through
  the `private` option, and `strip_secret` cleans a non-streamed reply.
  Any new model call must go through one of those.
- Keep `tests/game_test.harn` free of real model calls and wall-clock reads.
  Use `harness.llm.mock_enqueue` for a reply under test.

## Verify

Run what CI runs, in this order:

```sh
harn fmt --check 20eq.harn lib/game.harn tests/game_test.harn
harn check --strict-types 20eq.harn lib/game.harn tests/game_test.harn
harn lint --strict 20eq.harn lib/game.harn tests/game_test.harn
harn test tests/ --parallel
harn package check
```

`harn test` accepts one positional target. Chain separate invocations with
`&&` rather than passing two paths.

For a change to the terminal loop, also diff the deterministic paths against
`main` before and after, since none of them need a model:

```sh
printf '/quit\n' | harn run 20eq.harn
printf '' | harn run 20eq.harn
printf '\n\n/quit\n' | harn run 20eq.harn
```

Bumping the Harn toolchain means editing `.harn-version`, the `harn` range in
`harn.toml`, and the pinned version in the README install command together.
