--
-- Genie build configuration for libsodium
--

local SODIUM_SRC_DIR = SODIUM_DIR .. "src/libsodium/"

function build_libsodium(_lib_type, _lang)
project "sodium"
language(_lang)

targetdir(BUILD_DIR .. _ACTION .. "/lib/")
targetname "sodium"
kind(_lib_type)

print(SODIUM_DIR)


includedirs
{
    SODIUM_DIR .. "src/libsodium/include/",
    SODIUM_DIR .. "src/libsodium/include/sodium/"
}

flags
{

}

files
{
    SODIUM_SRC_DIR .. "crypto_aead/**.c",
    SODIUM_SRC_DIR .. "crypto_auth/**.h",
    SODIUM_SRC_DIR .. "crypto_auth/**.c",
    SODIUM_SRC_DIR .. "crypto_box/**.h",
    SODIUM_SRC_DIR .. "crypto_box/**.c",
    SODIUM_SRC_DIR .. "crypto_core/**.h",
    SODIUM_SRC_DIR .. "crypto_core/**.c",
    SODIUM_SRC_DIR .. "crypto_generichash/**.h",
    SODIUM_SRC_DIR .. "crypto_generichash/**.c",
    SODIUM_SRC_DIR .. "crypto_hash/**.h",
    SODIUM_SRC_DIR .. "crypto_hash/**.c",
    SODIUM_SRC_DIR .. "crypto_onetimeauth/**.h",
    SODIUM_SRC_DIR .. "crypto_onetimeauth/**.c",
    SODIUM_SRC_DIR .. "crypto_pwhash/**.h",
    SODIUM_SRC_DIR .. "crypto_pwhash/**.c",
    SODIUM_SRC_DIR .. "crypto_scalarmult/**.c",
    SODIUM_SRC_DIR .. "crypto_secretbox/**.h",
    SODIUM_SRC_DIR .. "crypto_secretbox/**.c",
    SODIUM_SRC_DIR .. "crypto_shorthash/**.h",
    SODIUM_SRC_DIR .. "crypto_shorthash/**.c",
    SODIUM_SRC_DIR .. "crypto_sign/**.h",
    SODIUM_SRC_DIR .. "crypto_sign/**.c",
    SODIUM_SRC_DIR .. "crypto_stream/**.h",
    SODIUM_SRC_DIR .. "crypto_stream/**.c",
    SODIUM_SRC_DIR .. "crypto_verify/**.h",
    SODIUM_SRC_DIR .. "crypto_verify/**.c",
    SODIUM_SRC_DIR .. "randombytes/**.c",
    SODIUM_SRC_DIR .. "sodium/**.c"
}

-- some configuration specific files
excludes
{

}

configuration "linux or macosx"
    linkoptions
    {
        "-export-dynamic",
        "-no-undefined"
    }

configuration "x86"
    files
    {
        SODIUM_SRC_DIR .. "crypto_stream/salsa20/ref/api.h",
        SODIUM_SRC_DIR .. "crypto_stream/salsa20/ref/stream_salsa20_ref.c",
        SODIUM_SRC_DIR .. "crypto_stream/salsa20/ref/xor_salsa20_ref.c"
    }

configuration "x64"
    files
    {
        SODIUM_SRC_DIR .. "crypto_stream/salsa20/amd64_xmm6/api.h",
        SODIUM_SRC_DIR .. "crypto_stream/salsa20/amd64_xmm6/stream_salsa20_amd64_xmm6.S", 
    }

end
