; ModuleID = 'test_buggy.1ef1aff4e7ceeaf4-cgu.0'
source_filename = "test_buggy.1ef1aff4e7ceeaf4-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNSNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_once6vtableCs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy, ptr @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy }>, align 8, !dbg !0
@alloc_10efb06ed16ebbfe9da5f35f5a8338cf = private unnamed_addr constant [48 x i8] c"large_benchmarks/01_hash_pipeline/test_buggy.rs\00", align 1
@alloc_d50599ea12ac2883a79f3bc0891844e7 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_10efb06ed16ebbfe9da5f35f5a8338cf, [16 x i8] c"/\00\00\00\00\00\00\00\1B\00\00\00\1D\00\00\00" }>, align 8
@alloc_bd76910273561edd7ac8fbc193cf497d = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_10efb06ed16ebbfe9da5f35f5a8338cf, [16 x i8] c"/\00\00\00\00\00\00\00\1B\00\00\00\05\00\00\00" }>, align 8
@alloc_10a3252b726817918d377619156dbb4d = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_10efb06ed16ebbfe9da5f35f5a8338cf, [16 x i8] c"/\00\00\00\00\00\00\00\1C\00\00\00\1D\00\00\00" }>, align 8
@alloc_453a2987c997baee249834fdbc4836db = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_10efb06ed16ebbfe9da5f35f5a8338cf, [16 x i8] c"/\00\00\00\00\00\00\00\1C\00\00\00\05\00\00\00" }>, align 8
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
  %res = call i32 @caller_hash_pipeline(i32 4660, i32 22136) #6, !dbg !144
  store i32 %res, ptr %res.dbg.spill, align 4, !dbg !144
    #dbg_declare(ptr %res.dbg.spill, !142, !DIExpression(), !145)
; call std::process::exit
  call void @_RNvNtCs6ZjlLoI6YmX_3std7process4exit(i32 %res) #9, !dbg !146
  unreachable, !dbg !146
}

; <() as std::process::Termination>::report
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal i8 @_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy() unnamed_addr #2 !dbg !147 {
start:
  %_1.dbg.spill = alloca [0 x i8], align 1
    #dbg_declare(ptr %_1.dbg.spill, !152, !DIExpression(), !153)
  ret i8 0, !dbg !154
}

; <fn() as core::ops::function::FnOnce<()>>::call_once
; Function Attrs: inlinehint nounwind nonlazybind uwtable
define internal void @_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %_1) unnamed_addr #2 !dbg !155 {
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
define internal i32 @_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy(ptr %0) unnamed_addr #2 !dbg !162 {
start:
  %_2 = alloca [0 x i8], align 1
  %_1 = alloca [8 x i8], align 8
  store ptr %0, ptr %_1, align 8
    #dbg_declare(ptr %_1, !166, !DIExpression(), !168)
    #dbg_declare(ptr %_2, !167, !DIExpression(), !168)
; call std::rt::lang_start::<()>::{closure#0}
  %_0 = call i32 @_RNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0Cs2EIjc6ZEoKu_10test_buggy(ptr align 8 %_1) #7, !dbg !168
  ret i32 %_0, !dbg !168
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @caller_hash_pipeline(i32 %word1, i32 %word2) unnamed_addr #0 !dbg !169 {
start:
  %word2.dbg.spill = alloca [4 x i8], align 4
  %word1.dbg.spill = alloca [4 x i8], align 4
  %h = alloca [4 x i8], align 4
  store i32 %word1, ptr %word1.dbg.spill, align 4
    #dbg_declare(ptr %word1.dbg.spill, !174, !DIExpression(), !178)
  store i32 %word2, ptr %word2.dbg.spill, align 4
    #dbg_declare(ptr %word2.dbg.spill, !175, !DIExpression(), !179)
    #dbg_declare(ptr %h, !176, !DIExpression(), !180)
  %0 = call i32 @hash_init() #6, !dbg !181
  store i32 %0, ptr %h, align 4, !dbg !181
  call void @hash_update_token(ptr %h, i32 %word1, i32 %word2) #6, !dbg !182
  %_8 = load i32, ptr %h, align 4, !dbg !183
  %_7 = call i32 @hash_avalanche(i32 %_8) #6, !dbg !184
  ret i32 %_7, !dbg !185
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @hash_avalanche(i32 %0) unnamed_addr #0 !dbg !186 {
start:
  %rhs.dbg.spill.i1 = alloca [4 x i8], align 4
  %self.dbg.spill.i2 = alloca [4 x i8], align 4
  %rhs.dbg.spill.i = alloca [4 x i8], align 4
  %self.dbg.spill.i = alloca [4 x i8], align 4
  %h = alloca [4 x i8], align 4
  store i32 %0, ptr %h, align 4
    #dbg_declare(ptr %h, !190, !DIExpression(), !191)
  %_3 = load i32, ptr %h, align 4, !dbg !192
  %_2 = lshr i32 %_3, 15, !dbg !192
  %1 = load i32, ptr %h, align 4, !dbg !193
  %2 = xor i32 %1, %_2, !dbg !193
  store i32 %2, ptr %h, align 4, !dbg !193
  %_5 = load i32, ptr %h, align 4, !dbg !194
  store i32 %_5, ptr %self.dbg.spill.i2, align 4
    #dbg_declare(ptr %self.dbg.spill.i2, !195, !DIExpression(), !204)
  store i32 -2048144789, ptr %rhs.dbg.spill.i1, align 4
    #dbg_declare(ptr %rhs.dbg.spill.i1, !203, !DIExpression(), !206)
  %_0.i3 = mul i32 %_5, -2048144789, !dbg !207
  store i32 %_0.i3, ptr %h, align 4, !dbg !208
  %_7 = load i32, ptr %h, align 4, !dbg !209
  %_6 = lshr i32 %_7, 13, !dbg !209
  %3 = load i32, ptr %h, align 4, !dbg !210
  %4 = xor i32 %3, %_6, !dbg !210
  store i32 %4, ptr %h, align 4, !dbg !210
  %_9 = load i32, ptr %h, align 4, !dbg !211
  store i32 %_9, ptr %self.dbg.spill.i, align 4
    #dbg_declare(ptr %self.dbg.spill.i, !195, !DIExpression(), !212)
  store i32 -1028477387, ptr %rhs.dbg.spill.i, align 4
    #dbg_declare(ptr %rhs.dbg.spill.i, !203, !DIExpression(), !214)
  %_0.i = mul i32 %_9, -1028477387, !dbg !215
  store i32 %_0.i, ptr %h, align 4, !dbg !216
  %_11 = load i32, ptr %h, align 4, !dbg !217
  %_10 = lshr i32 %_11, 16, !dbg !217
  %5 = load i32, ptr %h, align 4, !dbg !218
  %6 = xor i32 %5, %_10, !dbg !218
  store i32 %6, ptr %h, align 4, !dbg !218
  %_0 = load i32, ptr %h, align 4, !dbg !219
  ret i32 %_0, !dbg !220
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @hash_init() unnamed_addr #0 !dbg !221 {
start:
  ret i32 -2128831035, !dbg !224
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local i32 @hash_step(i32 %current_hash, i32 %byte_val) unnamed_addr #0 !dbg !225 {
start:
  %rhs.dbg.spill.i = alloca [4 x i8], align 4
  %self.dbg.spill.i = alloca [4 x i8], align 4
  %byte_val.dbg.spill = alloca [4 x i8], align 4
  %current_hash.dbg.spill = alloca [4 x i8], align 4
  store i32 %current_hash, ptr %current_hash.dbg.spill, align 4
    #dbg_declare(ptr %current_hash.dbg.spill, !227, !DIExpression(), !229)
  store i32 %byte_val, ptr %byte_val.dbg.spill, align 4
    #dbg_declare(ptr %byte_val.dbg.spill, !228, !DIExpression(), !230)
  %_4 = and i32 %byte_val, 255, !dbg !231
  %_3 = xor i32 %current_hash, %_4, !dbg !232
  store i32 %_3, ptr %self.dbg.spill.i, align 4
    #dbg_declare(ptr %self.dbg.spill.i, !195, !DIExpression(), !233)
  store i32 16777619, ptr %rhs.dbg.spill.i, align 4
    #dbg_declare(ptr %rhs.dbg.spill.i, !203, !DIExpression(), !235)
  %_0.i = mul i32 %_3, 16777619, !dbg !236
  ret i32 %_0.i, !dbg !237
}

; Function Attrs: nounwind nonlazybind uwtable
define dso_local void @hash_update_token(ptr %hash_state, i32 %part1, i32 %part2) unnamed_addr #0 !dbg !238 {
start:
  %part2.dbg.spill = alloca [4 x i8], align 4
  %part1.dbg.spill = alloca [4 x i8], align 4
  %hash_state.dbg.spill = alloca [8 x i8], align 8
  store ptr %hash_state, ptr %hash_state.dbg.spill, align 8
    #dbg_declare(ptr %hash_state.dbg.spill, !243, !DIExpression(), !246)
  store i32 %part1, ptr %part1.dbg.spill, align 4
    #dbg_declare(ptr %part1.dbg.spill, !244, !DIExpression(), !247)
  store i32 %part2, ptr %part2.dbg.spill, align 4
    #dbg_declare(ptr %part2.dbg.spill, !245, !DIExpression(), !248)
  %_24 = ptrtoint ptr %hash_state to i64, !dbg !249
  %_26 = and i64 %_24, 3, !dbg !249
  %_27 = icmp eq i64 %_26, 0, !dbg !249
  br i1 %_27, label %bb6, label %panic, !dbg !249

bb6:                                              ; preds = %start
  %_29 = ptrtoint ptr %hash_state to i64, !dbg !249
  %_31 = icmp eq i64 %_29, 0, !dbg !249
  %_32 = and i1 %_31, true, !dbg !249
  %_33 = xor i1 %_32, true, !dbg !249
  br i1 %_33, label %bb7, label %panic1, !dbg !249

panic:                                            ; preds = %start
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_24, ptr align 8 @alloc_d50599ea12ac2883a79f3bc0891844e7) #10, !dbg !249
  unreachable, !dbg !249

bb7:                                              ; preds = %bb6
  %_5 = load i32, ptr %hash_state, align 4, !dbg !249
  %_4 = call i32 @hash_step(i32 %_5, i32 %part1) #6, !dbg !250
  %_19 = ptrtoint ptr %hash_state to i64, !dbg !251
  %_21 = and i64 %_19, 3, !dbg !251
  %_22 = icmp eq i64 %_21, 0, !dbg !251
  br i1 %_22, label %bb5, label %panic2, !dbg !251

panic1:                                           ; preds = %bb6
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_d50599ea12ac2883a79f3bc0891844e7) #10, !dbg !249
  unreachable, !dbg !249

bb5:                                              ; preds = %bb7
  %_35 = ptrtoint ptr %hash_state to i64, !dbg !251
  %_37 = icmp eq i64 %_35, 0, !dbg !251
  %_38 = and i1 %_37, true, !dbg !251
  %_39 = xor i1 %_38, true, !dbg !251
  br i1 %_39, label %bb8, label %panic3, !dbg !251

panic2:                                           ; preds = %bb7
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_19, ptr align 8 @alloc_bd76910273561edd7ac8fbc193cf497d) #10, !dbg !251
  unreachable, !dbg !251

bb8:                                              ; preds = %bb5
  store i32 %_4, ptr %hash_state, align 4, !dbg !251
  %_14 = ptrtoint ptr %hash_state to i64, !dbg !252
  %_16 = and i64 %_14, 3, !dbg !252
  %_17 = icmp eq i64 %_16, 0, !dbg !252
  br i1 %_17, label %bb4, label %panic4, !dbg !252

panic3:                                           ; preds = %bb5
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_bd76910273561edd7ac8fbc193cf497d) #10, !dbg !251
  unreachable, !dbg !251

bb4:                                              ; preds = %bb8
  %_41 = ptrtoint ptr %hash_state to i64, !dbg !252
  %_43 = icmp eq i64 %_41, 0, !dbg !252
  %_44 = and i1 %_43, true, !dbg !252
  %_45 = xor i1 %_44, true, !dbg !252
  br i1 %_45, label %bb9, label %panic5, !dbg !252

panic4:                                           ; preds = %bb8
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_14, ptr align 8 @alloc_10a3252b726817918d377619156dbb4d) #10, !dbg !252
  unreachable, !dbg !252

bb9:                                              ; preds = %bb4
  %_7 = load i32, ptr %hash_state, align 4, !dbg !252
  %_6 = call i32 @hash_step(i32 %_7, i32 %part2) #6, !dbg !253
  %_9 = ptrtoint ptr %hash_state to i64, !dbg !254
  %_11 = and i64 %_9, 3, !dbg !254
  %_12 = icmp eq i64 %_11, 0, !dbg !254
  br i1 %_12, label %bb3, label %panic6, !dbg !254

panic5:                                           ; preds = %bb4
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_10a3252b726817918d377619156dbb4d) #10, !dbg !252
  unreachable, !dbg !252

bb3:                                              ; preds = %bb9
  %_47 = ptrtoint ptr %hash_state to i64, !dbg !254
  %_49 = icmp eq i64 %_47, 0, !dbg !254
  %_50 = and i1 %_49, true, !dbg !254
  %_51 = xor i1 %_50, true, !dbg !254
  br i1 %_51, label %bb10, label %panic7, !dbg !254

panic6:                                           ; preds = %bb9
; call core::panicking::panic_misaligned_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking36panic_misaligned_pointer_dereference(i64 4, i64 %_9, ptr align 8 @alloc_453a2987c997baee249834fdbc4836db) #10, !dbg !254
  unreachable, !dbg !254

bb10:                                             ; preds = %bb3
  store i32 %_6, ptr %hash_state, align 4, !dbg !254
  ret void, !dbg !255

panic7:                                           ; preds = %bb3
; call core::panicking::panic_null_pointer_dereference
  call void @_RNvNtCsc36rpYXAlPq_4core9panicking30panic_null_pointer_dereference(ptr align 8 @alloc_453a2987c997baee249834fdbc4836db) #10, !dbg !254
  unreachable, !dbg !254
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
!32 = !DIFile(filename: "large_benchmarks/01_hash_pipeline/test_buggy.rs/@/test_buggy.1ef1aff4e7ceeaf4-cgu.0", directory: "/home/hari/rustsketch")
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
!82 = !{i64 6447364388087733}
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
!138 = distinct !DISubprogram(name: "main", linkageName: "_RNvCs2EIjc6ZEoKu_10test_buggy4main", scope: !140, file: !139, line: 40, type: !21, scopeLine: 40, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagMainSubprogram, unit: !31, templateParams: !23, retainedNodes: !141)
!139 = !DIFile(filename: "large_benchmarks/01_hash_pipeline/test_buggy.rs", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "bc635623a6819299a4e68bbfd9d840c4")
!140 = !DINamespace(name: "test_buggy", scope: null)
!141 = !{!142}
!142 = !DILocalVariable(name: "res", scope: !143, file: !139, line: 41, type: !87, align: 32)
!143 = distinct !DILexicalBlock(scope: !138, file: !139, line: 41, column: 5)
!144 = !DILocation(line: 41, column: 15, scope: !138)
!145 = !DILocation(line: 41, column: 9, scope: !143)
!146 = !DILocation(line: 42, column: 5, scope: !143)
!147 = distinct !DISubprogram(name: "report", linkageName: "_RNvXsU_NtCs6ZjlLoI6YmX_3std7processuNtB5_11Termination6reportCs2EIjc6ZEoKu_10test_buggy", scope: !148, file: !97, line: 2690, type: !149, scopeLine: 2690, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !151)
!148 = !DINamespace(name: "{impl#58}", scope: !99)
!149 = !DISubroutineType(types: !150)
!150 = !{!98, !7}
!151 = !{!152}
!152 = !DILocalVariable(arg: 1, scope: !147, file: !97, line: 2690, type: !7)
!153 = !DILocation(line: 2690, column: 15, scope: !147)
!154 = !DILocation(line: 2692, column: 6, scope: !147)
!155 = distinct !DISubprogram(name: "call_once<fn(), ()>", linkageName: "_RNvYFEuINtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !125, file: !124, line: 250, type: !60, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !159, retainedNodes: !156)
!156 = !{!157, !158}
!157 = !DILocalVariable(arg: 1, scope: !155, file: !124, line: 250, type: !20)
!158 = !DILocalVariable(arg: 2, scope: !155, file: !124, line: 250, type: !7)
!159 = !{!160, !136}
!160 = !DITemplateTypeParameter(name: "Self", type: !20)
!161 = !DILocation(line: 250, column: 5, scope: !155)
!162 = distinct !DISubprogram(name: "call_once<std::rt::lang_start::{closure_env#0}<()>, ()>", linkageName: "_RNvYNCINvNtCs6ZjlLoI6YmX_3std2rt10lang_startuE0INtNtNtCsc36rpYXAlPq_4core3ops8function6FnOnceuE9call_onceCs2EIjc6ZEoKu_10test_buggy", scope: !125, file: !124, line: 250, type: !163, scopeLine: 250, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !134, retainedNodes: !165)
!163 = !DISubroutineType(types: !164)
!164 = !{!87, !14}
!165 = !{!166, !167}
!166 = !DILocalVariable(arg: 1, scope: !162, file: !124, line: 250, type: !14)
!167 = !DILocalVariable(arg: 2, scope: !162, file: !124, line: 250, type: !7)
!168 = !DILocation(line: 250, column: 5, scope: !162)
!169 = distinct !DISubprogram(name: "caller_hash_pipeline", scope: !140, file: !139, line: 32, type: !170, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !173)
!170 = !DISubroutineType(types: !171)
!171 = !{!87, !172, !172}
!172 = !DIBasicType(name: "u32", size: 32, encoding: DW_ATE_unsigned)
!173 = !{!174, !175, !176}
!174 = !DILocalVariable(name: "word1", arg: 1, scope: !169, file: !139, line: 32, type: !172)
!175 = !DILocalVariable(name: "word2", arg: 2, scope: !169, file: !139, line: 32, type: !172)
!176 = !DILocalVariable(name: "h", scope: !177, file: !139, line: 33, type: !172, align: 32)
!177 = distinct !DILexicalBlock(scope: !169, file: !139, line: 33, column: 5)
!178 = !DILocation(line: 32, column: 40, scope: !169)
!179 = !DILocation(line: 32, column: 52, scope: !169)
!180 = !DILocation(line: 33, column: 9, scope: !177)
!181 = !DILocation(line: 33, column: 17, scope: !169)
!182 = !DILocation(line: 35, column: 9, scope: !177)
!183 = !DILocation(line: 37, column: 20, scope: !177)
!184 = !DILocation(line: 37, column: 5, scope: !177)
!185 = !DILocation(line: 38, column: 2, scope: !169)
!186 = distinct !DISubprogram(name: "hash_avalanche", scope: !140, file: !139, line: 15, type: !187, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !189)
!187 = !DISubroutineType(types: !188)
!188 = !{!172, !172}
!189 = !{!190}
!190 = !DILocalVariable(name: "h", arg: 1, scope: !186, file: !139, line: 15, type: !172)
!191 = !DILocation(line: 15, column: 34, scope: !186)
!192 = !DILocation(line: 17, column: 10, scope: !186)
!193 = !DILocation(line: 17, column: 5, scope: !186)
!194 = !DILocation(line: 18, column: 9, scope: !186)
!195 = !DILocalVariable(name: "self", arg: 1, scope: !196, file: !197, line: 2687, type: !172)
!196 = distinct !DISubprogram(name: "wrapping_mul", linkageName: "_RNvMs6_NtCsc36rpYXAlPq_4core3numm12wrapping_mul", scope: !198, file: !197, line: 2687, type: !200, scopeLine: 2687, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !202)
!197 = !DIFile(filename: "library/core/src/num/uint_macros.rs", directory: "/rustc/88d9e12ae178fab0fb5cc050a94da85685d449ea", checksumkind: CSK_MD5, checksum: "0ccbfbe7fddb6564280e91d430f1b663")
!198 = !DINamespace(name: "{impl#8}", scope: !199)
!199 = !DINamespace(name: "num", scope: !74)
!200 = !DISubroutineType(types: !201)
!201 = !{!172, !172, !172}
!202 = !{!195, !203}
!203 = !DILocalVariable(name: "rhs", arg: 2, scope: !196, file: !197, line: 2687, type: !172)
!204 = !DILocation(line: 2687, column: 35, scope: !196, inlinedAt: !205)
!205 = distinct !DILocation(line: 18, column: 11, scope: !186)
!206 = !DILocation(line: 2687, column: 41, scope: !196, inlinedAt: !205)
!207 = !DILocation(line: 2688, column: 13, scope: !196, inlinedAt: !205)
!208 = !DILocation(line: 18, column: 5, scope: !186)
!209 = !DILocation(line: 19, column: 10, scope: !186)
!210 = !DILocation(line: 19, column: 5, scope: !186)
!211 = !DILocation(line: 20, column: 9, scope: !186)
!212 = !DILocation(line: 2687, column: 35, scope: !196, inlinedAt: !213)
!213 = distinct !DILocation(line: 20, column: 11, scope: !186)
!214 = !DILocation(line: 2687, column: 41, scope: !196, inlinedAt: !213)
!215 = !DILocation(line: 2688, column: 13, scope: !196, inlinedAt: !213)
!216 = !DILocation(line: 20, column: 5, scope: !186)
!217 = !DILocation(line: 21, column: 10, scope: !186)
!218 = !DILocation(line: 21, column: 5, scope: !186)
!219 = !DILocation(line: 22, column: 5, scope: !186)
!220 = !DILocation(line: 23, column: 2, scope: !186)
!221 = distinct !DISubprogram(name: "hash_init", scope: !140, file: !139, line: 5, type: !222, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23)
!222 = !DISubroutineType(types: !223)
!223 = !{!172}
!224 = !DILocation(line: 7, column: 2, scope: !221)
!225 = distinct !DISubprogram(name: "hash_step", scope: !140, file: !139, line: 10, type: !200, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !226)
!226 = !{!227, !228}
!227 = !DILocalVariable(name: "current_hash", arg: 1, scope: !225, file: !139, line: 10, type: !172)
!228 = !DILocalVariable(name: "byte_val", arg: 2, scope: !225, file: !139, line: 10, type: !172)
!229 = !DILocation(line: 10, column: 29, scope: !225)
!230 = !DILocation(line: 10, column: 48, scope: !225)
!231 = !DILocation(line: 11, column: 21, scope: !225)
!232 = !DILocation(line: 11, column: 5, scope: !225)
!233 = !DILocation(line: 2687, column: 35, scope: !196, inlinedAt: !234)
!234 = distinct !DILocation(line: 11, column: 40, scope: !225)
!235 = !DILocation(line: 2687, column: 41, scope: !196, inlinedAt: !234)
!236 = !DILocation(line: 2688, column: 13, scope: !196, inlinedAt: !234)
!237 = !DILocation(line: 12, column: 2, scope: !225)
!238 = distinct !DISubprogram(name: "hash_update_token", scope: !140, file: !139, line: 26, type: !239, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !31, templateParams: !23, retainedNodes: !242)
!239 = !DISubroutineType(types: !240)
!240 = !{null, !241, !172, !172}
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, name: "*mut u32", baseType: !172, size: 64, align: 64, dwarfAddressSpace: 0)
!242 = !{!243, !244, !245}
!243 = !DILocalVariable(name: "hash_state", arg: 1, scope: !238, file: !139, line: 26, type: !241)
!244 = !DILocalVariable(name: "part1", arg: 2, scope: !238, file: !139, line: 26, type: !172)
!245 = !DILocalVariable(name: "part2", arg: 3, scope: !238, file: !139, line: 26, type: !172)
!246 = !DILocation(line: 26, column: 44, scope: !238)
!247 = !DILocation(line: 26, column: 66, scope: !238)
!248 = !DILocation(line: 26, column: 78, scope: !238)
!249 = !DILocation(line: 27, column: 29, scope: !238)
!250 = !DILocation(line: 27, column: 19, scope: !238)
!251 = !DILocation(line: 27, column: 5, scope: !238)
!252 = !DILocation(line: 28, column: 29, scope: !238)
!253 = !DILocation(line: 28, column: 19, scope: !238)
!254 = !DILocation(line: 28, column: 5, scope: !238)
!255 = !DILocation(line: 29, column: 2, scope: !238)
