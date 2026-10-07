; ModuleID = 'test_buggy.1ef1aff4e7ceeaf4-cgu.0'
source_filename = "test_buggy.1ef1aff4e7ceeaf4-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy }>, align 8, !dbg !0
@g_counter = global [4 x i8] zeroinitializer, align 4, !dbg !24
@__rustc_debug_gdb_scripts_section__ = linkonce_odr unnamed_addr constant [34 x i8] c"\01gdb_load_rust_pretty_printers.py\00", section ".debug_gdb_scripts", align 1

; std::rt::lang_start::<()>
; Function Attrs: nounwind nonlazybind uwtable
define hidden i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #0 !dbg !39 {
start:
  %sigpipe.dbg.spill = alloca [1 x i8], align 1
  %argv.dbg.spill = alloca [8 x i8], align 8
  %argc.dbg.spill = alloca [8 x i8], align 8
  %main.dbg.spill = alloca [8 x i8], align 8
  %_7 = alloca [8 x i8], align 8
  store ptr %main, ptr %main.dbg.spill, align 8
    #dbg_declare(ptr %main.dbg.spill, !48, !DIExpression(), !54)
  store i64 %argc, ptr %argc.dbg.spill, align 8
    #dbg_declare(ptr %argc.dbg.spill, !49, !DIExpression(), !55)
  store ptr %argv, ptr %argv.dbg.spill, align 8
    #dbg_declare(ptr %argv.dbg.spill, !50, !DIExpression(), !56)
  store i8 %sigpipe, ptr %sigpipe.dbg.spill, align 1
    #dbg_declare(ptr %sigpipe.dbg.spill, !51, !DIExpression(), !57)
  store ptr %main, ptr %_7, align 8, !dbg !58
; call std::rt::lang_start_internal
  %_0 = call i64 @_RNvNtCs6ZjlLoI6YmX_3std2rt19lang_start_internal(ptr %_7, ptr align 8 @vtable.0, i64 %argc, ptr %argv, i8 %sigpipe) #5, !dbg !59
  ret i64 %_0, !dbg !60
}

; std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy(ptr %f) unnamed_addr #1 !dbg !61 {
start:
  %dummy.dbg.spill = alloca [0 x i8], align 1
  %f.dbg.spill = alloca [8 x i8], align 8
  %result.dbg.spill = alloca [0 x i8], align 1
  %_2 = alloca [0 x i8], align 1
    #dbg_declare(ptr %result.dbg.spill, !69, !DIExpression(), !73)
  store ptr %f, ptr %f.dbg.spill, align 8
    #dbg_declare(ptr %f.dbg.spill, !68, !DIExpression(), !74)
    #dbg_declare(ptr %dummy.dbg.spill, !75, !DIExpression(), !83)
; call <fn() as core::ops::function::FnOnce<()>>::call_once
  call void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %f) #6, !dbg !85
  call void asm sideeffect "", "~{memory}"(), !dbg !86, !srcloc !87
  ret void, !dbg !88
}

; std::rt::lang_start::<()>::{closure#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy(ptr align 8 %_1) unnamed_addr #2 !dbg !89 {
start:
  %self.dbg.spill = alloca [1 x i8], align 1
  %_1.dbg.spill = alloca [8 x i8], align 8
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !94, !DIExpression(DW_OP_deref), !95)
  %_4 = load ptr, ptr %_1, align 8, !dbg !96
; call std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
  call void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy(ptr %_4) #7, !dbg !97
; call <() as std::process::Termination>::report
  %self = call i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy() #6, !dbg !98
  store i8 %self, ptr %self.dbg.spill, align 1, !dbg !98
    #dbg_declare(ptr %self.dbg.spill, !99, !DIExpression(), !116)
  %_0 = zext i8 %self to i32, !dbg !118
  ret i32 %_0, !dbg !126
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once::{shim:vtable#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy(ptr %_1) unnamed_addr #2 !dbg !127 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !136, !DIExpression(), !141)
    #dbg_declare(ptr %_2, !137, !DIExpression(), !141)
  %0 = load ptr, ptr %_1, align 8, !dbg !141
; call <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
  %_0 = call i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %0) #6, !dbg !141
  ret i32 %_0, !dbg !141
}

; test_buggy::main
; Function Attrs: nounwind nonlazybind uwtable
define hidden void @_RNvCs2EIjc6ZEoKu_10test_buggy4main() unnamed_addr #0 !dbg !142 {
start:
  %res.dbg.spill = alloca [4 x i8], align 4, !dbg !146
  %res = call i32 @caller_work(i32 1) #5, !dbg !146
  store i32 %res, ptr %res.dbg.spill, align 4, !dbg !146
    #dbg_declare(ptr %res.dbg.spill, !144, !DIExpression(), !147)
; call std::process::exit
  call void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32 %res) #8, !dbg !148
  unreachable, !dbg !148
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy() unnamed_addr #2 !dbg !149 {
start:
  %_1.dbg.spill = alloca [0 x i8], align 1
    #dbg_declare(ptr %_1.dbg.spill, !154, !DIExpression(), !155)
  ret i8 0, !dbg !156
}

; <fn() as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %_1) unnamed_addr #2 !dbg !157 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !159, !DIExpression(), !163)
    #dbg_declare(ptr %_2, !160, !DIExpression(), !163)
  call void %_1() #5, !dbg !163
  ret void, !dbg !163
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %0) unnamed_addr #2 !dbg !164 {
start:
  %_2 = alloca [0 x i8], align 1
  %_1 = alloca [8 x i8], align 8
  store ptr %0, ptr %_1, align 8
    #dbg_declare(ptr %_1, !168, !DIExpression(), !170)
    #dbg_declare(ptr %_2, !169, !DIExpression(), !170)
; call std::rt::lang_start::<()>::{closure#0}
  %_0 = call i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy(ptr align 8 %_1) #6, !dbg !170
  ret i32 %_0, !dbg !170
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @caller_work(i32 %x) unnamed_addr #0 !dbg !171 {
start:
  %x.dbg.spill = alloca [4 x i8], align 4
  store i32 %x, ptr %x.dbg.spill, align 4
    #dbg_declare(ptr %x.dbg.spill, !175, !DIExpression(), !176)
  %_2 = mul i32 %x, 2, !dbg !177
  %_0 = call i32 @helper_inc(i32 %_2) #5, !dbg !178
  ret i32 %_0, !dbg !179
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @helper_inc(i32 %val) unnamed_addr #0 !dbg !180 {
start:
  %val.dbg.spill = alloca [4 x i8], align 4
  %local_counter = alloca [4 x i8], align 4
  store i32 %val, ptr %val.dbg.spill, align 4
    #dbg_declare(ptr %val.dbg.spill, !182, !DIExpression(), !185)
    #dbg_declare(ptr %local_counter, !183, !DIExpression(), !186)
  store i32 0, ptr %local_counter, align 4, !dbg !187
  %0 = load i32, ptr %local_counter, align 4, !dbg !188
  %1 = add i32 %0, %val, !dbg !188
  store i32 %1, ptr %local_counter, align 4, !dbg !188
  %_0 = load i32, ptr %local_counter, align 4, !dbg !189
  ret i32 %_0, !dbg !190
}

; std::rt::lang_start_internal
; Function Attrs: nounwind nonlazybind uwtable
declare i64 @_RNvNtCs6ZjlLoI6YmX_3std2rt19lang_start_internal(ptr, ptr align 8, i64, ptr, i8) unnamed_addr #0

; std::process::exit
; Function Attrs: noreturn nounwind nonlazybind uwtable
declare void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32) unnamed_addr #3

; Function Attrs: nonlazybind
define i32 @main(i32 %0, ptr %1) unnamed_addr #4 {
top:
  %2 = load volatile i8, ptr @__rustc_debug_gdb_scripts_section__, align 1
  %3 = sext i32 %0 to i64
; call std::rt::lang_start::<()>
  %4 = call i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy(ptr @_RNvCs2EIjc6ZEoKu_10test_buggy4main, i64 %3, ptr %1, i8 0)
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

attributes #0 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { noinline nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { inlinehint nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { noreturn nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #4 = { nonlazybind "target-cpu"="x86-64" }
attributes #5 = { nounwind }
attributes #6 = { inlinehint nounwind }
attributes #7 = { noinline nounwind }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!29, !30, !31, !32, !33, !34}
!llvm.ident = !{!35}
!llvm.dbg.cu = !{!36}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "<std::rt::lang_start::{closure_env#0}<()> as core::ops::function::Fn<()>>::{vtable}", scope: null, file: !2, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "<unknown>", directory: "")
!3 = !DICompositeType(tag: DW_TAG_structure_type, name: "<std::rt::lang_start::{closure_env#0}<()> as core::ops::function::Fn<()>>::{vtable_type}", file: !2, size: 384, align: 64, flags: DIFlagArtificial, elements: !4, vtableHolder: !14, templateParams: !23, identifier: "6c4125b74fdd7c2599fe3bc0bd2d6a6e")
!4 = !{!5, !8, !10, !11, !12, !13}
!5 = !DIDerivedType(tag: DW_TAG_member, name: "drop_in_place", scope: !3, file: !2, baseType: !6, size: 64, align: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const ()", baseType: !7, size: 64, align: 64, dwarfAddressSpace: 0)
!7 = !DIBasicType(name: "()", encoding: DW_ATE_unsigned)
!8 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !3, file: !2, baseType: !9, size: 64, align: 64, offset: 64)
!9 = !DIBasicType(name: "usize", size: 64, encoding: DW_ATE_unsigned)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "align", scope: !3, file: !2, baseType: !9, size: 64, align: 64, offset: 128)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "__method3", scope: !3, file: !2, baseType: !6, size: 64, align: 64, offset: 192)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "__method4", scope: !3, file: !2, baseType: !6, size: 64, align: 64, offset: 256)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "__method5", scope: !3, file: !2, baseType: !6, size: 64, align: 64, offset: 320)
!14 = !DICompositeType(tag: DW_TAG_structure_type, name: "{closure_env#0}<()>", scope: !15, file: !2, size: 64, align: 64, elements: !18, templateParams: !23, identifier: "e5cda4c567ea2be9b3035ffdc936ac82")
!15 = !DINamespace(name: "lang_start", scope: !16)
!16 = !DINamespace(name: "rt", scope: !17)
!17 = !DINamespace(name: "std", scope: null)
!18 = !{!19}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "main", scope: !14, file: !2, baseType: !20, size: 64, align: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "fn()", baseType: !21, size: 64, align: 64, dwarfAddressSpace: 0)
!21 = !DISubroutineType(types: !22)
!22 = !{null}
!23 = !{}
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(name: "g_counter", scope: !26, file: !27, line: 2, type: !28, isLocal: false, isDefinition: true, align: 32)
!26 = !DINamespace(name: "test_buggy", scope: null)
!27 = !DIFile(filename: "tests2/global_state/test_buggy.rs", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "83731e2cdd1773605472ddf10b5addb0")
!28 = !DIBasicType(name: "i32", size: 32, encoding: DW_ATE_signed)
!29 = !{i32 8, !"PIC Level", i32 2}
!30 = !{i32 7, !"PIE Level", i32 2}
!31 = !{i32 2, !"RtLibUseGOT", i32 1}
!32 = !{i32 7, !"uwtable", i32 2}
!33 = !{i32 7, !"Dwarf Version", i32 4}
!34 = !{i32 2, !"Debug Info Version", i32 3}
!35 = !{!"rustc version 1.98.0 (88d9e12ae 2026-08-18)"}
!36 = distinct !DICompileUnit(language: DW_LANG_Rust, file: !37, producer: "clang LLVM (rustc version 1.98.0 (88d9e12ae 2026-08-18))", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !38, splitDebugInlining: false, nameTableKind: None)
!37 = !DIFile(filename: "tests2/global_state/test_buggy.rs/@/test_buggy.1ef1aff4e7ceeaf4-cgu.0", directory: "/home/hari/rustsketch")
!38 = !{!0, !24}
!39 = distinct !DISubprogram(name: "lang_start<()>", linkageName: "_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy", scope: !16, file: !40, line: 199, type: !41, scopeLine: 199, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !52, retainedNodes: !47)
!40 = !DIFile(filename: "library/std/src/rt.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "83eadca7bec2ebce94abb46f51902baa")
!41 = !DISubroutineType(types: !42)
!42 = !{!43, !20, !43, !44, !46}
!43 = !DIBasicType(name: "isize", size: 64, encoding: DW_ATE_signed)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const *const u8", baseType: !45, size: 64, align: 64, dwarfAddressSpace: 0)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const u8", baseType: !46, size: 64, align: 64, dwarfAddressSpace: 0)
!46 = !DIBasicType(name: "u8", size: 8, encoding: DW_ATE_unsigned)
!47 = !{!48, !49, !50, !51}
!48 = !DILocalVariable(name: "main", arg: 1, scope: !39, file: !40, line: 200, type: !20)
!49 = !DILocalVariable(name: "argc", arg: 2, scope: !39, file: !40, line: 201, type: !43)
!50 = !DILocalVariable(name: "argv", arg: 3, scope: !39, file: !40, line: 202, type: !44)
!51 = !DILocalVariable(name: "sigpipe", arg: 4, scope: !39, file: !40, line: 203, type: !46)
!52 = !{!53}
!53 = !DITemplateTypeParameter(name: "T", type: !7)
!54 = !DILocation(line: 200, column: 5, scope: !39)
!55 = !DILocation(line: 201, column: 5, scope: !39)
!56 = !DILocation(line: 202, column: 5, scope: !39)
!57 = !DILocation(line: 203, column: 5, scope: !39)
!58 = !DILocation(line: 206, column: 10, scope: !39)
!59 = !DILocation(line: 205, column: 5, scope: !39)
!60 = !DILocation(line: 211, column: 2, scope: !39)
!61 = distinct !DISubprogram(name: "__rust_begin_short_backtrace<fn(), ()>", linkageName: "_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy", scope: !63, file: !62, line: 162, type: !65, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !71, retainedNodes: !67)
!62 = !DIFile(filename: "library/std/src/sys/backtrace.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "0469076862be40bd9e65965440a24fae")
!63 = !DINamespace(name: "backtrace", scope: !64)
!64 = !DINamespace(name: "sys", scope: !17)
!65 = !DISubroutineType(types: !66)
!66 = !{null, !20}
!67 = !{!68, !69}
!68 = !DILocalVariable(name: "f", arg: 1, scope: !61, file: !62, line: 162, type: !20)
!69 = !DILocalVariable(name: "result", scope: !70, file: !62, line: 166, type: !7, align: 8)
!70 = distinct !DILexicalBlock(scope: !61, file: !62, line: 166, column: 5)
!71 = !{!72, !53}
!72 = !DITemplateTypeParameter(name: "F", type: !20)
!73 = !DILocation(line: 166, column: 9, scope: !70)
!74 = !DILocation(line: 162, column: 43, scope: !61)
!75 = !DILocalVariable(name: "dummy", scope: !76, file: !77, line: 490, type: !7, align: 8)
!76 = distinct !DISubprogram(name: "black_box<()>", linkageName: "_RINvNtCsc36rpYXAlPq_4core4hint9black_boxuECs2EIjc6ZEoKu_10test_buggy", scope: !78, file: !77, line: 490, type: !80, scopeLine: 490, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !52, retainedNodes: !82)
!77 = !DIFile(filename: "library/core/src/hint.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "720ecb12dbf1a304509abd161627e0e2")
!78 = !DINamespace(name: "hint", scope: !79)
!79 = !DINamespace(name: "core", scope: null)
!80 = !DISubroutineType(types: !81)
!81 = !{null, !7}
!82 = !{!75}
!83 = !DILocation(line: 490, column: 27, scope: !76, inlinedAt: !84)
!84 = !DILocation(line: 169, column: 5, scope: !70)
!85 = !DILocation(line: 166, column: 18, scope: !61)
!86 = !DILocation(line: 491, column: 5, scope: !76, inlinedAt: !84)
!87 = !{i64 2769622546372306}
!88 = !DILocation(line: 172, column: 2, scope: !61)
!89 = distinct !DISubprogram(name: "{closure#0}<()>", linkageName: "_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy", scope: !15, file: !40, line: 206, type: !90, scopeLine: 206, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !52, retainedNodes: !93)
!90 = !DISubroutineType(types: !91)
!91 = !{!28, !92}
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "&std::rt::lang_start::{closure_env#0}<()>", baseType: !14, size: 64, align: 64, dwarfAddressSpace: 0)
!93 = !{!94}
!94 = !DILocalVariable(name: "main", scope: !89, file: !40, line: 200, type: !20, align: 64)
!95 = !DILocation(line: 200, column: 5, scope: !89)
!96 = !DILocation(line: 206, column: 70, scope: !89)
!97 = !DILocation(line: 206, column: 18, scope: !89)
!98 = !DILocation(line: 206, column: 76, scope: !89)
!99 = !DILocalVariable(name: "self", arg: 1, scope: !100, file: !101, line: 2288, type: !102)
!100 = distinct !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !102, file: !101, line: 2288, type: !112, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !23, declaration: !114, retainedNodes: !115)
!101 = !DIFile(filename: "library/std/src/process.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "aa32a342ec19ed053728e871b78cbd51")
!102 = !DICompositeType(tag: DW_TAG_structure_type, name: "ExitCode", scope: !103, file: !2, size: 8, align: 8, flags: DIFlagPublic, elements: !104, templateParams: !23, identifier: "3cfa8e06f75b7ee66a1bab77ba921190")
!103 = !DINamespace(name: "process", scope: !17)
!104 = !{!105}
!105 = !DIDerivedType(tag: DW_TAG_member, name: "__0", scope: !102, file: !2, baseType: !106, size: 8, align: 8, flags: DIFlagPrivate)
!106 = !DICompositeType(tag: DW_TAG_structure_type, name: "ExitCode", scope: !107, file: !2, size: 8, align: 8, flags: DIFlagPublic, elements: !110, templateParams: !23, identifier: "82a6be3bfebff0b0ddaaa657e9698005")
!107 = !DINamespace(name: "common", scope: !108)
!108 = !DINamespace(name: "unix", scope: !109)
!109 = !DINamespace(name: "process", scope: !64)
!110 = !{!111}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "__0", scope: !106, file: !2, baseType: !46, size: 8, align: 8, flags: DIFlagPrivate)
!112 = !DISubroutineType(types: !113)
!113 = !{!28, !102}
!114 = !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !102, file: !101, line: 2288, type: !112, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!115 = !{!99}
!116 = !DILocation(line: 2288, column: 19, scope: !100, inlinedAt: !117)
!117 = !DILocation(line: 206, column: 85, scope: !89)
!118 = !DILocation(line: 592, column: 9, scope: !119, inlinedAt: !125)
!119 = distinct !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !106, file: !120, line: 591, type: !121, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !23, declaration: !124)
!120 = !DIFile(filename: "library/std/src/sys/process/unix/common.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "9ce13a63119e878727d165dd623553d1")
!121 = !DISubroutineType(types: !122)
!122 = !{!28, !123}
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "&std::sys::process::unix::common::ExitCode", baseType: !106, size: 64, align: 64, dwarfAddressSpace: 0)
!124 = !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !106, file: !120, line: 591, type: !121, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!125 = !DILocation(line: 2289, column: 16, scope: !100, inlinedAt: !117)
!126 = !DILocation(line: 206, column: 93, scope: !89)
!127 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy", scope: !129, file: !128, line: 250, type: !132, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !138, retainedNodes: !135)
!128 = !DIFile(filename: "library/core/src/ops/function.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "ae01f833f82cd27aa916c99d95502941")
!129 = !DINamespace(name: "FnOnce", scope: !130)
!130 = !DINamespace(name: "function", scope: !131)
!131 = !DINamespace(name: "ops", scope: !79)
!132 = !DISubroutineType(types: !133)
!133 = !{!28, !134}
!134 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut std::rt::lang_start::{closure_env#0}<()>", baseType: !14, size: 64, align: 64, dwarfAddressSpace: 0)
!135 = !{!136, !137}
!136 = !DILocalVariable(arg: 1, scope: !127, file: !128, line: 250, type: !134)
!137 = !DILocalVariable(arg: 2, scope: !127, file: !128, line: 250, type: !7)
!138 = !{!139, !140}
!139 = !DITemplateTypeParameter(name: "Self", type: !14)
!140 = !DITemplateTypeParameter(name: "Args", type: !7)
!141 = !DILocation(line: 250, column: 5, scope: !127)
!142 = distinct !DISubprogram(name: "main", linkageName: "_RNvCs2EIjc6ZEoKu_10test_buggy4main", scope: !26, file: !27, line: 17, type: !21, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagMainSubprogram, unit: !36, templateParams: !23, retainedNodes: !143)
!143 = !{!144}
!144 = !DILocalVariable(name: "res", scope: !145, file: !27, line: 18, type: !28, align: 32)
!145 = distinct !DILexicalBlock(scope: !142, file: !27, line: 18, column: 5)
!146 = !DILocation(line: 18, column: 15, scope: !142)
!147 = !DILocation(line: 18, column: 9, scope: !145)
!148 = !DILocation(line: 19, column: 5, scope: !145)
!149 = distinct !DISubprogram(name: "report", linkageName: "_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy", scope: !150, file: !101, line: 2690, type: !151, scopeLine: 2690, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !23, retainedNodes: !153)
!150 = !DINamespace(name: "{impl#58}", scope: !103)
!151 = !DISubroutineType(types: !152)
!152 = !{!102, !7}
!153 = !{!154}
!154 = !DILocalVariable(arg: 1, scope: !149, file: !101, line: 2690, type: !7)
!155 = !DILocation(line: 2690, column: 15, scope: !149)
!156 = !DILocation(line: 2692, column: 6, scope: !149)
!157 = distinct !DISubprogram(name: "call_once<fn(), ()>", linkageName: "_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !129, file: !128, line: 250, type: !65, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !161, retainedNodes: !158)
!158 = !{!159, !160}
!159 = !DILocalVariable(arg: 1, scope: !157, file: !128, line: 250, type: !20)
!160 = !DILocalVariable(arg: 2, scope: !157, file: !128, line: 250, type: !7)
!161 = !{!162, !140}
!162 = !DITemplateTypeParameter(name: "Self", type: !20)
!163 = !DILocation(line: 250, column: 5, scope: !157)
!164 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !129, file: !128, line: 250, type: !165, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !36, templateParams: !138, retainedNodes: !167)
!165 = !DISubroutineType(types: !166)
!166 = !{!28, !14}
!167 = !{!168, !169}
!168 = !DILocalVariable(arg: 1, scope: !164, file: !128, line: 250, type: !14)
!169 = !DILocalVariable(arg: 2, scope: !164, file: !128, line: 250, type: !7)
!170 = !DILocation(line: 250, column: 5, scope: !164)
!171 = distinct !DISubprogram(name: "caller_work", scope: !26, file: !27, line: 13, type: !172, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !36, templateParams: !23, retainedNodes: !174)
!172 = !DISubroutineType(types: !173)
!173 = !{!28, !28}
!174 = !{!175}
!175 = !DILocalVariable(name: "x", arg: 1, scope: !171, file: !27, line: 13, type: !28)
!176 = !DILocation(line: 13, column: 31, scope: !171)
!177 = !DILocation(line: 14, column: 16, scope: !171)
!178 = !DILocation(line: 14, column: 5, scope: !171)
!179 = !DILocation(line: 15, column: 2, scope: !171)
!180 = distinct !DISubprogram(name: "helper_inc", scope: !26, file: !27, line: 5, type: !172, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !36, templateParams: !23, retainedNodes: !181)
!181 = !{!182, !183}
!182 = !DILocalVariable(name: "val", arg: 1, scope: !180, file: !27, line: 5, type: !28)
!183 = !DILocalVariable(name: "local_counter", scope: !184, file: !27, line: 7, type: !28, align: 32)
!184 = distinct !DILexicalBlock(scope: !180, file: !27, line: 7, column: 5)
!185 = !DILocation(line: 5, column: 30, scope: !180)
!186 = !DILocation(line: 7, column: 9, scope: !184)
!187 = !DILocation(line: 7, column: 29, scope: !180)
!188 = !DILocation(line: 8, column: 5, scope: !184)
!189 = !DILocation(line: 9, column: 5, scope: !184)
!190 = !DILocation(line: 10, column: 2, scope: !180)
