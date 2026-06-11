---
name: harmonyos-deveco-cli
description: Run DevEco Studio and HarmonyOS project checks for this repo. Use when you need ArkTS linting, Hvigor build/test tasks, preview builds, HAP packaging, emulator/device probes, or to verify whether the local DevEco installation can be driven from the agent.
---

# HarmonyOS DevEco CLI

## Scope
Use this skill to run the local HarmonyOS toolchain from the agent. Prefer it for build, lint, preview, packaging, and device-surface checks on this project.

## Canonical Environment
Use [`scripts/Invoke-DevEco.ps1`](scripts/Invoke-DevEco.ps1) before any DevEco command.

- Set `DEVECO_SDK_HOME` to `C:\workspace\apps\DevEco Studio\sdk`
- Set `NODE_HOME` to `C:\workspace\apps\DevEco Studio\tools\node`
- Prefix `PATH` with `tools\node`, `tools\ohpm\bin`, and `sdk\default\openharmony\toolchains`
- Keep `DEVECO_SDK_HOME` on the SDK root. Do not point it at `sdk\default`

## Preferred Commands
- Run `hvigorw tasks` first when task names are unclear.
- Run `hvigorw buildInfo` to confirm product, module, and build modes.
- Run `hvigorw assembleHap` for packaging. Expect an unsigned HAP unless signing configs exist.
- Run `hvigorw test` for unit-test build and execution.
- Run `node C:\workspace\apps\DevEco Studio\plugins\codelinter\run\index.js -c code-linter.json5 -e error entry\src\main` for ArkTS linting.
- Run `hdc list targets` to check connected devices.
- Run `Emulator.exe -list -details` to inspect local emulator instances.

## Preview Workflow
- Treat `PreviewBuild` as a long-running preview flow, not a quick one-shot command.
- Expect `.preview` outputs under `entry\.preview\default\...`.
- If the process does not exit, inspect the preview logs before retrying.

## Rules
- Use short Hvigor task names such as `assembleHap`, `test`, and `buildInfo`.
- Do not use Gradle-style task paths like `:entry:assembleHap` here.
- Do not rely on `bin\inspect.bat` or `bin\format.bat` for automation; this install only exposes generic IntelliJ help there.
- If `hvigor` reports SDK errors, fix the environment first. The common failure is a bad `DEVECO_SDK_HOME`.
- Use `entry\build\default\outputs\default\entry-default-unsigned.hap` as the build artifact unless signing is added.
