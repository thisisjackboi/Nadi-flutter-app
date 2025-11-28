#!/bin/bash

if [ -d "_flutter" ]; then
    cd _flutter
    git pull
    cd ..
else
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 _flutter
fi

export PATH="$PATH:`pwd`/_flutter/bin"

flutter config --enable-web
flutter build web --release
