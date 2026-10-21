---
name: yap-rust
description: Rust idioms. Load with yap-code whenever writing or editing rust.
---

# yap-rust

one-line goal: small, fast, clippy-clean rust.

| area | rule |
|---|---|
| errors | `Result` and `?`, `anyhow` for bins, `thiserror` for libs |
| unwrap | none outside tests, `expect` only for true invariants |
| borrowing | `&str` and slices over owned types, avoid `clone` unless needed |
| iteration | iterators over index loops |
| allocs | preallocate with `with_capacity` when size is known |
| deps | std first, a crate when it replaces real code |
| format | `cargo fmt`, clippy clean |
| naming | language idiom, short names |
| constants | lowercase at top per yap-code, add `#![allow(non_upper_case_globals)]` to silence the lint |
| comments | short lowercase phrases |
| tests | only for tricky logic |
