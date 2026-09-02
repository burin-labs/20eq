## What changed

<!--
Title this pull request `[Area] Sentence case`, for example:
  [Game] End the round when the candle burns out early
  [Prompts] Tighten the dossier reveal
  [CI] Pin the Harn toolchain to the version file

Then describe the change in three to five sentences. Example:

  The candle counter kept running after a player typed `/quit`, so the dossier
  still printed on the way out and gave away the profile. This moves the quit
  check ahead of the turn advance in `lib/game.harn` so the round ends without
  a reveal. `harn test tests/ --parallel` covers the new ordering, and I played
  a full round plus an early quit against a local model to confirm both endings
  read correctly. No public behavior changed for a normal twenty-turn game.
-->

## How you verified it

<!--
Name the command you ran and what it showed. The test suite never calls a
model, so if you changed a prompt, say that you actually played a round.
-->
