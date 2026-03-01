# CLAUDE.md — LuaCsForBarotrauma

This file provides guidance for AI assistants (Claude Code and similar tools) working in this repository.

## Project Overview

**LuaCsForBarotrauma** is a modification of the game [Barotrauma](https://barotraumagame.com/) that adds Lua and C# scripting support for modders. It layers a complete scripting runtime on top of the Barotrauma game engine, enabling mods to:

- Execute **Lua scripts** via a custom fork of [MoonSharp](https://github.com/evilfactory/moonsharp)
- Load **C# assemblies** at runtime with full game API access
- **Patch game methods** using HarmonyLib and custom IL generation
- Communicate over the **network** between client and server mods

Online documentation: https://evilfactory.github.io/LuaCsForBarotrauma
Discord: https://discord.gg/f9zvNNuxu9

---

## Repository Structure

```
LuaCsForBarotrauma/
├── Barotrauma/
│   ├── BarotraumaClient/         # Client-only source (GUI, audio, rendering)
│   │   ├── ClientSource/
│   │   │   └── LuaCs/            # Client-side Lua/C# overrides (setup, networking, installer)
│   │   ├── LinuxClient.csproj
│   │   ├── WindowsClient.csproj
│   │   └── MacClient.csproj
│   ├── BarotraumaServer/         # Server-only source (headless server)
│   │   ├── ServerSource/
│   │   ├── LinuxServer.csproj
│   │   ├── WindowsServer.csproj
│   │   └── MacServer.csproj
│   ├── BarotraumaShared/         # Shared code (both client and server)
│   │   ├── SharedSource/
│   │   │   └── LuaCs/            # Core Lua/C# integration layer
│   │   │       ├── LuaCsHook.cs          # Hook/patch system (HarmonyLib + Sigil IL)
│   │   │       ├── LuaCsSetup.cs         # Initialization and config
│   │   │       ├── LuaCsLogger.cs        # Logging infrastructure
│   │   │       ├── LuaCsNetworking.cs    # Network message routing
│   │   │       ├── LuaCsTimer.cs         # Timer management
│   │   │       ├── LuaCsInstaller.cs     # Mod installation helpers
│   │   │       ├── LuaCsModStore.cs      # Mod storage
│   │   │       ├── LuaCsSteam.cs         # Steam API integration
│   │   │       ├── ModUtils.cs           # General mod utilities
│   │   │       ├── Lua/                  # Lua-specific C# wrappers
│   │   │       └── Plugins/              # C# plugin loading system
│   │   │           ├── IAssemblyPlugin.cs     # Interface all C# mods implement
│   │   │           ├── ACsMod.cs              # Legacy base class (deprecated)
│   │   │           ├── AssemblyManager.cs     # Assembly load/unload lifecycle
│   │   │           ├── CsPackageManager.cs    # Package management
│   │   │           └── MemoryFileAssemblyContextLoader.cs
│   │   └── Lua/                  # Default Lua scripts
│   │       ├── LuaSetup.lua      # Entry point for Lua runtime
│   │       ├── DefaultLib/       # Standard library (math, string, util, steam)
│   │       ├── DefaultRegister/  # Type registration (shared, client, server)
│   │       ├── DefaultHook.lua   # Default hook registrations
│   │       ├── CompatibilityLib.lua
│   │       ├── ModLoader.lua     # Loads user mods
│   │       └── PostSetup.lua
│   └── BarotraumaTest/           # Unit and integration tests
│       ├── LuaCs/                # LuaCs-specific tests
│       │   ├── HookPatchTests.cs
│       │   ├── LuaCsFixture.cs
│       │   └── HookPatchHelpers.cs
│       ├── ClientServer/         # Networking tests
│       ├── LinuxTest.csproj
│       ├── WindowsTest.csproj
│       └── MacTest.csproj
├── Libraries/                    # Third-party libraries
│   ├── moonsharp/                # Git submodule: custom MoonSharp fork (Lua interpreter)
│   ├── MonoGame.Framework/       # Game framework (graphics, input, audio)
│   ├── Farseer Physics Engine 3.5/ # Physics
│   ├── Lidgren.Network/          # Networking
│   ├── Facepunch.Steamworks/     # Steam API
│   ├── SharpFont/                # Font rendering
│   ├── Concentus/                # Audio codec
│   ├── NuGet/                    # NuGet package cache (gitignored)
│   └── ...
├── Deploy/                       # Release/deployment tooling
│   ├── DeployAll.sh              # Main deploy script (runs dotnet run on DeployAll/)
│   ├── DeployAll/                # C# deploy orchestrator
│   └── patches/                  # Git patches applied during CI build
├── BuildScripts/                 # Steam VDF app configurations
├── HelperScripts/                # Miscellaneous helper scripts
├── luacs-docs/                   # Documentation sources
│   ├── lua/                      # Lua API docs (LDoc-based)
│   └── cs/                       # C# API docs (Doxygen-based)
├── changelogs/                   # Per-version changelogs
├── LinuxSolution.sln             # Linux build solution
├── WindowsSolution.sln           # Windows build solution
├── MacSolution.sln               # macOS build solution
├── NuGet.Config                  # NuGet settings
└── .editorconfig                 # Code formatting rules
```

---

## Build System

### Prerequisites

| Platform | Requirement |
|----------|-------------|
| Windows  | Visual Studio 2022+ with ".NET desktop development" workload |
| Linux    | .NET 8 SDK |
| macOS    | Visual Studio 2022 for Mac |

### Building

Use the platform-appropriate solution file:

```bash
# Build from command line (example: Linux debug)
dotnet build LinuxSolution.sln -c Debug /p:Platform=x64

# Build from command line (example: Linux release)
dotnet build LinuxSolution.sln -c Release /p:Platform=x64
```

For a full release build (all platforms), use the deploy script:

```bash
cd Deploy
./DeployAll.sh
# Output: Deploy/bin/content/
```

The CI pipeline applies two patches before building:
- `Deploy/patches/disable-interactivity.diff`
- `Deploy/patches/prevent-crash-on-missing-dir.diff`

### NuGet Packages

Packages are restored automatically. The local cache lives in `Libraries/NuGet/`. Key LuaCs-specific packages (defined in `Barotrauma/BarotraumaShared/Luatrauma.props`):

- `Microsoft.CodeAnalysis.CSharp.Scripting` 4.1.0 — C# scripting runtime
- `MonoMod.RuntimeDetour` 25.2.3 — Runtime method patching
- `HarmonyX` 2.14.0 — Method prefix/postfix/transpiler patches
- `Sigil` 5.0.0 — IL code generation
- `Luatrauma.Internal.AssemblyPublicizer.MSBuild` — Makes internal members accessible

### Key Build Conditionals

Code uses preprocessor directives extensively:

```csharp
#if SERVER   // Server-only code
#if CLIENT   // Client-only code (default when not SERVER)
#if WINDOWS  // Windows platform
#if LINUX    // Linux platform
#if OSX      // macOS platform
```

---

## Running Tests

```bash
# Run all tests (Linux)
dotnet test LinuxSolution.sln -clp:"ErrorsOnly;Summary"

# Run with detailed output
dotnet test LinuxSolution.sln --logger "trx;LogFileName=test-results.trx"

# Required: the game config directory must exist
mkdir -p ~/.local/share/"Daedalic Entertainment GmbH"/Barotrauma
```

**Test framework**: xunit with FsCheck (property-based testing) and FluentAssertions.

**Test categories**:
- `BarotraumaTest/LuaCs/` — Hook/patch system (verify Lua can patch C# methods)
- `BarotraumaTest/ClientServer/` — Headless network tests
- `BarotraumaTest/*.cs` — Math, serialization, networking utilities

Tests with the `[DebugOnlyTest]` attribute or found in `LocalMods/[DebugOnlyTest]*` directories are for manual debug testing only.

---

## CI/CD Workflows

All workflows live in `.github/workflows/`.

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `on-push-pr.yml` | Pull requests | Security checks + run tests |
| `on-push-master.yml` | Push to `master` | Run tests + publish `latest` release |
| `on-push-other-branch.yml` | Other branches | Lightweight checks |
| `create-prerelease.yml` | Daily at 00:00 UTC | Publish `nightly` tag if `develop` has new commits |
| `publish-release.yml` | Called by other workflows | Build all platforms, create GitHub release, upload to Steam |
| `build.yml` | Workflow call / manual | Build and produce `build.tar.gz` artifact |
| `run-tests.yml` | Workflow call | Run test suite, upload TRX results |
| `update-docs.yml` | Workflow call | Regenerate and deploy docs to GitHub Pages |
| `update-moonsharp.yml` | Manual | Update MoonSharp submodule |
| `harden-ci-security.yml` | Called on PRs | CI security hardening |
| `report-test-results.yml` | After tests | Post test results as PR comment |

Release builds produce archives for six targets: `Windows/Client`, `Windows/Server`, `Linux/Client`, `Linux/Server`, `Mac/Client`, `Mac/Server`.

---

## Code Conventions

### Naming (Microsoft C# Guidelines)

- **PascalCase**: Classes, methods, properties, events — `LuaCsHook`, `Initialize()`, `OnAssemblyLoaded`
- **camelCase**: Local variables, parameters — `luaCs`, `pluginList`
- **UPPER_SNAKE_CASE**: Not used; constants use PascalCase — `LuaSetupFile`, `VersionFile`
- **`LuaCs*` prefix**: All classes in the Lua/C# integration layer — `LuaCsSetup`, `LuaCsHook`
- **`I*` prefix**: Interfaces — `IAssemblyPlugin`

References:
- https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/naming-guidelines
- https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/inside-a-program/coding-conventions

### Formatting (enforced by `.editorconfig`)

| File type | Indent | Charset |
|-----------|--------|---------|
| `*.cs` | 4 spaces | UTF-8-BOM |
| `*.sln` | — | UTF-8-BOM |
| `*.csproj`, `*.xml`, `*.html` | 2 spaces | UTF-8 |
| `*.sh`, `*.ps1` | 2 spaces | UTF-8 |
| `*.lua` | 2 spaces | UTF-8 |
| `*.js`, `*.json` | 2 spaces | UTF-8 |

All files require a final newline. Braces are required for multiline blocks (warning level).

### Partial Classes

Many core classes are split across files using `partial class`. For example, `LuaCsSetup` has shared, client, and server parts:
- `SharedSource/LuaCs/LuaCsSetup.cs`
- `ClientSource/LuaCs/LuaCsSetup.cs`
- `ServerSource/LuaCs/LuaCsSetup.cs`

When modifying these, make sure to check all parts.

---

## Key Architecture Concepts

### Hook/Patch System (`LuaCsHook.cs`)

The hook system allows Lua and C# mods to intercept game method calls. It uses:
- **HarmonyLib** for prefix/postfix patches
- **Sigil** for IL generation when wrapping method parameters

```csharp
// Delegates used by the hook system
public delegate void LuaCsAction(params object[] args);
public delegate object LuaCsFunc(params object[] args);
public delegate DynValue LuaCsPatchFunc(object instance, LuaCsHook.ParameterTable ptable);
```

### C# Plugin Lifecycle (`IAssemblyPlugin`)

All C# mods must implement `IAssemblyPlugin`:

```csharp
public interface IAssemblyPlugin : IDisposable
{
    void Initialize();        // Called first; basic setup only
    void OnLoadCompleted();   // Called after all plugins load; cross-mod integration here
    void PreInitPatching();   // Called before Barotrauma vanilla content loads; may precede Initialize()
}
```

The legacy `ACsMod` abstract class is **deprecated** — prefer `IAssemblyPlugin` directly.

### Assembly Loading (`AssemblyManager`)

- Each mod's assembly loads into its own `AssemblyLoadContext` (`MemoryFileAssemblyContextLoader`)
- The manager supports hot-reload by unloading and reloading contexts
- Thread-safe by design (future parallelization)
- Events: `OnAssemblyLoaded`, `OnAssemblyUnloading`, `OnException`, `OnACLUnload`

### Lua Setup Flow

1. `LuaCsSetup` initializes the MoonSharp interpreter
2. `Lua/LuaSetup.lua` is the entry point — loads registers, default library, hooks
3. `ModLoader.lua` discovers and loads user mods
4. Config: `LuaCsSetupConfig.xml` in the game root (controls `EnableCsScripting`, etc.)

### Configuration (`LuaCsSetupConfig`)

```xml
<LuaCsSetupConfig
  EnableCsScripting="true"
  TreatForcedModsAsNormal="false"
  PreferToUseWorkshopLuaSetup="false"
  DisableErrorGUIOverlay="false"
  HideUserNames="true" />
```

---

## Git Workflow

### Branches

- **`master`** — stable releases; pushes trigger test run + publish `latest`
- **`develop`** — nightly pre-releases; daily CI checks for new commits and tags `nightly`
- Feature/fix branches: no strict naming convention, but reference issue numbers in commit messages

### Submodules

```bash
# Clone with submodules
git clone --recurse-submodules <repo>

# Initialize submodules after a plain clone
git submodule update --init --recursive
```

Submodules:
- `Libraries/moonsharp` → https://github.com/evilfactory/moonsharp
- `luacs-docs/lua/libs/ldoc` → https://github.com/evilfactory/LDoc

### Commit Messages

No strict format, but guidelines from CONTRIBUTING.md:
- Be informative: what changed and why
- Reference related commits or issues: `Fixes #123`, `Regression from a1b9b7z`
- Keep the subject line concise; use the body for details

---

## Missing Assets (Important)

The `Barotrauma/BarotraumaShared/Content/` directory (game art, item XMLs, sounds) is **not included** in the repository and is listed in `.gitignore`. To compile a working game build you need a legal copy of Barotrauma and must copy its `Content/` folder to `Barotrauma/BarotraumaShared/Content/`.

Similarly, `GameAnalyticsKeys.cs` and Steam/EGS private keys are excluded from the repo.

---

## Useful Commands

```bash
# Build (Linux)
dotnet build LinuxSolution.sln -c Debug /p:Platform=x64

# Test (Linux) — requires config dir to exist
mkdir -p ~/.local/share/"Daedalic Entertainment GmbH"/Barotrauma
dotnet test LinuxSolution.sln -clp:"ErrorsOnly;Summary"

# Clean build artifacts
bash HelperScripts/cleanup_obj.sh

# Full release build
cd Deploy && ./DeployAll.sh

# Update submodules
git submodule update --init --recursive
```

---

## Documentation

- Online docs: https://evilfactory.github.io/LuaCsForBarotrauma
- Lua API: generated with LDoc (`luacs-docs/lua/`)
- C# API: generated with Doxygen (`luacs-docs/cs/`)
- Lua manual: `luacs-docs/lua/manual/`
- C# manual: `luacs-docs/cs/manual/`
