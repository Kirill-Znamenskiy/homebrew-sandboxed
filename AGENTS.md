# AGENTS.md

## Scope

This repository is the Homebrew tap for `sandboxed`. It exists only to publish Homebrew formulae and should not contain the launcher source code itself.

The source project lives in `Kirill-Znamenskiy/sandboxed`. Formulae here should install released source archives from that repository.

## Branching

Do not use GitFlow in this tap repository.

Use only `main`. Commit formula changes directly and sequentially to `main`; this repository is packaging metadata, not the product integration branch.

## Formula Policy

Keep formulae under `Formula/` using standard Homebrew tap layout.

The `sandboxed` formula should:

- install launcher files under Homebrew `libexec`;
- install shipped target files from `targets/`;
- expose both `sandboxed` and `sbxd` commands;
- depend on generic `python`, not a pinned Python minor version unless a concrete compatibility issue requires it;
- vendor Python package resources only when Homebrew does not provide an appropriate formula.

Prefer release tarballs with `sha256` over branch-based source URLs.
