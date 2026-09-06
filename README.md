# 20EQ

[![CI](https://github.com/burin-labs/20eq/actions/workflows/ci.yml/badge.svg)](https://github.com/burin-labs/20eq/actions/workflows/ci.yml)

A Halloween-themed command-line chatbot game in the spirit of *20 Questions* — except the spooky teen-coded character on the other side of the void is secretly running an information-theoretic profile of you over ~20 turns. When the candle goes out, she drops the act and reveals her dossier.

Written in [Harn](https://harnlang.com).

## Install

You need two things on your machine:

**1. The Harn toolchain.** Install the exact version in `.harn-version` from crates.io:

```sh
cargo install harn-cli --version 0.10.131 --locked
```

That puts a `harn` binary in `~/.cargo/bin/`. Run `harn --version` to confirm it reports `harn 0.10.131`.

**2. A local OpenAI-compatible chat server with a model loaded.** Harn discovers common local servers automatically. Set `LOCAL_LLM_BASE_URL` when yours uses a non-default address, and give it the server root without the `/v1` suffix, which Harn appends itself (`http://127.0.0.1:8001`, not `http://127.0.0.1:8001/v1`). The game defaults to `local:qwen3.6-35b-a3b-ud-q4-k-xl`; override it without editing source by setting `TWENTY_EQ_MODEL` to any Harn model id, such as `ollama:qwen3.5:9b`.

Spot-checked against [Qwen3.6-35B-A3B](https://huggingface.co/Qwen) on llama.cpp. Harn treats a `local:` model id as the generic OpenAI-compatible adapter and `ollama:` as Ollama, so switching between llama.cpp, Ollama, vLLM, and MLX is a `TWENTY_EQ_MODEL` change rather than a source edit.

## Play

```sh
harn run 20eq.harn
```

Type `/quit` to bail early; otherwise the candle goes out on its own after 20 turns and the dossier drops.

## Files

- `20eq.harn` — the terminal game and character prompt; `pub fn main(harness: Harness)` is the entry point
- `lib/game.harn` — deterministic turn policy, model routing, and private-text boundary
- `tests/game_test.harn` — six fast in-process cases with no model call and no wall clock
- `harn.toml` — Harn package manifest, including the supported Harn range
- `.harn-version` — the exact Harn toolchain this repository is verified against
- `.github/workflows/ci.yml` — package and test verification
- `CONTRIBUTING.md`, `LICENSE`, `README.md`, `.gitignore` — contributor guide and boilerplate

## Develop

Run the same deterministic checks as CI:

```sh
harn fmt --check 20eq.harn lib/game.harn tests/game_test.harn
harn check --strict-types 20eq.harn lib/game.harn tests/game_test.harn
harn lint --strict 20eq.harn lib/game.harn tests/game_test.harn
harn test tests/ --parallel
harn package check
```

`harn test` takes one positional target, so run the suite as `harn test tests/`. The six cases are all deterministic: the streaming case uses `harness.llm.mock_enqueue`, and nothing else reaches a model.

No Git hook is required. Editors and agents can format with `harn fmt`, while CI remains the authoritative gate.

## License

MIT — see [LICENSE](./LICENSE). Covers the contents of this repository only. Harn is a separate project under its own dual Apache-2.0/MIT license, and any local LLM weights you point this at are governed by their own terms.
