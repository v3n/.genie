--
-- Genie build configuration for libsodium
--

local ZMQ_SRC_DIR = ZMQ_DIR .. "src/"

function build_libzmq(_lib_type)
project "zmq"
language "C++"

targetdir(BUILD_DIR .. _ACTION .. "/lib/")
targetname "zmq"
kind(_lib_type)

print(ZMQ_DIR)


includedirs
{
    ZMQ_DIR .. "include/",
    SODIUM_DIR .. "src/libsodium/include/"
}

links 
{
    "sodium"
}

flags
{
}

files
{
    ZMQ_DIR .. "src/**.hpp",
    ZMQ_DIR .. "src/**.cpp" 
}

-- some configuration specific files
excludes
{
}

if _lib_type == "StaticLib" then
    defines
    {
        "ZMQ_STATIC"
    }
end

configuration "linux or macosx"
    defines 
    {
        "ZMQ_USE_EPOLL"
    }

    buildoptions
    {
        "-Wall",
        "-Wno-long-long",
        "-Wno-uninitialized"
    }

    linkoptions
    {
        "-export-dynamic",
        "-no-undefined"
    }

    if not os.isfile(ZMQ_SRC_DIR .. "platform.hpp") then
        -- annoying, but neccesary
        prebuildcommands
        {
            "sodium_CFLAGS=-I"  .. SODIUM_SRC_DIR .. "include/ sodium_LIBS=" .. BUILD_DIR .. _ACTION .. "/lib/" .. " " .. ZMQ_DIR .. "./configure"
        }
    end

configuration "windows"
    buildoptions
    {
        "/W3",
        "-DWIN32",
        "-DDLL_EXPORT",
        -- May require tweaking for highly connected applications.
        "-DFD_SETSIZE=4096",
        "-D_CRT_SECURE_NO_WARNINGS",
        "/MP", -- Parallel make.
        -- Optimization flags.
        -- http://msdn.microsoft.com/en-us/magazine/cc301698.aspx
        "/GL",
        "/LTCG"
    }

    prebuildcommands
    {
        "copy \\Y" .. SCRIPTS_DIR .. "zmq/platform-win.hpp " .. ZMQ_SRC_DIR .. "platform.hpp" 
    }

configuration "x86"
    files
    {
    }

configuration "x64"
    files
    {
    }

-- reset to default config
configuration {}

end
