includes("src/xmake.lua")

set_project("brpc")
set_version("1.4.0", {build = "%Y%m%d%H%M"})
set_allowedplats("linux")
set_config("buildir", "xmake_build")

add_rules("mode.debug", "mode.release")

-- requires
add_requires("gflags", {system = true})
add_requires("protobuf", {system = true})

-- compile flags
set_warnings("all", "error")
set_languages("c++17")
add_includedirs(".")
add_includedirs("src")

-- options
option("with_glog", {default = false, description = "With glog"})
option("with_mesa_link", {default = false, description = "With MesaLink"})
option("debug_log", {default = false, description = "Print debug log"})
option("with_debug_symbols",
       {default = true, description = "With debug symbols"})
option("with_thrift",
       {default = false, description = "With thrift framed protocol supported"})
option("with_snappy", {default = false, description = "With snappy"})
option("with_rdma", {default = false, description = "With rdma"})
option("build_unit_tests",
       {default = false, description = "Whether to build unit tests"})
option("build_brpc_tools",
       {default = true, description = "Whether to build brpc tools"})
option("download gtest", {
    default = true,
    description = "Download and build a fresh copy of googletest. Requires Internet access."
})

-- 通过 option 在初始化 project 时获取 GFLAGS_NS 宏变量的值, 如果使用 rule:on_load 会导致每个 target 都运行一次
option("gflags_ns", function()
    set_description("define GFLAGS_NS macros")
    set_default(true)
    after_check(function(option)
        local output = os.iorun_with_pipes(
                           [[grep "namespace [_A-Za-z0-9]\\+ {" /usr/include/gflags/gflags_declare.h | head -1 | awk '{print $2}' | tr -d '\n']])
        if output == "GFLAGS_NAMESPACE" then
            output = os.iorun_with_pipes(
                         [[grep "#define GFLAGS_NAMESPACE [_A-Za-z0-9]\\+" /usr/include/gflags/gflags_declare.h | head -1 | awk '{print $3}' | tr -d '\n']])
        end
        cprint(
            "${bright blue}[rule@define_macros][info]${clear} GFLAGS_NS = [%s]",
            output)
        option:add("defines", "GFLAGS_NS=" .. output)
    end)
end)

add_options("gflags_ns")

target("src_proto", function()
    set_kind("object")
    add_files("src/idl_options.proto", {
        proto_public = true,
        proto_rootdir = ".",
        extra_flags = "-I/usr/include"
    })
    add_rules("protobuf.cpp")
    add_packages("protobuf", {public = true})
    set_policy('build.fence', true)
end)
