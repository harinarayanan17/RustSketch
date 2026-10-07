; ModuleID = 'tests2/double_pointer/test.c'
source_filename = "tests2/double_pointer/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @reset_ptr(ptr noundef %p) #0 !dbg !10 {
entry:
  %p.addr = alloca ptr, align 8
  store ptr %p, ptr %p.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %p.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load ptr, ptr %p.addr, align 8, !dbg !19
  store ptr null, ptr %0, align 8, !dbg !20
  ret void, !dbg !21
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_reset() #0 !dbg !22 {
entry:
  %target = alloca i32, align 4
  %p = alloca ptr, align 8
  call void @llvm.dbg.declare(metadata ptr %target, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 42, ptr %target, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata ptr %p, metadata !27, metadata !DIExpression()), !dbg !28
  store ptr %target, ptr %p, align 8, !dbg !28
  call void @reset_ptr(ptr noundef %p), !dbg !29
  %0 = load ptr, ptr %p, align 8, !dbg !30
  %cmp = icmp eq ptr %0, null, !dbg !31
  %1 = zext i1 %cmp to i64, !dbg !32
  %cond = select i1 %cmp, i32 1, i32 0, !dbg !32
  ret i32 %cond, !dbg !33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !34 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_reset(), !dbg !35
  ret i32 %call, !dbg !36
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/double_pointer/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "1bbf790022a3acfb8717a3a60894c9bb")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "reset_ptr", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{}
!17 = !DILocalVariable(name: "p", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!18 = !DILocation(line: 1, column: 22, scope: !10)
!19 = !DILocation(line: 2, column: 6, scope: !10)
!20 = !DILocation(line: 2, column: 8, scope: !10)
!21 = !DILocation(line: 3, column: 1, scope: !10)
!22 = distinct !DISubprogram(name: "caller_reset", scope: !1, file: !1, line: 5, type: !23, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !16)
!23 = !DISubroutineType(types: !24)
!24 = !{!15}
!25 = !DILocalVariable(name: "target", scope: !22, file: !1, line: 6, type: !15)
!26 = !DILocation(line: 6, column: 9, scope: !22)
!27 = !DILocalVariable(name: "p", scope: !22, file: !1, line: 7, type: !14)
!28 = !DILocation(line: 7, column: 10, scope: !22)
!29 = !DILocation(line: 8, column: 5, scope: !22)
!30 = !DILocation(line: 9, column: 13, scope: !22)
!31 = !DILocation(line: 9, column: 15, scope: !22)
!32 = !DILocation(line: 9, column: 12, scope: !22)
!33 = !DILocation(line: 9, column: 5, scope: !22)
!34 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !23, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0)
!35 = !DILocation(line: 13, column: 12, scope: !34)
!36 = !DILocation(line: 13, column: 5, scope: !34)
