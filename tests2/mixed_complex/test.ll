; ModuleID = 'tests2/mixed_complex/test.c'
source_filename = "tests2/mixed_complex/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@g_counter = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @complex_op(ptr noundef %p, i32 noundef %delta) #0 !dbg !14 {
entry:
  %p.addr = alloca ptr, align 8
  %delta.addr = alloca i32, align 4
  store ptr %p, ptr %p.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %p.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 %delta, ptr %delta.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %delta.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32, ptr %delta.addr, align 4, !dbg !24
  %1 = load i32, ptr @g_counter, align 4, !dbg !25
  %add = add nsw i32 %1, %0, !dbg !25
  store i32 %add, ptr @g_counter, align 4, !dbg !25
  %2 = load ptr, ptr %p.addr, align 8, !dbg !26
  store ptr null, ptr %2, align 8, !dbg !27
  ret void, !dbg !28
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_complex(i32 noundef %delta) #0 !dbg !29 {
entry:
  %delta.addr = alloca i32, align 4
  %target = alloca i32, align 4
  %p = alloca ptr, align 8
  store i32 %delta, ptr %delta.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %delta.addr, metadata !32, metadata !DIExpression()), !dbg !33
  call void @llvm.dbg.declare(metadata ptr %target, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 50, ptr %target, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata ptr %p, metadata !36, metadata !DIExpression()), !dbg !37
  store ptr %target, ptr %p, align 8, !dbg !37
  %0 = load i32, ptr %delta.addr, align 4, !dbg !38
  call void @complex_op(ptr noundef %p, i32 noundef %0), !dbg !39
  %1 = load ptr, ptr %p, align 8, !dbg !40
  %cmp = icmp eq ptr %1, null, !dbg !41
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !42

cond.true:                                        ; preds = %entry
  %2 = load i32, ptr @g_counter, align 4, !dbg !43
  br label %cond.end, !dbg !42

cond.false:                                       ; preds = %entry
  br label %cond.end, !dbg !42

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %2, %cond.true ], [ -1, %cond.false ], !dbg !42
  ret i32 %cond, !dbg !44
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !45 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_complex(i32 noundef 10), !dbg !48
  ret i32 %call, !dbg !49
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g_counter", scope: !2, file: !3, line: 1, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests2/mixed_complex/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "fad61e737f9fd36ae153b01faa9ae8be")
!4 = !{!0}
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 8, !"PIC Level", i32 2}
!10 = !{i32 7, !"PIE Level", i32 2}
!11 = !{i32 7, !"uwtable", i32 2}
!12 = !{i32 7, !"frame-pointer", i32 2}
!13 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!14 = distinct !DISubprogram(name: "complex_op", scope: !3, file: !3, line: 3, type: !15, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !19)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !5}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!19 = !{}
!20 = !DILocalVariable(name: "p", arg: 1, scope: !14, file: !3, line: 3, type: !17)
!21 = !DILocation(line: 3, column: 23, scope: !14)
!22 = !DILocalVariable(name: "delta", arg: 2, scope: !14, file: !3, line: 3, type: !5)
!23 = !DILocation(line: 3, column: 30, scope: !14)
!24 = !DILocation(line: 4, column: 18, scope: !14)
!25 = !DILocation(line: 4, column: 15, scope: !14)
!26 = !DILocation(line: 5, column: 6, scope: !14)
!27 = !DILocation(line: 5, column: 8, scope: !14)
!28 = !DILocation(line: 6, column: 1, scope: !14)
!29 = distinct !DISubprogram(name: "caller_complex", scope: !3, file: !3, line: 8, type: !30, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !19)
!30 = !DISubroutineType(types: !31)
!31 = !{!5, !5}
!32 = !DILocalVariable(name: "delta", arg: 1, scope: !29, file: !3, line: 8, type: !5)
!33 = !DILocation(line: 8, column: 24, scope: !29)
!34 = !DILocalVariable(name: "target", scope: !29, file: !3, line: 9, type: !5)
!35 = !DILocation(line: 9, column: 9, scope: !29)
!36 = !DILocalVariable(name: "p", scope: !29, file: !3, line: 10, type: !18)
!37 = !DILocation(line: 10, column: 10, scope: !29)
!38 = !DILocation(line: 11, column: 20, scope: !29)
!39 = !DILocation(line: 11, column: 5, scope: !29)
!40 = !DILocation(line: 12, column: 13, scope: !29)
!41 = !DILocation(line: 12, column: 15, scope: !29)
!42 = !DILocation(line: 12, column: 12, scope: !29)
!43 = !DILocation(line: 12, column: 23, scope: !29)
!44 = !DILocation(line: 12, column: 5, scope: !29)
!45 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 15, type: !46, scopeLine: 15, spFlags: DISPFlagDefinition, unit: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!5}
!48 = !DILocation(line: 16, column: 12, scope: !45)
!49 = !DILocation(line: 16, column: 5, scope: !45)
