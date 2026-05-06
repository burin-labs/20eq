# 20EQ

A Halloween-themed command-line chatbot game in the spirit of *20 Questions* — except the spooky teen-coded character on the other side of the void is secretly running an information-theoretic profile of you over ~20 turns. When the candle goes out, she drops the act and reveals her dossier.

Written in [Harn](https://harnlang.com).

## Requirements

- A working Harn toolchain. The launcher assumes a clone at `~/projects/harn` — override with `HARN_REPO=/path/to/harn` if yours lives elsewhere.
- A local OpenAI-compatible chat server. The launcher defaults to `http://localhost:8001` (a typical `llama-server` port) and sends the model name `qwen3.6-35b-a3b-ud-q4-k-xl`. Override the URL with `LOCAL_LLM_BASE_URL=...` and the model name by editing `MODEL` at the top of `20eq.harn`.

The game has only been spot-checked against [Qwen3.6-35B-A3B](https://huggingface.co/Qwen) running under llama.cpp. Other local OpenAI-compat servers (Ollama, vLLM, MLX) should work with small tweaks to the `provider` / `model` knobs.

## Play

```sh
./play
```

First run builds the harn binary into `./.harn-target/` (a few minutes). Every run after that is instant.

Type `/quit` to bail early; otherwise the candle goes out on its own after 20 turns and the dossier drops.

## Files

- `20eq.harn` — the game (system prompt, chat loop, secret-stripping, reveal pass)
- `play` — launcher; pre-flights the LLM endpoint and runs harn

## License

MIT — see [LICENSE](./LICENSE). Covers the contents of this repository only. Harn is a separate project under its own dual Apache-2.0/MIT license, and any local LLM weights you point this at are governed by their own terms.
