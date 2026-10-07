; ModuleID = 'tests2/aliasing/test.c'
source_filename = "tests2/aliasing/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @update_alias(ptr noundef %a, ptr noundef %b) #0 !dbg !10 {
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  store ptr %a, ptr %a.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store ptr %b, ptr %b.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %b.addr, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load ptr, ptr %a.addr, align 8, !dbg !20
  store i32 15, ptr %0, align 4, !dbg !21
  %1 = load ptr, ptr %b.addr, align 8, !dbg !22
  store i32 30, ptr %1, align 4, !dbg !23
  ret void, !dbg !24
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_alias() #0 !dbg !25 {
entry:
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata ptr %x, metadata !28, metadata !DIExpression()), !dbg !29
  store i32 0, ptr %x, align 4, !dbg !29
  call void @update_alias(ptr noundef %x, ptr noundef %x), !dbg !30
  %0 = load i32, ptr %x, align 4, !dbg !31
  ret i32 %0, !dbg !32
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !33 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_alias(), !dbg !34
  ret i32 %call, !dbg !35
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/aliasing/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "fda0f6a230e21e7978125ef4a223c196")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "update_alias", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !{}
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!17 = !DILocation(line: 1, column: 24, scope: !10)
!18 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !1, line: 1, type: !13)
!19 = !DILocation(line: 1, column: 32, scope: !10)
!20 = !DILocation(line: 2, column: 6, scope: !10)
!21 = !DILocation(line: 2, column: 8, scope: !10)
!22 = !DILocation(line: 3, column: 6, scope: !10)
!23 = !DILocation(line: 3, column: 8, scope: !10)
!24 = !DILocation(line: 4, column: 1, scope: !10)
!25 = distinct !DISubprogram(name: "caller_alias", scope: !1, file: !1, line: 6, type: !26, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!26 = !DISubroutineType(types: !27)
!27 = !{!14}
!28 = !DILocalVariable(name: "x", scope: !25, file: !1, line: 7, type: !14)
!29 = !DILocation(line: 7, column: 9, scope: !25)
!30 = !DILocation(line: 8, column: 5, scope: !25)
!31 = !DILocation(line: 9, column: 12, scope: !25)
!32 = !DILocation(line: 9, column: 5, scope: !25)
!33 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !26, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0)
!34 = !DILocation(line: 13, column: 12, scope: !33)
!35 = !DILocation(line: 13, column: 5, scope: !33)
