# Stop Slop Marketplace

A marketplace wrapper for [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop) that supports both Claude and ChatGPT/Codex.

- Claude installs the skill directly from the upstream GitHub repository.
- ChatGPT and Codex install the bundled OpenAI plugin from this repository.
- A scheduled GitHub Actions workflow checks upstream every day, refreshes the OpenAI bundle, and increments its plugin version when the skill changes.

## Claude Code

Add and install the marketplace:

```text
/plugin marketplace add FrantsevN/stop-slop-marketplace
/plugin install stop-slop@stop-slop-marketplace
```

Choose the **User** scope if you want the plugin in every project. Invoke it directly with:

```text
/stop-slop:stop-slop
```

Third-party marketplace auto-updates are disabled by default. Open `/plugin`, select **Marketplaces**, choose **stop-slop-marketplace**, and enable auto-update. To update manually:

```text
/plugin update stop-slop@stop-slop-marketplace
```

## ChatGPT and Codex

Add the Git-backed marketplace:

```bash
codex plugin marketplace add FrantsevN/stop-slop-marketplace
```

Then open the plugin browser:

```text
/plugins
```

Install **Stop Slop**, start a new chat or CLI session, and type `@` when you want to select the plugin or its bundled skill explicitly.

In the ChatGPT desktop app, restart the app after adding the marketplace, open **Plugins**, select **Stop Slop Marketplace**, and install **Stop Slop**. Plugins are available in ChatGPT Work and Codex surfaces that support plugins.

Refresh the Git marketplace when you want to pull a newer bundled version:

```bash
codex plugin marketplace upgrade stop-slop-marketplace
```

## Upstream sync

The OpenAI plugin lives under `plugins/stop-slop/`. The workflow in `.github/workflows/sync-upstream.yml` runs daily and can also be started manually from GitHub Actions. It copies the upstream `SKILL.md`, `references/`, and `LICENSE`, records the source SHA in `UPSTREAM_COMMIT`, and increments the plugin patch version when content changes.

## Attribution

Stop Slop was created by [Hardik Pandya](https://hvpandya.com) and is distributed under the [MIT License](https://github.com/hardikpandya/stop-slop/blob/main/LICENSE).

This marketplace is an independent distribution wrapper and is not affiliated with the upstream author.
