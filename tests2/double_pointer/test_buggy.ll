; ModuleID = 'test_buggy.1ef1aff4e7ceeaf4-cgu.0'
source_filename = "test_buggy.1ef1aff4e7ceeaf4-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy }>, align 8, !dbg !0
@alloc_0d617c5419255f367271a0115ae8b6ef = private unnamed_addr constant [36 x i8] c"tests2/double_pointer/test_buggy.rs\00", align 1
@alloc_e96bde3b86807a71a376194fce85c0b4 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_0d617c5419255f367271a0115ae8b6ef, [16 x i8] c"#\00\00\00\00\00\00\00\04\00\00\00\09\00\00\00" }>, align 8
@alloc_5c2807f466529d101c6168233b33cb93 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_0d617c5419255f367271a0115ae8b6ef, [16 x i8] c"#\00\00\00\00\00\00\00\05\00\00\00\09\00\00\00" }>, align 8
@__rustc_debug_gdb_scripts_section__ = linkonce_odr unnamed_addr constant [34 x i8] c"\01gdb_load_rust_pretty_printers.py\00", section ".debug_gdb_scripts", align 1

; std::rt::lang_start::<()>
; Function Attrs: nounwind nonlazybind uwtable
define hidden i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy(ptr %main, i64 %argc, ptr %argv, i8 %sigpipe) unnamed_addr #0 !dbg !34 {
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
define internal void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy(ptr %f) unnamed_addr #1 !dbg !56 {
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
  call void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %f) #7, !dbg !80
  call void asm sideeffect "", "~{memory}"(), !dbg !81, !srcloc !82
  ret void, !dbg !83
}

; std::rt::lang_start::<()>::{closure#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy(ptr align 8 %_1) unnamed_addr #2 !dbg !84 {
start:
  %self.dbg.spill = alloca [1 x i8], align 1
  %_1.dbg.spill = alloca [8 x i8], align 8
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !90, !DIExpression(DW_OP_deref), !91)
  %_4 = load ptr, ptr %_1, align 8, !dbg !92
; call std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
  call void @_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy(ptr %_4) #8, !dbg !93
; call <() as std::process::Termination>::report
  %self = call i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy() #7, !dbg !94
  store i8 %self, ptr %self.dbg.spill, align 1, !dbg !94
    #dbg_declare(ptr %self.dbg.spill, !95, !DIExpression(), !112)
  %_0 = zext i8 %self to i32, !dbg !114
  ret i32 %_0, !dbg !122
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once::{shim:vtable#0}
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy(ptr %_1) unnamed_addr #2 !dbg !123 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !132, !DIExpression(), !137)
    #dbg_declare(ptr %_2, !133, !DIExpression(), !137)
  %0 = load ptr, ptr %_1, align 8, !dbg !137
; call <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
  %_0 = call i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %0) #7, !dbg !137
  ret i32 %_0, !dbg !137
}

; test_buggy::main
; Function Attrs: nounwind nonlazybind uwtable
define hidden void @_RNvCs2EIjc6ZEoKu_10test_buggy4main() unnamed_addr #0 !dbg !138 {
start:
  %res.dbg.spill = alloca [4 x i8], align 4, !dbg !144
  %res = call i32 @caller_reset() #6, !dbg !144
  store i32 %res, ptr %res.dbg.spill, align 4, !dbg !144
    #dbg_declare(ptr %res.dbg.spill, !142, !DIExpression(), !145)
; call std::process::exit
  call void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32 %res) #9, !dbg !146
  unreachable, !dbg !146
}

; <*mut i32>::is_null
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal zeroext i1 @_RNvMNtNtCsc36rpYXAlPq_4core3ptr7mut_ptrOl7is_nullCs2EIjc6ZEoKu_10test_buggy(ptr %self) unnamed_addr #2 !dbg !147 {
start:
  %self.dbg.spill = alloca [8 x i8], align 8
  store ptr %self, ptr %self.dbg.spill, align 8
    #dbg_declare(ptr %self.dbg.spill, !157, !DIExpression(), !160)
  %_3 = ptrtoint ptr %self to i64, !dbg !161
  %_0 = icmp eq i64 %_3, 0, !dbg !184
  ret i1 %_0, !dbg !185
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy() unnamed_addr #2 !dbg !186 {
start:
  %_1.dbg.spill = alloca [0 x i8], align 1
    #dbg_declare(ptr %_1.dbg.spill, !191, !DIExpression(), !192)
  ret i8 0, !dbg !193
}

; <fn() as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %_1) unnamed_addr #2 !dbg !194 {
start:
  %_1.dbg.spill = alloca [8 x i8], align 8
  %_2 = alloca [0 x i8], align 1
  store ptr %_1, ptr %_1.dbg.spill, align 8
    #dbg_declare(ptr %_1.dbg.spill, !196, !DIExpression(), !200)
    #dbg_declare(ptr %_2, !197, !DIExpression(), !200)
  call void %_1() #6, !dbg !200
  ret void, !dbg !200
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %0) unnamed_addr #2 !dbg !201 {
start:
  %_2 = alloca [0 x i8], align 1
  %_1 = alloca [8 x i8], align 8
  store ptr %0, ptr %_1, align 8
    #dbg_declare(ptr %_1, !205, !DIExpression(), !207)
    #dbg_declare(ptr %_2, !206, !DIExpression(), !207)
; call std::rt::lang_start::<()>::{closure#0}
  %_0 = call i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy(ptr align 8 %_1) #7, !dbg !207
  ret i32 %_0, !dbg !207
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @caller_reset() unnamed_addr #0 !dbg !208 {
start:
  %p = alloca [8 x i8], align 8
  %target = alloca [4 x i8], align 4
  %_0 = alloca [4 x i8], align 4
    #dbg_declare(ptr %target, !212, !DIExpression(), !216)
    #dbg_declare(ptr %p, !214, !DIExpression(), !217)
  store i32 42, ptr %target, align 4, !dbg !218
  store ptr %target, ptr %p, align 8, !dbg !219
  call void @reset_ptr(ptr %p) #6, !dbg !220
  %_8 = load ptr, ptr %p, align 8, !dbg !221
; call <*mut i32>::is_null
  %_7 = call zeroext i1 @_RNvMNtNtCsc36rpYXAlPq_4core3ptr7mut_ptrOl7is_nullCs2EIjc6ZEoKu_10test_buggy(ptr %_8) #7, !dbg !222
  br i1 %_7, label %bb3, label %bb4, !dbg !221

bb4:                                              ; preds = %start
  store i32 0, ptr %_0, align 4, !dbg !223
  br label %bb5, !dbg !224

bb3:                                              ; preds = %start
  store i32 1, ptr %_0, align 4, !dbg !225
  br label %bb5, !dbg !224

bb5:                                              ; preds = %bb3, %bb4
  %0 = load i32, ptr %_0, align 4, !dbg !226
  ret i32 %0, !dbg !226
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local void @reset_ptr(ptr %p) unnamed_addr #0 !dbg !227 {
start:
  %p.dbg.spill = alloca [8 x i8], align 8
  store ptr %p, ptr %p.dbg.spill, align 8
    #dbg_declare(ptr %p.dbg.spill, !232, !DIExpression(), !233)
  %_16 = ptrtoint ptr %p to i64, !dbg !234
  %_18 = and i64 %_16, 7, !dbg !234
  %_19 = icmp eq i64 %_18, 0, !dbg !234
  br i1 %_19, label %bb6, label %panic, !dbg !234

bb6:                                              ; preds = %start
  %_21 = ptrtoint ptr %p to i64, !dbg !234
  %_23 = icmp eq i64 %_21, 0, !dbg !234
  %_24 = and i1 %_23, true, !dbg !234
  %_25 = xor i1 %_24, true, !dbg !234
  br i1 %_25, label %bb7, label %panic1, !dbg !234

panic:                                            ; preds = %start
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 8, i64 %_16, ptr align 8 @alloc_e96bde3b86807a71a376194fce85c0b4) #10, !dbg !234
  unreachable, !dbg !234

bb7:                                              ; preds = %bb6
  %_3 = load ptr, ptr %p, align 8, !dbg !234
; call <*mut i32>::is_null
  %_2 = call zeroext i1 @_RNvMNtNtCsc36rpYXAlPq_4core3ptr7mut_ptrOl7is_nullCs2EIjc6ZEoKu_10test_buggy(ptr %_3) #7, !dbg !235
  br i1 %_2, label %bb3, label %bb2, !dbg !234

panic1:                                           ; preds = %bb6
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_e96bde3b86807a71a376194fce85c0b4) #10, !dbg !234
  unreachable, !dbg !234

bb2:                                              ; preds = %bb7
  %_11 = ptrtoint ptr %p to i64, !dbg !236
  %_13 = and i64 %_11, 7, !dbg !236
  %_14 = icmp eq i64 %_13, 0, !dbg !236
  br i1 %_14, label %bb5, label %panic2, !dbg !236

bb3:                                              ; preds = %bb9, %bb7
  ret void, !dbg !237

bb5:                                              ; preds = %bb2
  %_27 = ptrtoint ptr %p to i64, !dbg !236
  %_29 = icmp eq i64 %_27, 0, !dbg !236
  %_30 = and i1 %_29, true, !dbg !236
  %_31 = xor i1 %_30, true, !dbg !236
  br i1 %_31, label %bb8, label %panic3, !dbg !236

panic2:                                           ; preds = %bb2
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 8, i64 %_11, ptr align 8 @alloc_5c2807f466529d101c6168233b33cb93) #10, !dbg !236
  unreachable, !dbg !236

bb8:                                              ; preds = %bb5
  %_4 = load ptr, ptr %p, align 8, !dbg !236
  %_6 = ptrtoint ptr %_4 to i64, !dbg !236
  %_8 = and i64 %_6, 3, !dbg !236
  %_9 = icmp eq i64 %_8, 0, !dbg !236
  br i1 %_9, label %bb4, label %panic4, !dbg !236

panic3:                                           ; preds = %bb5
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_5c2807f466529d101c6168233b33cb93) #10, !dbg !236
  unreachable, !dbg !236

bb4:                                              ; preds = %bb8
  %_33 = ptrtoint ptr %_4 to i64, !dbg !236
  %_35 = icmp eq i64 %_33, 0, !dbg !236
  %_36 = and i1 %_35, true, !dbg !236
  %_37 = xor i1 %_36, true, !dbg !236
  br i1 %_37, label %bb9, label %panic5, !dbg !236

panic4:                                           ; preds = %bb8
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_6, ptr align 8 @alloc_5c2807f466529d101c6168233b33cb93) #10, !dbg !236
  unreachable, !dbg !236

bb9:                                              ; preds = %bb4
  store i32 0, ptr %_4, align 4, !dbg !236
  br label %bb3, !dbg !238

panic5:                                           ; preds = %bb4
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_5c2807f466529d101c6168233b33cb93) #10, !dbg !236
  unreachable, !dbg !236
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
  %4 = call i64 @_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy(ptr @_RNvCs2EIjc6ZEoKu_10test_buggy4main, i64 %3, ptr %1, i8 0)
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
!32 = !DIFile(filename: "tests2/double_pointer/test_buggy.rs/@/test_buggy.1ef1aff4e7ceeaf4-cgu.0", directory: "/home/hari/rustsketch")
!33 = !{!0}
!34 = distinct !DISubprogram(name: "lang_start<()>", linkageName: "_RINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuECs2EIjc6ZEoKu_10test_buggy", scope: !16, file: !35, line: 199, type: !36, scopeLine: 199, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !42)
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
!56 = distinct !DISubprogram(name: "__rust_begin_short_backtrace<fn(), ()>", linkageName: "_RINvNtNtCs6ZjlLoI6YmX_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs2EIjc6ZEoKu_10test_buggy", scope: !58, file: !57, line: 162, type: !60, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !66, retainedNodes: !62)
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
!71 = distinct !DISubprogram(name: "black_box<()>", linkageName: "_RINvNtCsc36rpYXAlPq_4core4hint9black_boxuECs2EIjc6ZEoKu_10test_buggy", scope: !73, file: !72, line: 490, type: !75, scopeLine: 490, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !77)
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
!82 = !{i64 7674385005233069}
!83 = !DILocation(line: 172, column: 2, scope: !56)
!84 = distinct !DISubprogram(name: "{closure#0}<()>", linkageName: "_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy", scope: !15, file: !35, line: 206, type: !85, scopeLine: 206, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !47, retainedNodes: !89)
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
!96 = distinct !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !98, file: !97, line: 2288, type: !108, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, declaration: !110, retainedNodes: !111)
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
!110 = !DISubprogram(name: "to_i32", linkageName: "_RNvMsO_NtCs6ZjlLoI6YmX_3std7processNtB5_8ExitCode6to_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !98, file: !97, line: 2288, type: !108, scopeLine: 2288, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!111 = !{!95}
!112 = !DILocation(line: 2288, column: 19, scope: !96, inlinedAt: !113)
!113 = !DILocation(line: 206, column: 85, scope: !84)
!114 = !DILocation(line: 592, column: 9, scope: !115, inlinedAt: !121)
!115 = distinct !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !102, file: !116, line: 591, type: !117, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, declaration: !120)
!116 = !DIFile(filename: "library/std/src/sys/process/unix/common.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "9ce13a63119e878727d165dd623553d1")
!117 = !DISubroutineType(types: !118)
!118 = !{!87, !119}
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "&std::sys::process::unix::common::ExitCode", baseType: !102, size: 64, align: 64, dwarfAddressSpace: 0)
!120 = !DISubprogram(name: "as_i32", linkageName: "_RNvMs8_NtNtNtNtCs6ZjlLoI6YmX_3std3sys7process4unix6commonNtB5_8ExitCode6as_i32Cs2EIjc6ZEoKu_10test_buggy", scope: !102, file: !116, line: 591, type: !117, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit, templateParams: !23)
!121 = !DILocation(line: 2289, column: 16, scope: !96, inlinedAt: !113)
!122 = !DILocation(line: 206, column: 93, scope: !84)
!123 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy", scope: !125, file: !124, line: 250, type: !128, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !134, retainedNodes: !131)
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
!138 = distinct !DISubprogram(name: "main", linkageName: "_RNvCs2EIjc6ZEoKu_10test_buggy4main", scope: !140, file: !139, line: 19, type: !21, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagMainSubprogram, unit: !31, templateParams: !23, retainedNodes: !141)
!139 = !DIFile(filename: "tests2/double_pointer/test_buggy.rs", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "b43e66e2730968d3ca8a2302db1b5933")
!140 = !DINamespace(name: "test_buggy", scope: null)
!141 = !{!142}
!142 = !DILocalVariable(name: "res", scope: !143, file: !139, line: 20, type: !87, align: 32)
!143 = distinct !DILexicalBlock(scope: !138, file: !139, line: 20, column: 5)
!144 = !DILocation(line: 20, column: 15, scope: !138)
!145 = !DILocation(line: 20, column: 9, scope: !143)
!146 = !DILocation(line: 21, column: 5, scope: !143)
!147 = distinct !DISubprogram(name: "is_null<i32>", linkageName: "_RNvMNtNtCsc36rpYXAlPq_4core3ptr7mut_ptrOl7is_nullCs2EIjc6ZEoKu_10test_buggy", scope: !149, file: !148, line: 22, type: !152, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !158, retainedNodes: !156)
!148 = !DIFile(filename: "library/core/src/ptr/mut_ptr.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "b801fd1545b7efabfd51f22bd5061ba6")
!149 = !DINamespace(name: "{impl#0}", scope: !150)
!150 = !DINamespace(name: "mut_ptr", scope: !151)
!151 = !DINamespace(name: "ptr", scope: !74)
!152 = !DISubroutineType(types: !153)
!153 = !{!154, !155}
!154 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!155 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut i32", baseType: !87, size: 64, align: 64, dwarfAddressSpace: 0)
!156 = !{!157}
!157 = !DILocalVariable(name: "self", arg: 1, scope: !147, file: !148, line: 22, type: !155)
!158 = !{!159}
!159 = !DITemplateTypeParameter(name: "T", type: !87)
!160 = !DILocation(line: 22, column: 26, scope: !147)
!161 = !DILocation(line: 159, column: 18, scope: !162, inlinedAt: !170)
!162 = distinct !DISubprogram(name: "addr<u8>", linkageName: "_RNvMNtNtCsc36rpYXAlPq_4core3ptr9const_ptrPh4addrCs2EIjc6ZEoKu_10test_buggy", scope: !164, file: !163, line: 153, type: !166, scopeLine: 153, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !168)
!163 = !DIFile(filename: "library/core/src/ptr/const_ptr.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "7502698646a1d0fc6eeea1d3df03cef6")
!164 = !DINamespace(name: "{impl#0}", scope: !165)
!165 = !DINamespace(name: "const_ptr", scope: !151)
!166 = !DISubroutineType(types: !167)
!167 = !{!9, !40}
!168 = !{!169}
!169 = !DITemplateTypeParameter(name: "T", type: !41)
!170 = !DILocation(line: 38, column: 21, scope: !171, inlinedAt: !177)
!171 = !DILexicalBlockFile(scope: !172, file: !163, discriminator: 0)
!172 = distinct !DISubprogram(name: "runtime", linkageName: "_RNvNvMNtNtCsc36rpYXAlPq_4core3ptr9const_ptrPp7is_null7runtimeCs2EIjc6ZEoKu_10test_buggy", scope: !174, file: !173, line: 2445, type: !175, scopeLine: 2445, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23)
!173 = !DIFile(filename: "library/core/src/intrinsics/mod.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "4e82dfee9e66af24bdaba3dd46fe5959")
!174 = !DINamespace(name: "is_null", scope: !164)
!175 = !DISubroutineType(types: !176)
!176 = !{!154, !40}
!177 = !DILocation(line: 2458, column: 9, scope: !178, inlinedAt: !183)
!178 = !DILexicalBlockFile(scope: !179, file: !173, discriminator: 0)
!179 = distinct !DISubprogram(name: "is_null<i32>", linkageName: "_RNvMNtNtCsc36rpYXAlPq_4core3ptr9const_ptrPl7is_nullCs2EIjc6ZEoKu_10test_buggy", scope: !164, file: !163, line: 22, type: !180, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !158)
!180 = !DISubroutineType(types: !181)
!181 = !{!154, !182}
!182 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*const i32", baseType: !87, size: 64, align: 64, dwarfAddressSpace: 0)
!183 = !DILocation(line: 23, column: 27, scope: !147)
!184 = !DILocation(line: 38, column: 17, scope: !171, inlinedAt: !177)
!185 = !DILocation(line: 24, column: 6, scope: !147)
!186 = distinct !DISubprogram(name: "report", linkageName: "_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy", scope: !187, file: !97, line: 2690, type: !188, scopeLine: 2690, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !190)
!187 = !DINamespace(name: "{impl#58}", scope: !99)
!188 = !DISubroutineType(types: !189)
!189 = !{!98, !7}
!190 = !{!191}
!191 = !DILocalVariable(arg: 1, scope: !186, file: !97, line: 2690, type: !7)
!192 = !DILocation(line: 2690, column: 15, scope: !186)
!193 = !DILocation(line: 2692, column: 6, scope: !186)
!194 = distinct !DISubprogram(name: "call_once<fn(), ()>", linkageName: "_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !125, file: !124, line: 250, type: !60, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !198, retainedNodes: !195)
!195 = !{!196, !197}
!196 = !DILocalVariable(arg: 1, scope: !194, file: !124, line: 250, type: !20)
!197 = !DILocalVariable(arg: 2, scope: !194, file: !124, line: 250, type: !7)
!198 = !{!199, !136}
!199 = !DITemplateTypeParameter(name: "Self", type: !20)
!200 = !DILocation(line: 250, column: 5, scope: !194)
!201 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !125, file: !124, line: 250, type: !202, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !134, retainedNodes: !204)
!202 = !DISubroutineType(types: !203)
!203 = !{!87, !14}
!204 = !{!205, !206}
!205 = !DILocalVariable(arg: 1, scope: !201, file: !124, line: 250, type: !14)
!206 = !DILocalVariable(arg: 2, scope: !201, file: !124, line: 250, type: !7)
!207 = !DILocation(line: 250, column: 5, scope: !201)
!208 = distinct !DISubprogram(name: "caller_reset", scope: !140, file: !139, line: 10, type: !209, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !211)
!209 = !DISubroutineType(types: !210)
!210 = !{!87}
!211 = !{!212, !214}
!212 = !DILocalVariable(name: "target", scope: !213, file: !139, line: 11, type: !87, align: 32)
!213 = distinct !DILexicalBlock(scope: !208, file: !139, line: 11, column: 5)
!214 = !DILocalVariable(name: "p", scope: !215, file: !139, line: 12, type: !155, align: 64)
!215 = distinct !DILexicalBlock(scope: !213, file: !139, line: 12, column: 5)
!216 = !DILocation(line: 11, column: 9, scope: !213)
!217 = !DILocation(line: 12, column: 9, scope: !215)
!218 = !DILocation(line: 11, column: 22, scope: !208)
!219 = !DILocation(line: 12, column: 17, scope: !213)
!220 = !DILocation(line: 14, column: 9, scope: !215)
!221 = !DILocation(line: 16, column: 8, scope: !215)
!222 = !DILocation(line: 16, column: 10, scope: !215)
!223 = !DILocation(line: 16, column: 33, scope: !215)
!224 = !DILocation(line: 16, column: 5, scope: !215)
!225 = !DILocation(line: 16, column: 22, scope: !215)
!226 = !DILocation(line: 17, column: 2, scope: !208)
!227 = distinct !DISubprogram(name: "reset_ptr", scope: !140, file: !139, line: 2, type: !228, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !231)
!228 = !DISubroutineType(types: !229)
!229 = !{null, !230}
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut *mut i32", baseType: !155, size: 64, align: 64, dwarfAddressSpace: 0)
!231 = !{!232}
!232 = !DILocalVariable(name: "p", arg: 1, scope: !227, file: !139, line: 2, type: !230)
!233 = !DILocation(line: 2, column: 36, scope: !227)
!234 = !DILocation(line: 4, column: 9, scope: !227)
!235 = !DILocation(line: 4, column: 14, scope: !227)
!236 = !DILocation(line: 5, column: 9, scope: !227)
!237 = !DILocation(line: 7, column: 2, scope: !227)
!238 = !DILocation(line: 4, column: 5, scope: !227)
