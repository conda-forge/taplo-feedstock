@echo on

set CARGO_PROFILE_RELEASE_STRIP=symbols

:: build
cargo install --locked ^
    --root "%PREFIX%" ^
    --path crates/taplo-cli ^
    --features lsp,rustls-tls ^
    --no-track ^
    || exit 1

:: strip debug symbols
strip "%PREFIX%\bin\taplo.exe" || exit 1

:: dump licenses
cargo-bundle-licenses ^
    --format yaml ^
    --output "%SRC_DIR%\THIRDPARTY.yml" ^
    || exit 1
