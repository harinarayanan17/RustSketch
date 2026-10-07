; ModuleID = 'test_correct.6bc1b2bb50fcbf7e-cgu.0'
source_filename = "test_correct.6bc1b2bb50fcbf7e-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs9fAkHImeXCI_12test_correct, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs9fAkHImeXCI_12test_correct, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs9fAkHImeXCI_12test_correct }>, align 8, !dbg !0
@alloc_8c7fa9ddc4ec35d578a789fcd3a17597 = private unnamed_addr constant [35 x i8] c"tests2/composition/test_correct.rs\00", align 1
@alloc_5f0621eb4cdc85c9ba23c98d2378a6f6 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_8c7fa9ddc4ec35d578a789fcd3a17597, [16 x i8] c"\22\00\00\00\00\00\00\00\0D\00\00\00\0E\00\00\00" }>, align 8
@alloc_036113b4a70146da8b8290cfdf2227a8 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_8c7fa9ddc4ec35d578a789fcd3a17597, [16 x i8] c"\22\00\00\00\00\00\00\00\0D\00\00\00\05\00\00\00" }>, align 8
@__rustc_debug_gdb_scripts_section__ = linkonce_odr unnamed_addr constant [34 x i8] c"\01gdb_load_rust_pretty_printers.py\00", section ".debug_gdb_scripts", align 1

; std::rt::lang_start::<()>
; Function Attrs: nounwind nonlazybind uwtable
define hidden i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs9fAkHImeXCI_12test_correct(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #0 !dbg !34 {
start:
  %sigpipe.dbg.spill = alloca [1 x i8], align 1
  %argv.dbg.spill = alloca [8 x i8], align 8
  %argc.dbg.spill = alloca [8 x i8], align 8
  %main.dbg.spill = alloca [8 x i8], align 8
  %_7 = alloca [8 x i8], align 8
  store ptr %main, ptr %main.dbg.spill, align 8
    #dbg_declare(ptr %main.dbg.spill, !43, !DIExpression(), !49)
  store i64 %argc, ptr %argc.dbg.spill, align 8
    #dbg_declare(ptr %argc.dbg.spill, !44, !DIExpression(), !50)
  store ptr %argv, ptr %argv.dbg.spill, align 8
    #dbg_declare(ptr %argv.dbg.spill, !45, !DIExpression(), !51)
  store i8 %sigpipe, ptr %sigpipe.dbg.spill, align 1
    #dbg_declare(ptr %sigpipe.dbg.spill, !46, !DIExpression(), !52)
  store ptr %main, ptr %_7, align 8, !dbg !53
; call std::rt::lang_start_internal
  %_0 = call i64 @_RNvNtCs6ZjlLoI6YmX_3std2rt19lang_start_internal(ptr %_7, ptr align 8 @vtable.0, i64 %argc, ptr %argv, i8 %sigpipe) #6, !dbg !54
  ret i64 %_0, !dbg !55
}

; std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
; Function Attrs: noinline nounwind nonlazybind uwtable
define internal void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs9fAkHImeXCI_12test_correct(ptr %f) unnamed_addr #1 !dbg !56 {
start:
  %dummy.dbg.spill = alloca [0 x i8], align 1
  %f.dbg.spill = alloca [8 x i8], align 8
  %result.dbg.spill = alloca [0 x i8], align 1
  %_2 = alloca [0 x i8], align 1
    #dbg_declare(ptr %result.dbg.spill, !64, !DIExpression(), !68)
  store ptr %f, ptr %f.dbg.spill, align 8
    #dbg_declare(ptr %f.dbg.spill, !63, !DIExpression(), !69)
    #dbg_declare(ptr %dummy.dbg.spill, !70, !DIExpression(), !78)
; call <fn() as core::ops::function::FnOnce<()>>::call_once
  call void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct(ptr %f) #7, !dbg !80
  call void asm sideeffect "", "~{memory}"(), !dbg !81, !srcloc !82
  ret void, !dbg !83
}

; std::rt::lang_start::<()>::{closure#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs9fAkHImeXCI_12test_correct(ptr align 8 %_1) unnamed_addr #2 !dbg !84 {
start:
  %self.dbg.spill = alloca [1 x i8], align 1
  %_1.dbg.spill = alloca [8 x i8], align 8
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !90, !DIExpression(DW_OP_deref), !91)
  %_4 = load ptr, ptr %_1, align 8, !dbg !92
; call std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
  call void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs9fAkHImeXCI_12test_correct(ptr %_4) #8, !dbg !93
; call <() as std::process::Termination>::report
  %self = call i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs9fAkHImeXCI_12test_correct() #7, !dbg !94
  store i8 %self, ptr %self.dbg.spill, align 1, !dbg !94
    #dbg_declare(ptr %self.dbg.spill, !95, !DIExpression(), !112)
  %_0 = zext i8 %self to i32, !dbg !114
  ret i32 %_0, !dbg !122
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once::{shim:vtable#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs9fAkHImeXCI_12test_correct(ptr %_1) unnamed_addr #2 !dbg !123 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !132, !DIExpression(), !137)
    #dbg_declare(ptr %_2, !133, !DIExpression(), !137)
  %0 = load ptr, ptr %_1, align 8, !dbg !137
; call <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
  %_0 = call i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct(ptr %0) #7, !dbg !137
  ret i32 %_0, !dbg !137
}

; test_correct::main
; Function Attrs: nounwind nonlazybind uwtable
define hidden void @_RNvCs9fAkHImeXCI_12test_correct4main() unnamed_addr #0 !dbg !138 {
start:
  %r.dbg.spill = alloca [4 x i8], align 4, !dbg !144
  %r = call i32 @caller_pipeline(i32 10, i32 5) #6, !dbg !144
  store i32 %r, ptr %r.dbg.spill, align 4, !dbg !144
    #dbg_declare(ptr %r.dbg.spill, !142, !DIExpression(), !145)
; call std::process::exit
  call void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32 %r) #9, !dbg !146
  unreachable, !dbg !146
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs9fAkHImeXCI_12test_correct() unnamed_addr #2 !dbg !147 {
start:
  %_1.dbg.spill = alloca [0 x i8], align 1
    #dbg_declare(ptr %_1.dbg.spill, !152, !DIExpression(), !153)
  ret i8 0, !dbg !154
}

; <fn() as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct(ptr %_1) unnamed_addr #2 !dbg !155 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !157, !DIExpression(), !161)
    #dbg_declare(ptr %_2, !158, !DIExpression(), !161)
  call void %_1() #6, !dbg !161
  ret void, !dbg !161
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct(ptr %0) unnamed_addr #2 !dbg !162 {
start:
  %_2 = alloca [0 x i8], align 1
  %_1 = alloca [8 x i8], align 8
  store ptr %0, ptr %_1, align 8
    #dbg_declare(ptr %_1, !166, !DIExpression(), !168)
    #dbg_declare(ptr %_2, !167, !DIExpression(), !168)
; call std::rt::lang_start::<()>::{closure#0}
  %_0 = call i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs9fAkHImeXCI_12test_correct(ptr align 8 %_1) #7, !dbg !168
  ret i32 %_0, !dbg !168
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @caller_pipeline(i32 %input, i32 %factor) unnamed_addr #0 !dbg !169 {
start:
  %s2.dbg.spill = alloca [4 x i8], align 4
  %s1.dbg.spill = alloca [4 x i8], align 4
  %factor.dbg.spill = alloca [4 x i8], align 4
  %input.dbg.spill = alloca [4 x i8], align 4
  %res = alloca [4 x i8], align 4
  store i32 %input, ptr %input.dbg.spill, align 4
    #dbg_declare(ptr %input.dbg.spill, !173, !DIExpression(), !181)
  store i32 %factor, ptr %factor.dbg.spill, align 4
    #dbg_declare(ptr %factor.dbg.spill, !174, !DIExpression(), !182)
    #dbg_declare(ptr %res, !179, !DIExpression(), !183)
  %s1 = call i32 @helper_step1(i32 %input) #6, !dbg !184
  store i32 %s1, ptr %s1.dbg.spill, align 4, !dbg !184
    #dbg_declare(ptr %s1.dbg.spill, !175, !DIExpression(), !185)
  %s2 = call i32 @helper_step2(i32 %s1) #6, !dbg !186
  store i32 %s2, ptr %s2.dbg.spill, align 4, !dbg !186
    #dbg_declare(ptr %s2.dbg.spill, !177, !DIExpression(), !187)
  store i32 %s2, ptr %res, align 4, !dbg !188
  call void @helper_step3(ptr %res, i32 %factor) #6, !dbg !189
  %_0 = load i32, ptr %res, align 4, !dbg !190
  ret i32 %_0, !dbg !191
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @helper_step1(i32 %a) unnamed_addr #0 !dbg !192 {
start:
  %a.dbg.spill = alloca [4 x i8], align 4
  store i32 %a, ptr %a.dbg.spill, align 4
    #dbg_declare(ptr %a.dbg.spill, !196, !DIExpression(), !197)
  %_2 = mul i32 %a, 2, !dbg !198
  %_0 = add i32 %_2, 3, !dbg !198
  ret i32 %_0, !dbg !199
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @helper_step2(i32 %b) unnamed_addr #0 !dbg !200 {
start:
  %b.dbg.spill = alloca [4 x i8], align 4
  store i32 %b, ptr %b.dbg.spill, align 4
    #dbg_declare(ptr %b.dbg.spill, !202, !DIExpression(), !203)
  %_0 = xor i32 %b, 15, !dbg !204
  ret i32 %_0, !dbg !205
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local void @helper_step3(ptr %state, i32 %factor) unnamed_addr #0 !dbg !206 {
start:
  %factor.dbg.spill = alloca [4 x i8], align 4
  %state.dbg.spill = alloca [8 x i8], align 8
  store ptr %state, ptr %state.dbg.spill, align 8
    #dbg_declare(ptr %state.dbg.spill, !211, !DIExpression(), !213)
  store i32 %factor, ptr %factor.dbg.spill, align 4
    #dbg_declare(ptr %factor.dbg.spill, !212, !DIExpression(), !214)
  %_10 = ptrtoint ptr %state to i64, !dbg !215
  %_12 = and i64 %_10, 3, !dbg !215
  %_13 = icmp eq i64 %_12, 0, !dbg !215
  br i1 %_13, label %bb2, label %panic, !dbg !215

bb2:                                              ; preds = %start
  %_15 = ptrtoint ptr %state to i64, !dbg !215
  %_17 = icmp eq i64 %_15, 0, !dbg !215
  %_18 = and i1 %_17, true, !dbg !215
  %_19 = xor i1 %_18, true, !dbg !215
  br i1 %_19, label %bb3, label %panic1, !dbg !215

panic:                                            ; preds = %start
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_10, ptr align 8 @alloc_5f0621eb4cdc85c9ba23c98d2378a6f6) #10, !dbg !215
  unreachable, !dbg !215

bb3:                                              ; preds = %bb2
  %_3 = load i32, ptr %state, align 4, !dbg !215
  %_5 = ptrtoint ptr %state to i64, !dbg !216
  %_7 = and i64 %_5, 3, !dbg !216
  %_8 = icmp eq i64 %_7, 0, !dbg !216
  br i1 %_8, label %bb1, label %panic2, !dbg !216

panic1:                                           ; preds = %bb2
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_5f0621eb4cdc85c9ba23c98d2378a6f6) #10, !dbg !215
  unreachable, !dbg !215

bb1:                                              ; preds = %bb3
  %_21 = ptrtoint ptr %state to i64, !dbg !216
  %_23 = icmp eq i64 %_21, 0, !dbg !216
  %_24 = and i1 %_23, true, !dbg !216
  %_25 = xor i1 %_24, true, !dbg !216
  br i1 %_25, label %bb4, label %panic3, !dbg !216

panic2:                                           ; preds = %bb3
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_5, ptr align 8 @alloc_036113b4a70146da8b8290cfdf2227a8) #10, !dbg !216
  unreachable, !dbg !216

bb4:                                              ; preds = %bb1
  %0 = add i32 %_3, %factor, !dbg !216
  store i32 %0, ptr %state, align 4, !dbg !216
  ret void, !dbg !217

panic3:                                           ; preds = %bb1
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_036113b4a70146da8b8290cfdf2227a8) #10, !dbg !216
  unreachable, !dbg !216
}

; std::rt::lang_start_internal
; Function Attrs: nounwind nonlazybind uwtable
declare i64 @_RNvNtCs6ZjlLoI6YmX_3std2rt19lang_start_internal(ptr, ptr align 8, i64, ptr, i8) unnamed_addr #0

; std::process::exit
; Function Attrs: noreturn nounwind nonlazybind uwtable
declare void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32) unnamed_addr #3

; core::panicking::panic_misaligned_pointer_dereference
; Function Attrs: cold minsize noinline noreturn nounwind nonlazybind optsize uwtable
declare void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64, i64, ptr align 8) unnamed_addr #4

; core::panicking::panic_null_pointer_dereference
; Function Attrs: cold minsize noinline noreturn nounwind nonlazybind optsize uwtable
declare void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8) unnamed_addr #4

; Function Attrs: nonlazybind
define i32 @main(i32 %0, ptr %1) unnamed_addr #5 {
top:
  %2 = load volatile i8, ptr @__rustc_debug_gdb_scripts_section__, align 1
  %3 = sext i32 %0 to i64
; call std::rt::lang_start::<()>
  %4 = call i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs9fAkHImeXCI_12test_correct(ptr @_RNvCs9fAkHImeXCI_12test_correct4main, i64 %3, ptr %1, i8 0)
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

attributes #0 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { noinline nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { inlinehint nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { noreturn nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #4 = { cold minsize noinline noreturn nounwind nonlazybind optsize uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #5 = { nonlazybind "target-cpu"="x86-64" }
attributes #6 = { nounwind }
attributes #7 = { inlinehint nounwind }
attributes #8 = { noinline nounwind }
attributes #9 = { noreturn nounwind }
attributes #10 = { noinline noreturn nounwind }

!llvm.module.flags = !{!24, !25, !26, !27, !28, !29}
!llvm.ident = !{!30}
!llvm.dbg.cu = !{!31}

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
!24 = !{i32 8, !"PIC Level", i32 2}
!25 = !{i32 7, !"PIE Level", i32 2}
!26 = !{i32 2, !"RtLibUseGOT", i32 1}
!27 = !{i32 7, !"uwtable", i32 2}
!28 = !{i32 7, !"Dwarf Version", i32 4}
!29 = !{i32 2, !"Debug Info Version", i32 3}
!30 = !{!"rustc version 1.98.0 (88d9e12ae 2026-08-18)"}
!31 = distinct !DICompileUnit(language: DW_LANG_Rust, file: !32, producer: "clang LLVM (rustc version 1.98.0 (88d9e12ae 2026-08-18))", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !33, splitDebugInlining: false, nameTableKind: None)
!32 = !DIFile(filename: "tests2/composition/test_correct.rs/@/test_correct.6bc1b2bb50fcbf7e-cgu.0", directory: "/home/hari/rustsketch")
!33 = !{!0}
!34 = distinct !DISubprogram(name: "lang_start<()>", linkageName: "_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs9fAkHImeXCI_12test_correct", scope: !16, file: !35, line: 199, type: !36, scopeLine: 199, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !42)
!35 = !DIFile(filename: "library/std/src/rt.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "83eadca7bec2ebce94abb46f51902baa")
!36 = !DISubroutineType(types: !37)
!37 = !{!38, !20, !38, !39, !41}
!38 = !DIBasicType(name: "isize", size: 64, encoding: DW_ATE_signed)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const *const u8", baseType: !40, size: 64, align: 64, dwarfAddressSpace: 0)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const u8", baseType: !41, size: 64, align: 64, dwarfAddressSpace: 0)
!41 = !DIBasicType(name: "u8", size: 8, encoding: DW_ATE_unsigned)
!42 = !{!43, !44, !45, !46}
!43 = !DILocalVariable(name: "main", arg: 1, scope: !34, file: !35, line: 200, type: !20)
!44 = !DILocalVariable(name: "argc", arg: 2, scope: !34, file: !35, line: 201, type: !38)
!45 = !DILocalVariable(name: "argv", arg: 3, scope: !34, file: !35, line: 202, type: !39)
!46 = !DILocalVariable(name: "sigpipe", arg: 4, scope: !34, file: !35, line: 203, type: !41)
!47 = !{!48}
!48 = !DITemplateTypeParameter(name: "T", type: !7)
!49 = !DILocation(line: 200, column: 5, scope: !34)
!50 = !DILocation(line: 201, column: 5, scope: !34)
!51 = !DILocation(line: 202, column: 5, scope: !34)
!52 = !DILocation(line: 203, column: 5, scope: !34)
!53 = !DILocation(line: 206, column: 10, scope: !34)
!54 = !DILocation(line: 205, column: 5, scope: !34)
!55 = !DILocation(line: 211, column: 2, scope: !34)
!56 = distinct !DISubprogram(name: "__rust_begin_short_backtrace<fn(), ()>", linkageName: "_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs9fAkHImeXCI_12test_correct", scope: !58, file: !57, line: 162, type: !60, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !66, retainedNodes: !62)
!57 = !DIFile(filename: "library/std/src/sys/backtrace.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "0469076862be40bd9e65965440a24fae")
!58 = !DINamespace(name: "backtrace", scope: !59)
!59 = !DINamespace(name: "sys", scope: !17)
!60 = !DISubroutineType(types: !61)
!61 = !{null, !20}
!62 = !{!63, !64}
!63 = !DILocalVariable(name: "f", arg: 1, scope: !56, file: !57, line: 162, type: !20)
!64 = !DILocalVariable(name: "result", scope: !65, file: !57, line: 166, type: !7, align: 8)
!65 = distinct !DILexicalBlock(scope: !56, file: !57, line: 166, column: 5)
!66 = !{!67, !48}
!67 = !DITemplateTypeParameter(name: "F", type: !20)
!68 = !DILocation(line: 166, column: 9, scope: !65)
!69 = !DILocation(line: 162, column: 43, scope: !56)
!70 = !DILocalVariable(name: "dummy", scope: !71, file: !72, line: 490, type: !7, align: 8)
!71 = distinct !DISubprogram(name: "black_box<()>", linkageName: "_RINvNtCsc36rpYXAlPq_4core4hint9black_boxuECs9fAkHImeXCI_12test_correct", scope: !73, file: !72, line: 490, type: !75, scopeLine: 490, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !77)
!72 = !DIFile(filename: "library/core/src/hint.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "720ecb12dbf1a304509abd161627e0e2")
!73 = !DINamespace(name: "hint", scope: !74)
!74 = !DINamespace(name: "core", scope: null)
!75 = !DISubroutineType(types: !76)
!76 = !{null, !7}
!77 = !{!70}
!78 = !DILocation(line: 490, column: 27, scope: !71, inlinedAt: !79)
!79 = !DILocation(line: 169, column: 5, scope: !65)
!80 = !DILocation(line: 166, column: 18, scope: !56)
!81 = !DILocation(line: 491, column: 5, scope: !71, inlinedAt: !79)
!82 = !{i64 3165369423052480}
!83 = !DILocation(line: 172, column: 2, scope: !56)
!84 = distinct !DISubprogram(name: "{closure#0}<()>", linkageName: "_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs9fAkHImeXCI_12test_correct", scope: !15, file: !35, line: 206, type: !85, scopeLine: 206, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !89)
!85 = !DISubroutineType(types: !86)
!86 = !{!87, !88}
!87 = !DIBasicType(name: "i32", size: 32, encoding: DW_ATE_signed)
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "&std::rt::lang_start::{closure_env#0}<()>", baseType: !14, size: 64, align: 64, dwarfAddressSpace: 0)
!89 = !{!90}
!90 = !DILocalVariable(name: "main", scope: !84, file: !35, line: 200, type: !20, align: 64)
!91 = !DILocation(line: 200, column: 5, scope: !84)
!92 = !DILocation(line: 206, column: 70, scope: !84)
!93 = !DILocation(line: 206, column: 18, scope: !84)
!94 = !DILocation(line: 206, column: 76, scope: !84)
!95 = !DILocalVariable(name: "self", arg: 1, scope: !96, file: !97, line: 2288, type: !98)
!96 = distinct !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs9fAkHImeXCI_12test_correct", scope: !98, file: !97, line: 2288, type: !108, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, declaration: !110, retainedNodes: !111)
!97 = !DIFile(filename: "library/std/src/process.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "aa32a342ec19ed053728e871b78cbd51")
!98 = !DICompositeType(tag: DW_TAG_structure_type, name: "ExitCode", scope: !99, file: !2, size: 8, align: 8, flags: DIFlagPublic, elements: !100, templateParams: !23, identifier: "3cfa8e06f75b7ee66a1bab77ba921190")
!99 = !DINamespace(name: "process", scope: !17)
!100 = !{!101}
!101 = !DIDerivedType(tag: DW_TAG_member, name: "__0", scope: !98, file: !2, baseType: !102, size: 8, align: 8, flags: DIFlagPrivate)
!102 = !DICompositeType(tag: DW_TAG_structure_type, name: "ExitCode", scope: !103, file: !2, size: 8, align: 8, flags: DIFlagPublic, elements: !106, templateParams: !23, identifier: "82a6be3bfebff0b0ddaaa657e9698005")
!103 = !DINamespace(name: "common", scope: !104)
!104 = !DINamespace(name: "unix", scope: !105)
!105 = !DINamespace(name: "process", scope: !59)
!106 = !{!107}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "__0", scope: !102, file: !2, baseType: !41, size: 8, align: 8, flags: DIFlagPrivate)
!108 = !DISubroutineType(types: !109)
!109 = !{!87, !98}
!110 = !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs9fAkHImeXCI_12test_correct", scope: !98, file: !97, line: 2288, type: !108, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!111 = !{!95}
!112 = !DILocation(line: 2288, column: 19, scope: !96, inlinedAt: !113)
!113 = !DILocation(line: 206, column: 85, scope: !84)
!114 = !DILocation(line: 592, column: 9, scope: !115, inlinedAt: !121)
!115 = distinct !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs9fAkHImeXCI_12test_correct", scope: !102, file: !116, line: 591, type: !117, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, declaration: !120)
!116 = !DIFile(filename: "library/std/src/sys/process/unix/common.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "9ce13a63119e878727d165dd623553d1")
!117 = !DISubroutineType(types: !118)
!118 = !{!87, !119}
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "&std::sys::process::unix::common::ExitCode", baseType: !102, size: 64, align: 64, dwarfAddressSpace: 0)
!120 = !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs9fAkHImeXCI_12test_correct", scope: !102, file: !116, line: 591, type: !117, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!121 = !DILocation(line: 2289, column: 16, scope: !96, inlinedAt: !113)
!122 = !DILocation(line: 206, column: 93, scope: !84)
!123 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs9fAkHImeXCI_12test_correct", scope: !125, file: !124, line: 250, type: !128, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !134, retainedNodes: !131)
!124 = !DIFile(filename: "library/core/src/ops/function.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "ae01f833f82cd27aa916c99d95502941")
!125 = !DINamespace(name: "FnOnce", scope: !126)
!126 = !DINamespace(name: "function", scope: !127)
!127 = !DINamespace(name: "ops", scope: !74)
!128 = !DISubroutineType(types: !129)
!129 = !{!87, !130}
!130 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut std::rt::lang_start::{closure_env#0}<()>", baseType: !14, size: 64, align: 64, dwarfAddressSpace: 0)
!131 = !{!132, !133}
!132 = !DILocalVariable(arg: 1, scope: !123, file: !124, line: 250, type: !130)
!133 = !DILocalVariable(arg: 2, scope: !123, file: !124, line: 250, type: !7)
!134 = !{!135, !136}
!135 = !DITemplateTypeParameter(name: "Self", type: !14)
!136 = !DITemplateTypeParameter(name: "Args", type: !7)
!137 = !DILocation(line: 250, column: 5, scope: !123)
!138 = distinct !DISubprogram(name: "main", linkageName: "_RNvCs9fAkHImeXCI_12test_correct4main", scope: !140, file: !139, line: 27, type: !21, scopeLine: 27, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagMainSubprogram, unit: !31, templateParams: !23, retainedNodes: !141)
!139 = !DIFile(filename: "tests2/composition/test_correct.rs", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "beb67a5bf472fd3b0046c9ee52d7ac25")
!140 = !DINamespace(name: "test_correct", scope: null)
!141 = !{!142}
!142 = !DILocalVariable(name: "r", scope: !143, file: !139, line: 28, type: !87, align: 32)
!143 = distinct !DILexicalBlock(scope: !138, file: !139, line: 28, column: 5)
!144 = !DILocation(line: 28, column: 13, scope: !138)
!145 = !DILocation(line: 28, column: 9, scope: !143)
!146 = !DILocation(line: 29, column: 5, scope: !143)
!147 = distinct !DISubprogram(name: "report", linkageName: "_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs9fAkHImeXCI_12test_correct", scope: !148, file: !97, line: 2690, type: !149, scopeLine: 2690, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !151)
!148 = !DINamespace(name: "{impl#58}", scope: !99)
!149 = !DISubroutineType(types: !150)
!150 = !{!98, !7}
!151 = !{!152}
!152 = !DILocalVariable(arg: 1, scope: !147, file: !97, line: 2690, type: !7)
!153 = !DILocation(line: 2690, column: 15, scope: !147)
!154 = !DILocation(line: 2692, column: 6, scope: !147)
!155 = distinct !DISubprogram(name: "call_once<fn(), ()>", linkageName: "_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct", scope: !125, file: !124, line: 250, type: !60, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !159, retainedNodes: !156)
!156 = !{!157, !158}
!157 = !DILocalVariable(arg: 1, scope: !155, file: !124, line: 250, type: !20)
!158 = !DILocalVariable(arg: 2, scope: !155, file: !124, line: 250, type: !7)
!159 = !{!160, !136}
!160 = !DITemplateTypeParameter(name: "Self", type: !20)
!161 = !DILocation(line: 250, column: 5, scope: !155)
!162 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs9fAkHImeXCI_12test_correct", scope: !125, file: !124, line: 250, type: !163, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !134, retainedNodes: !165)
!163 = !DISubroutineType(types: !164)
!164 = !{!87, !14}
!165 = !{!166, !167}
!166 = !DILocalVariable(arg: 1, scope: !162, file: !124, line: 250, type: !14)
!167 = !DILocalVariable(arg: 2, scope: !162, file: !124, line: 250, type: !7)
!168 = !DILocation(line: 250, column: 5, scope: !162)
!169 = distinct !DISubprogram(name: "caller_pipeline", scope: !140, file: !139, line: 17, type: !170, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !172)
!170 = !DISubroutineType(types: !171)
!171 = !{!87, !87, !87}
!172 = !{!173, !174, !175, !177, !179}
!173 = !DILocalVariable(name: "input", arg: 1, scope: !169, file: !139, line: 17, type: !87)
!174 = !DILocalVariable(name: "factor", arg: 2, scope: !169, file: !139, line: 17, type: !87)
!175 = !DILocalVariable(name: "s1", scope: !176, file: !139, line: 18, type: !87, align: 32)
!176 = distinct !DILexicalBlock(scope: !169, file: !139, line: 18, column: 5)
!177 = !DILocalVariable(name: "s2", scope: !178, file: !139, line: 19, type: !87, align: 32)
!178 = distinct !DILexicalBlock(scope: !176, file: !139, line: 19, column: 5)
!179 = !DILocalVariable(name: "res", scope: !180, file: !139, line: 20, type: !87, align: 32)
!180 = distinct !DILexicalBlock(scope: !178, file: !139, line: 20, column: 5)
!181 = !DILocation(line: 17, column: 35, scope: !169)
!182 = !DILocation(line: 17, column: 47, scope: !169)
!183 = !DILocation(line: 20, column: 9, scope: !180)
!184 = !DILocation(line: 18, column: 14, scope: !169)
!185 = !DILocation(line: 18, column: 9, scope: !176)
!186 = !DILocation(line: 19, column: 14, scope: !176)
!187 = !DILocation(line: 19, column: 9, scope: !178)
!188 = !DILocation(line: 20, column: 19, scope: !178)
!189 = !DILocation(line: 22, column: 9, scope: !180)
!190 = !DILocation(line: 24, column: 5, scope: !180)
!191 = !DILocation(line: 25, column: 2, scope: !169)
!192 = distinct !DISubprogram(name: "helper_step1", scope: !140, file: !139, line: 2, type: !193, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !195)
!193 = !DISubroutineType(types: !194)
!194 = !{!87, !87}
!195 = !{!196}
!196 = !DILocalVariable(name: "a", arg: 1, scope: !192, file: !139, line: 2, type: !87)
!197 = !DILocation(line: 2, column: 32, scope: !192)
!198 = !DILocation(line: 3, column: 5, scope: !192)
!199 = !DILocation(line: 4, column: 2, scope: !192)
!200 = distinct !DISubprogram(name: "helper_step2", scope: !140, file: !139, line: 7, type: !193, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !201)
!201 = !{!202}
!202 = !DILocalVariable(name: "b", arg: 1, scope: !200, file: !139, line: 7, type: !87)
!203 = !DILocation(line: 7, column: 32, scope: !200)
!204 = !DILocation(line: 8, column: 5, scope: !200)
!205 = !DILocation(line: 9, column: 2, scope: !200)
!206 = distinct !DISubprogram(name: "helper_step3", scope: !140, file: !139, line: 12, type: !207, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !210)
!207 = !DISubroutineType(types: !208)
!208 = !{null, !209, !87}
!209 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut i32", baseType: !87, size: 64, align: 64, dwarfAddressSpace: 0)
!210 = !{!211, !212}
!211 = !DILocalVariable(name: "state", arg: 1, scope: !206, file: !139, line: 12, type: !209)
!212 = !DILocalVariable(name: "factor", arg: 2, scope: !206, file: !139, line: 12, type: !87)
!213 = !DILocation(line: 12, column: 39, scope: !206)
!214 = !DILocation(line: 12, column: 56, scope: !206)
!215 = !DILocation(line: 13, column: 14, scope: !206)
!216 = !DILocation(line: 13, column: 5, scope: !206)
!217 = !DILocation(line: 14, column: 2, scope: !206)
