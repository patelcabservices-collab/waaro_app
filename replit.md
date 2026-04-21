# Waaro

A Flutter web/mobile app (project name `waro`).

## Stack
- Flutter 3.32 / Dart 3.8
- GetX state management, Dio HTTP, socket_io_client, shared_preferences

## Project Layout
- `waro/` — Flutter project (lib/, web/, android/, ios/, etc.)

## Development
- Workflow `Start application` runs:
  `cd waro && flutter run -d web-server --web-hostname=0.0.0.0 --web-port=5000`
- Served on port 5000 with host 0.0.0.0 for the Replit preview proxy.

## Deployment
- Static deployment.
- Build: `cd waro && flutter build web --release`
- Public dir: `waro/build/web`

## Notes
- `pubspec.yaml` Dart SDK constraint relaxed from `^3.10.8` to `^3.5.0` to
  match the Flutter/Dart version available in the Replit Nix environment.
