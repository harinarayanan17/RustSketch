; ModuleID = 'tests2/global_state/test.c'
source_filename = "tests2/global_state/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@g_counter = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @helper_inc(i32 noundef %val) #0 !dbg !14 {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %val.addr, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load i32, ptr %val.addr, align 4, !dbg !20
  %1 = load i32, ptr @g_counter, align 4, !dbg !21
  %add = add nsw i32 %1, %0, !dbg !21
  store i32 %add, ptr @g_counter, align 4, !dbg !21
  %2 = load i32, ptr @g_counter, align 4, !dbg !22
  ret i32 %2, !dbg !23
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_work(i32 noundef %x) #0 !dbg !24 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !25, metadata !DIExpression()), !dbg !26
  %0 = load i32, ptr %x.addr, align 4, !dbg !27
  %mul = mul nsw i32 %0, 2, !dbg !28
  %call = call i32 @helper_inc(i32 noundef %mul), !dbg !29
  ret i32 %call, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !31 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_work(i32 noundef 1), !dbg !34
  ret i32 %call, !dbg !35
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g_counter", scope: !2, file: !3, line: 1, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests2/global_state/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "20fcf76a2191cf576561ba4d3c9f38b7")
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
!14 = distinct !DISubprogram(name: "helper_inc", scope: !3, file: !3, line: 3, type: !15, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!15 = !DISubroutineType(types: !16)
!16 = !{!5, !5}
!17 = !{}
!18 = !DILocalVariable(name: "val", arg: 1, scope: !14, file: !3, line: 3, type: !5)
!19 = !DILocation(line: 3, column: 20, scope: !14)
!20 = !DILocation(line: 4, column: 18, scope: !14)
!21 = !DILocation(line: 4, column: 15, scope: !14)
!22 = !DILocation(line: 5, column: 12, scope: !14)
!23 = !DILocation(line: 5, column: 5, scope: !14)
!24 = distinct !DISubprogram(name: "caller_work", scope: !3, file: !3, line: 8, type: !15, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!25 = !DILocalVariable(name: "x", arg: 1, scope: !24, file: !3, line: 8, type: !5)
!26 = !DILocation(line: 8, column: 21, scope: !24)
!27 = !DILocation(line: 9, column: 23, scope: !24)
!28 = !DILocation(line: 9, column: 25, scope: !24)
!29 = !DILocation(line: 9, column: 12, scope: !24)
!30 = !DILocation(line: 9, column: 5, scope: !24)
!31 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 12, type: !32, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!5}
!34 = !DILocation(line: 13, column: 12, scope: !31)
!35 = !DILocation(line: 13, column: 5, scope: !31)
