; ModuleID = 'tests2/interface_conformity/test.c'
source_filename = "tests2/interface_conformity/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @process_item(i32 noundef %x) #0 !dbg !10 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, ptr %x.addr, align 4, !dbg !17
  %mul = mul nsw i32 %0, 4, !dbg !18
  ret i32 %mul, !dbg !19
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_process(i32 noundef %val) #0 !dbg !20 {
entry:
  %val.addr = alloca i32, align 4
  store i32 %val, ptr %val.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %val.addr, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32, ptr %val.addr, align 4, !dbg !23
  %call = call i32 @process_item(i32 noundef %0), !dbg !24
  %add = add nsw i32 %call, 1, !dbg !25
  ret i32 %add, !dbg !26
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_process(i32 noundef 5), !dbg !30
  ret i32 %call, !dbg !31
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/interface_conformity/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "b7f1ab43462c499e271f3bc872f55c51")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "process_item", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "x", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!16 = !DILocation(line: 1, column: 22, scope: !10)
!17 = !DILocation(line: 2, column: 12, scope: !10)
!18 = !DILocation(line: 2, column: 14, scope: !10)
!19 = !DILocation(line: 2, column: 5, scope: !10)
!20 = distinct !DISubprogram(name: "caller_process", scope: !1, file: !1, line: 5, type: !11, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!21 = !DILocalVariable(name: "val", arg: 1, scope: !20, file: !1, line: 5, type: !13)
!22 = !DILocation(line: 5, column: 24, scope: !20)
!23 = !DILocation(line: 6, column: 25, scope: !20)
!24 = !DILocation(line: 6, column: 12, scope: !20)
!25 = !DILocation(line: 6, column: 30, scope: !20)
!26 = !DILocation(line: 6, column: 5, scope: !20)
!27 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 9, type: !28, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !0)
!28 = !DISubroutineType(types: !29)
!29 = !{!13}
!30 = !DILocation(line: 10, column: 12, scope: !27)
!31 = !DILocation(line: 10, column: 5, scope: !27)
