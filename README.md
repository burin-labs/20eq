# 20EQ

A Halloween-themed command-line chatbot game in the spirit of *20 Questions* — except the spooky teen-coded character on the other side of the void is secretly running an information-theoretic profile of you over ~20 turns. When the candle goes out, she drops the act and reveals her dossier.

Written in [Harn](https://harnlang.com).

## Install

You need two things on your machine:

**1. The Harn toolchain.** Install from crates.io:

```sh
cargo install harn-cli
```

That puts a `harn` binary in `~/.cargo/bin/`. Run `harn --version` to confirm.

(If you're hacking on Harn itself and want the launcher to use your local source build, point `HARN_BIN` at it: `HARN_BIN=~/projects/harn/target/debug/harn ./play`.)

**2. A local OpenAI-compatible chat server with a model loaded.** The launcher defaults to `http://localhost:8001` (typical for `llama-server`) and the script sends model name `qwen3.6-35b-a3b-ud-q4-k-xl`. Override the URL with `LOCAL_LLM_BASE_URL=...` and the model name by editing `MODEL` at the top of `20eq.harn`.

Spot-checked against [Qwen3.6-35B-A3B](https://huggingface.co/Qwen) on llama.cpp. Other local OpenAI-compat servers (Ollama, vLLM, MLX) should work with small tweaks to the `provider` / `model` knobs.

## Play

```sh
./play
```

Or run Harn directly:

```sh
harn run 20eq.harn
```

Type `/quit` to bail early; otherwise the candle goes out on its own after 20 turns and the dossier drops.

## Files

- `20eq.harn` — the game (system prompt, chat loop, secret-stripping, reveal pass)
- `harn.toml` — Harn package manifest
- `play` — launcher; pre-flights the LLM endpoint and runs harn
- `LICENSE`, `README.md`, `.gitignore` — boilerplate

## License

MIT — see [LICENSE](./LICENSE). Covers the contents of this repository only. Harn is a separate project under its own dual Apache-2.0/MIT license, and any local LLM weights you point this at are governed by their own terms.
