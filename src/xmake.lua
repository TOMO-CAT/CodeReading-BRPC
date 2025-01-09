target("brpc_proto", function()
    set_kind("object")
    add_files("idl_options.proto", "brpc/rtmp.proto", "brpc/rpc_dump.proto",
              "brpc/get_favicon.proto", "brpc/span.proto",
              "brpc/builtin_service.proto", "brpc/get_js.proto",
              "brpc/errno.proto", "brpc/nshead_meta.proto",
              "brpc/options.proto", "brpc/policy/baidu_rpc_meta.proto",
              "brpc/policy/hulu_pbrpc_meta.proto",
              "brpc/policy/public_pbrpc_meta.proto",
              "brpc/policy/sofa_pbrpc_meta.proto", "brpc/policy/mongo.proto",
              "brpc/trackme.proto", "brpc/streaming_rpc_meta.proto",
              "brpc/proto_base.proto", {
        proto_public = true,
        proto_rootdir = ".",
        extra_flags = "-I/usr/include"
    })
    add_rules("protobuf.cpp")
    add_packages("protobuf", {public = true})
    set_policy('build.fence', true)
    add_deps("src_proto")
end)

target("butil", function()
    set_kind("object")

    add_files("butil/third_party/dmg_fp/g_fmt.cc",
              "butil/third_party/dmg_fp/dtoa_wrapper.cc",
              "butil/third_party/dynamic_annotations/dynamic_annotations.c",
              "butil/third_party/icu/icu_utf.cc",
              "butil/third_party/superfasthash/superfasthash.c",
              "butil/third_party/modp_b64/modp_b64.cc",
              "butil/third_party/symbolize/demangle.cc",
              "butil/third_party/symbolize/symbolize.cc",
              "butil/third_party/snappy/snappy-sinksource.cc",
              "butil/third_party/snappy/snappy-stubs-internal.cc",
              "butil/third_party/snappy/snappy.cc",
              "butil/third_party/murmurhash3/murmurhash3.cpp",
              "butil/arena.cpp", "butil/at_exit.cc",
              "butil/atomicops_internals_x86_gcc.cc", "butil/base64.cc",
              "butil/big_endian.cc", "butil/cpu.cc", "butil/debug/alias.cc",
              "butil/debug/asan_invalid_access.cc",
              "butil/debug/crash_logging.cc", "butil/debug/debugger.cc",
              "butil/debug/debugger_posix.cc",
              "butil/debug/dump_without_crashing.cc",
              "butil/debug/proc_maps_linux.cc", "butil/debug/stack_trace.cc",
              "butil/debug/stack_trace_posix.cc", "butil/environment.cc",
              "butil/files/file.cc", "butil/files/file_posix.cc",
              "butil/files/file_enumerator.cc",
              "butil/files/file_enumerator_posix.cc",
              "butil/files/file_path.cc", "butil/files/file_path_constants.cc",
              "butil/files/memory_mapped_file.cc",
              "butil/files/memory_mapped_file_posix.cc",
              "butil/files/scoped_file.cc", "butil/files/scoped_temp_dir.cc",
              "butil/file_util.cc", "butil/file_util_posix.cc", "butil/guid.cc",
              "butil/guid_posix.cc", "butil/hash.cc", "butil/lazy_instance.cc",
              "butil/location.cc", "butil/memory/aligned_memory.cc",
              "butil/memory/ref_counted.cc",
              "butil/memory/ref_counted_memory.cc", "butil/memory/singleton.cc",
              "butil/memory/weak_ptr.cc",
              "butil/posix/file_descriptor_shuffle.cc",
              "butil/posix/global_descriptors.cc", "butil/process_util.cc",
              "butil/rand_util.cc", "butil/rand_util_posix.cc",
              "butil/fast_rand.cpp", "butil/safe_strerror_posix.cc",
              "butil/sha1_portable.cc",
              "butil/strings/latin1_string_conversions.cc",
              "butil/strings/nullable_string16.cc",
              "butil/strings/safe_sprintf.cc", "butil/strings/string16.cc",
              "butil/strings/string_number_conversions.cc",
              "butil/strings/string_split.cc", "butil/strings/string_piece.cc",
              "butil/strings/string_util.cc",
              "butil/strings/string_util_constants.cc",
              "butil/strings/stringprintf.cc",
              "butil/strings/utf_offset_string_conversions.cc",
              "butil/strings/utf_string_conversion_utils.cc",
              "butil/strings/utf_string_conversions.cc",
              "butil/synchronization/cancellation_flag.cc",
              "butil/synchronization/condition_variable_posix.cc",
              "butil/synchronization/waitable_event_posix.cc",
              "butil/threading/non_thread_safe_impl.cc",
              "butil/threading/platform_thread_posix.cc",
              "butil/threading/simple_thread.cc",
              "butil/threading/thread_checker_impl.cc",
              "butil/threading/thread_collision_warner.cc",
              "butil/threading/thread_id_name_manager.cc",
              "butil/threading/thread_local_posix.cc",
              "butil/threading/thread_local_storage.cc",
              "butil/threading/thread_local_storage_posix.cc",
              "butil/threading/thread_restrictions.cc",
              "butil/threading/watchdog.cc", "butil/time/clock.cc",
              "butil/time/default_clock.cc", "butil/time/default_tick_clock.cc",
              "butil/time/tick_clock.cc", "butil/time/time.cc",
              "butil/time/time_posix.cc", "butil/version.cc",
              "butil/logging.cc", "butil/class_name.cpp", "butil/errno.cpp",
              "butil/find_cstr.cpp", "butil/status.cpp",
              "butil/string_printf.cpp", "butil/thread_local.cpp",
              "butil/unix_socket.cpp", "butil/endpoint.cpp",
              "butil/fd_utility.cpp", "butil/files/temp_file.cpp",
              "butil/files/file_watcher.cpp", "butil/time.cpp",
              "butil/zero_copy_stream_as_streambuf.cpp", "butil/crc32c.cc",
              "butil/containers/case_ignored_flat_map.cpp", "butil/iobuf.cpp",
              "butil/binary_printer.cpp", "butil/recordio.cc", "butil/popen.cpp")
    if is_plat("linux") then
        add_files("butil/file_util_linux.cc",
                  "butil/threading/platform_thread_linux.cc",
                  "butil/strings/sys_string_conversions_posix.cc")
    end
end)

target("sources", function()
    set_kind("object")
    add_cxxflags("-Wno-error=nonnull", "-Wno-error=invalid-offsetof",
                 "-Wno-error=deprecated-declarations")
    add_files("bvar/*.cpp", "bthread/*.cpp", "json2pb/*.cpp", "brpc/*.cpp")
    remove_files("brpc/event_dispatcher_*.cpp")
    add_files("mcpack2pb/field_type.cpp", "mcpack2pb/mcpack2pb.cpp",
              "mcpack2pb/parser.cpp", "mcpack2pb/serializer.cpp")
    if has_config("with_thrift") then
        add_files("brpc/thrift*.cpp")
    end
    add_deps("brpc_proto")
end)
