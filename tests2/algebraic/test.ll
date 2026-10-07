; ModuleID = 'tests2/algebraic/test.c'
source_filename = "tests2/algebraic/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @helper_arith(i32 noundef %a, i32 noundef %b) #0 !dbg !10 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %a.addr, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 %b, ptr %b.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %b.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load i32, ptr %a.addr, align 4, !dbg !19
  %mul = mul nsw i32 %0, 3, !dbg !20
  %1 = load i32, ptr %b.addr, align 4, !dbg !21
  %add = add nsw i32 %mul, %1, !dbg !22
  %2 = load i32, ptr %a.addr, align 4, !dbg !23
  %3 = load i32, ptr %b.addr, align 4, !dbg !24
  %sub = sub nsw i32 %2, %3, !dbg !25
  %mul1 = mul nsw i32 %sub, 2, !dbg !26
  %xor = xor i32 %add, %mul1, !dbg !27
  ret i32 %xor, !dbg !28
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_eval(i32 noundef %x, i32 noundef %y) #0 !dbg !29 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 %y, ptr %y.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %y.addr, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i32, ptr %x.addr, align 4, !dbg !34
  %add = add nsw i32 %0, 1, !dbg !35
  %1 = load i32, ptr %y.addr, align 4, !dbg !36
  %sub = sub nsw i32 %1, 2, !dbg !37
  %call = call i32 @helper_arith(i32 noundef %add, i32 noundef %sub), !dbg !38
  ret i32 %call, !dbg !39
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_eval(i32 noundef 5, i32 noundef 7), !dbg !43
  ret i32 %call, !dbg !44
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/algebraic/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "9dda76c0e525bb5346ae9cb0856d07be")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "helper_arith", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!16 = !DILocation(line: 1, column: 22, scope: !10)
!17 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !1, line: 1, type: !13)
!18 = !DILocation(line: 1, column: 29, scope: !10)
!19 = !DILocation(line: 2, column: 13, scope: !10)
!20 = !DILocation(line: 2, column: 15, scope: !10)
!21 = !DILocation(line: 2, column: 21, scope: !10)
!22 = !DILocation(line: 2, column: 19, scope: !10)
!23 = !DILocation(line: 2, column: 28, scope: !10)
!24 = !DILocation(line: 2, column: 32, scope: !10)
!25 = !DILocation(line: 2, column: 30, scope: !10)
!26 = !DILocation(line: 2, column: 35, scope: !10)
!27 = !DILocation(line: 2, column: 24, scope: !10)
!28 = !DILocation(line: 2, column: 5, scope: !10)
!29 = distinct !DISubprogram(name: "caller_eval", scope: !1, file: !1, line: 5, type: !11, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!30 = !DILocalVariable(name: "x", arg: 1, scope: !29, file: !1, line: 5, type: !13)
!31 = !DILocation(line: 5, column: 21, scope: !29)
!32 = !DILocalVariable(name: "y", arg: 2, scope: !29, file: !1, line: 5, type: !13)
!33 = !DILocation(line: 5, column: 28, scope: !29)
!34 = !DILocation(line: 6, column: 25, scope: !29)
!35 = !DILocation(line: 6, column: 27, scope: !29)
!36 = !DILocation(line: 6, column: 32, scope: !29)
!37 = !DILocation(line: 6, column: 34, scope: !29)
!38 = !DILocation(line: 6, column: 12, scope: !29)
!39 = !DILocation(line: 6, column: 5, scope: !29)
!40 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 9, type: !41, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !0)
!41 = !DISubroutineType(types: !42)
!42 = !{!13}
!43 = !DILocation(line: 10, column: 12, scope: !40)
!44 = !DILocation(line: 10, column: 5, scope: !40)
