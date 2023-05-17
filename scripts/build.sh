#!/bin/bash

export RUSTFLAGS="-Ccodegen-units=1"

rustup default stable

cargo install cross

platforms=(
'x86_64-unknown-linux-gnu'
'x86_64-pc-windows-gnu'
'x86_64-unknown-linux-musl'
)

for platform in ${platforms[*]}
do
  mkdir -p ./libs/${platform}
  pushd zerokit/rln
  cargo clean
  cross build --release --lib --target=${platform}
  cp ../target/${platform}/release/librln.a ../../libs/${platform}/.
  popd
done




