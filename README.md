# 20EQ

[![CI](https://github.com/burin-labs/20eq/actions/workflows/ci.yml/badge.svg)](https://github.com/burin-labs/20eq/actions/workflows/ci.yml)

A Halloween-themed command-line chatbot game in the spirit of *20 Questions* — except the spooky teen-coded character on the other side of the void is secretly running an information-theoretic profile of you over ~20 turns. When the candle goes out, she drops the act and reveals her dossier.

Written in [Harn](https://harnlang.com).

## Install

You need two things on your machine:

**1. The Harn toolchain.** Install the version in `.harn-version` from crates.io:

```sh
cargo install harn-cli
```

That puts a `harn` binary in `~/.cargo/bin/`. Run `harn --version` to confirm.

**2. A local OpenAI-compatible chat server with a model loaded.** Harn discovers common local servers automatically. Set `LOCAL_LLM_BASE_URL` when yours uses a non-default address. The game defaults to `local:qwen3.6-35b-a3b-ud-q4-k-xl`; override it without editing source by setting `TWENTY_EQ_MODEL` to any Harn model id, such as `ollama:qwen3.5:9b`.

Spot-checked against [Qwen3.6-35B-A3B](https://huggingface.co/Qwen) on llama.cpp. Other local OpenAI-compat servers (Ollama, vLLM, MLX) should work with small tweaks to the `provider` / `model` knobs.

## Play

```sh
harn run 20eq.harn
```

Type `/quit` to bail early; otherwise the candle goes out on its own after 20 turns and the dossier drops.

## Files

- `20eq.harn` — the terminal game and character prompt
- `lib/game.harn` — deterministic turn policy, model routing, and private-text boundary
- `tests/game_test.harn` — fast in-process policy coverage with no model or wall clock
- `harn.toml` — Harn package manifest
- `.github/workflows/ci.yml` — package and test verification
- `LICENSE`, `README.md`, `.gitignore` — boilerplate

## Develop

Run the same deterministic checks as CI:

```sh
harn fmt --check 20eq.harn lib/game.harn tests/game_test.harn
harn check --strict-types 20eq.harn lib/game.harn tests/game_test.harn
harn lint --strict 20eq.harn lib/game.harn tests/game_test.harn
harn test tests/ --parallel
harn package check
```

No Git hook is required. Editors and agents can format with `harn fmt`, while CI remains the authoritative gate.

## License

MIT — see [LICENSE](./LICENSE). Covers the contents of this repository only. Harn is a separate project under its own dual Apache-2.0/MIT license, and any local LLM weights you point this at are governed by their own terms.
