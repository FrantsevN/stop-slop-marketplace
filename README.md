# Stop Slop Marketplace

A minimal Claude Plugin Marketplace wrapper for [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop).

This repository does not copy or modify the upstream skill. Claude installs it directly from the upstream GitHub repository.

## Install

Run these commands in Claude Code:

```text
/plugin marketplace add FrantsevN/stop-slop-marketplace
/plugin install stop-slop@stop-slop-marketplace
```

If Claude asks for an installation scope, choose **User** to make the plugin available in every project.

## Use

Claude can activate the skill when you draft, edit, or review prose. You can also invoke it directly:

```text
/stop-slop:stop-slop
```

## Keep it up to date

The marketplace entry points to `hardikpandya/stop-slop` without a pinned `ref`, `sha`, or `version`. Claude therefore uses the current upstream commit SHA as the plugin version.

Third-party marketplace auto-updates are disabled by default. To receive upstream changes automatically:

1. Run `/plugin`
2. Open **Marketplaces**
3. Select **stop-slop-marketplace**
4. Choose **Enable auto-update**

To update manually, run:

```text
/plugin update stop-slop@stop-slop-marketplace
```

If Claude reports that plugins changed, run `/reload-plugins` or restart Claude Code.

## Attribution

Stop Slop was created by [Hardik Pandya](https://hvpandya.com) and is distributed under the [MIT License](https://github.com/hardikpandya/stop-slop/blob/main/LICENSE).

This marketplace is an independent distribution wrapper and is not affiliated with the upstream author.
