---
name: harmonyos-arkts-api-docs
description: Research and verify HarmonyOS ArkTS, ArkUI, Stage model, Form Kit, Scan Kit, ArkData Preferences, networking, and related system APIs using Huawei official documentation plus the local DevEco SDK. Use when implementing or reviewing .ets/.ts HarmonyOS code, choosing imports, permissions, module.json5 entries, service-card APIs, state decorators, ArkUI components, or when API names/signatures may have changed.
---

# HarmonyOS ArkTS API Docs

## Workflow

1. Prefer Huawei official documentation before relying on memory for ArkTS APIs, ArkUI components, HarmonyOS permissions, service cards, Scan Kit, Preferences, and networking.
2. Open the relevant entry in `references/official-doc-index.md`, then search the official site if the API is not listed there.
3. Cross-check the chosen API against the local DevEco SDK when possible:

```powershell
.codex\skills\harmonyos-arkts-api-docs\scripts\Search-ArkTSApi.ps1 createHttp
.codex\skills\harmonyos-arkts-api-docs\scripts\Search-ArkTSApi.ps1 '@Watch'
```

4. Implement with the API level and project SDK in mind. For this repo, also use `.codex/skills/harmonyos-deveco-cli/SKILL.md` to run lint/build/test.
5. If the website and local SDK disagree, treat the local SDK as the compile target and mention the mismatch.

## Official Docs

Use `references/official-doc-index.md` for curated official links and search patterns. Do not paste large sections of Huawei docs into answers or repo files; summarize and link instead.

Useful official search patterns:

```text
site:developer.huawei.com/consumer/cn/doc/harmonyos-references <API or module>
site:developer.huawei.com/consumer/cn/doc/harmonyos-guides <feature or component>
```

## Local SDK Checks

Use `Search-ArkTSApi.ps1` to locate API declarations, examples, and module names under the installed DevEco SDK. This is useful for:

- verifying import module names such as `@ohos.net.http`;
- checking enum/type names before writing ArkTS;
- finding whether an API exists in the installed SDK;
- avoiding stale snippets from older HarmonyOS documentation versions.

Default SDK root:

```text
C:\workspace\apps\DevEco Studio\sdk
```

## Implementation Guardrails

- Add required permissions to `module.json5` before using guarded system APIs such as networking or camera/scan flows.
- Confirm whether an API is app-page-only, card-only, or extension-only. For example, `postCardAction` is card-side behavior and should not be used as a normal page API.
- For service cards, confirm the supported component subset before copying normal ArkUI page layouts.
- For state decorators, verify data flow direction: `@Prop` is parent-to-child one-way; `@Link` is two-way and must be initialized from a bindable parent state.
- After edits, run the DevEco skill checks: codelinter, `hvigorw assembleHap`, and `hvigorw test` when relevant.
