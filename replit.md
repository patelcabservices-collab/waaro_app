# Waaro

A Flutter web/mobile app (project name `waro`).

## Stack
- Flutter 3.32 / Dart 3.8
- GetX state management, Dio HTTP, socket_io_client, shared_preferences

## Project Layout
- `waro/` — Flutter project (lib/, web/, android/, ios/, etc.)

## Development
- Workflow `Start application` runs a release build and serves it:
  `cd waro && (test -f build/web/index.html || flutter build web --release) && cd build/web && python3 -m http.server 5000 --bind 0.0.0.0`
- Served on port 5000 with host 0.0.0.0 for the Replit preview proxy.
- Note: Flutter's dev compiler (DDC) in the Nix Flutter 3.32 SDK has a bug
  causing `InvalidType` errors on framework code, so the release build path
  is used instead. To pick up code changes, delete `waro/build` and restart
  the workflow.

## Deployment
- Static deployment.
- Build: `cd waro && flutter build web --release`
- Public dir: `waro/build/web`

## Notes
- `pubspec.yaml` Dart SDK constraint relaxed from `^3.10.8` to `^3.5.0` to
  match the Flutter/Dart version available in the Replit Nix environment.

## UI System
- Brand palette in `lib/core/theme/app_colors.dart`: yellow `#FFD53D`
  primary, navy `#0F172A` foreground, soft surfaces, success/warning/error
  with paired *Soft* tones.
- Theme in `lib/core/theme/app_theme.dart` uses Plus Jakarta Sans and
  Material 3.
- Shared widgets:
  - `lib/widgets/common/primary_button.dart` — pill button with
    dark/yellow/outline/ghost variants.
  - `lib/widgets/common/app_text_field.dart` — labeled input.
  - `lib/widgets/common/section_header.dart` — section header,
    `EmptyState`, `LoadingView`.

## Routes (`lib/main.dart`)
`/` splash, `/login`, `/signup`, `/home`, `/notifications`, `/settings`,
`/saved`, `/categories`, `/search`, `/post`, `/product`, `/edit-profile`,
`/support`, `/verification`.

## Tabs (`MainNavigation`)
Pill-style dark bottom nav with 5 sections: Network, Feed, Create,
Messages, Profile.
