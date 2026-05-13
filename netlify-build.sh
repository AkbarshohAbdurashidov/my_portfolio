#!/usr/bin/env bash
set -euo pipefail

# Install a shallow checkout of Flutter stable
if [ ! -d "$HOME/flutter" ]; then
  git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$HOME/flutter"
fi

export PATH="$HOME/flutter/bin:$PATH"

# Enable web, get deps and pre-cache web artifacts then build
flutter config --enable-web
flutter pub get
flutter precache --web
flutter build web --release
