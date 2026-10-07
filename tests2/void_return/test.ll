; ModuleID = 'tests2/void_return/test.c'
source_filename = "tests2/void_return/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @update_buffer(ptr noundef %ptr, i32 noundef %val) #0 !dbg !10 {
entry:
  %ptr.addr = alloca ptr, align 8
  %val.addr = alloca i32, align 4
  store ptr %ptr, ptr %ptr.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %ptr.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 %val, ptr %val.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %val.addr, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load i32, ptr %val.addr, align 4, !dbg !20
  %xor = xor i32 %0, 66, !dbg !21
  %1 = load ptr, ptr %ptr.addr, align 8, !dbg !22
  store i32 %xor, ptr %1, align 4, !dbg !23
  ret void, !dbg !24
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_void_test(i32 noundef %input) #0 !dbg !25 {
entry:
  %input.addr = alloca i32, align 4
  %buf = alloca i32, align 4
  store i32 %input, ptr %input.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %input.addr, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata ptr %buf, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 0, ptr %buf, align 4, !dbg !31
  %0 = load i32, ptr %input.addr, align 4, !dbg !32
  call void @update_buffer(ptr noundef %buf, i32 noundef %0), !dbg !33
  %1 = load i32, ptr %buf, align 4, !dbg !34
  ret i32 %1, !dbg !35
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_void_test(i32 noundef 10), !dbg !39
  ret i32 %call, !dbg !40
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/void_return/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "2d1ee99fcc5f025015ac7d0f3927ee03")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "update_buffer", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !{}
!16 = !DILocalVariable(name: "ptr", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!17 = !DILocation(line: 1, column: 25, scope: !10)
!18 = !DILocalVariable(name: "val", arg: 2, scope: !10, file: !1, line: 1, type: !14)
!19 = !DILocation(line: 1, column: 34, scope: !10)
!20 = !DILocation(line: 2, column: 12, scope: !10)
!21 = !DILocation(line: 2, column: 16, scope: !10)
!22 = !DILocation(line: 2, column: 6, scope: !10)
!23 = !DILocation(line: 2, column: 10, scope: !10)
!24 = !DILocation(line: 3, column: 1, scope: !10)
!25 = distinct !DISubprogram(name: "caller_void_test", scope: !1, file: !1, line: 5, type: !26, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!26 = !DISubroutineType(types: !27)
!27 = !{!14, !14}
!28 = !DILocalVariable(name: "input", arg: 1, scope: !25, file: !1, line: 5, type: !14)
!29 = !DILocation(line: 5, column: 26, scope: !25)
!30 = !DILocalVariable(name: "buf", scope: !25, file: !1, line: 6, type: !14)
!31 = !DILocation(line: 6, column: 9, scope: !25)
!32 = !DILocation(line: 7, column: 25, scope: !25)
!33 = !DILocation(line: 7, column: 5, scope: !25)
!34 = !DILocation(line: 8, column: 12, scope: !25)
!35 = !DILocation(line: 8, column: 5, scope: !25)
!36 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !37, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !0)
!37 = !DISubroutineType(types: !38)
!38 = !{!14}
!39 = !DILocation(line: 12, column: 12, scope: !36)
!40 = !DILocation(line: 12, column: 5, scope: !36)
