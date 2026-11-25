#!/usr/bin/env bash
# AutomIA: servidor propio, clave pública y opciones por defecto para las PDA.
set -euo pipefail
f=libs/hbb_common/src/config.rs
perl -0pi -e 's/pub const RENDEZVOUS_SERVERS: &\[&str\] = &\["[^"]*"\];/pub const RENDEZVOUS_SERVERS: &[&str] = &["$ENV{AUTOMIA_SERVER}"];/' "$f"
perl -0pi -e 's/pub const RS_PUB_KEY: &str = "[^"]*";/pub const RS_PUB_KEY: &str = "$ENV{AUTOMIA_KEY}";/' "$f"
perl -0pi -e 's/pub static ref BUILTIN_SETTINGS: RwLock<HashMap<String, String>> = Default::default\(\);/pub static ref BUILTIN_SETTINGS: RwLock<HashMap<String, String>> = RwLock::new(HashMap::from([("allow-deep-link-password".to_owned(), "Y".to_owned())]));/' "$f"
perl -0pi -e 's/pub static ref DEFAULT_SETTINGS: RwLock<HashMap<String, String>> = Default::default\(\);/pub static ref DEFAULT_SETTINGS: RwLock<HashMap<String, String>> = RwLock::new(HashMap::from([("approve-mode".to_owned(), "password".to_owned()), ("verification-method".to_owned(), "use-permanent-password".to_owned())]));/' "$f"
grep -F "RENDEZVOUS_SERVERS: &[&str] = &[\"$AUTOMIA_SERVER\"]" "$f"
grep -F "RS_PUB_KEY: &str = \"$AUTOMIA_KEY\"" "$f"
grep -F '"allow-deep-link-password".to_owned(), "Y"' "$f"
grep -F '"verification-method".to_owned(), "use-permanent-password"' "$f"
echo "AutomIA patch OK"
