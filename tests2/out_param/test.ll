; ModuleID = 'tests2/out_param/test.c'
source_filename = "tests2/out_param/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @helper_scale(ptr noundef %val, i32 noundef %factor) #0 !dbg !10 {
entry:
  %val.addr = alloca ptr, align 8
  %factor.addr = alloca i32, align 4
  store ptr %val, ptr %val.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %val.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 %factor, ptr %factor.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %factor.addr, metadata !18, metadata !DIExpression()), !dbg !19
  %0 = load ptr, ptr %val.addr, align 8, !dbg !20
  %1 = load i32, ptr %0, align 4, !dbg !21
  %2 = load i32, ptr %factor.addr, align 4, !dbg !22
  %mul = mul nsw i32 %1, %2, !dbg !23
  %add = add nsw i32 %mul, 5, !dbg !24
  %3 = load ptr, ptr %val.addr, align 8, !dbg !25
  store i32 %add, ptr %3, align 4, !dbg !26
  ret void, !dbg !27
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_calc(i32 noundef %initial, i32 noundef %factor) #0 !dbg !28 {
entry:
  %initial.addr = alloca i32, align 4
  %factor.addr = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 %initial, ptr %initial.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %initial.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i32 %factor, ptr %factor.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %factor.addr, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata ptr %x, metadata !35, metadata !DIExpression()), !dbg !36
  %0 = load i32, ptr %initial.addr, align 4, !dbg !37
  store i32 %0, ptr %x, align 4, !dbg !36
  %1 = load i32, ptr %factor.addr, align 4, !dbg !38
  call void @helper_scale(ptr noundef %x, i32 noundef %1), !dbg !39
  %2 = load i32, ptr %x, align 4, !dbg !40
  ret i32 %2, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !42 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_calc(i32 noundef 10, i32 noundef 2), !dbg !45
  ret i32 %call, !dbg !46
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/out_param/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "12a830d04d7ebd84480f047ce4751ab1")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "helper_scale", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !{}
!16 = !DILocalVariable(name: "val", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!17 = !DILocation(line: 1, column: 24, scope: !10)
!18 = !DILocalVariable(name: "factor", arg: 2, scope: !10, file: !1, line: 1, type: !14)
!19 = !DILocation(line: 1, column: 33, scope: !10)
!20 = !DILocation(line: 2, column: 14, scope: !10)
!21 = !DILocation(line: 2, column: 13, scope: !10)
!22 = !DILocation(line: 2, column: 21, scope: !10)
!23 = !DILocation(line: 2, column: 19, scope: !10)
!24 = !DILocation(line: 2, column: 28, scope: !10)
!25 = !DILocation(line: 2, column: 6, scope: !10)
!26 = !DILocation(line: 2, column: 10, scope: !10)
!27 = !DILocation(line: 3, column: 1, scope: !10)
!28 = distinct !DISubprogram(name: "caller_calc", scope: !1, file: !1, line: 5, type: !29, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!29 = !DISubroutineType(types: !30)
!30 = !{!14, !14, !14}
!31 = !DILocalVariable(name: "initial", arg: 1, scope: !28, file: !1, line: 5, type: !14)
!32 = !DILocation(line: 5, column: 21, scope: !28)
!33 = !DILocalVariable(name: "factor", arg: 2, scope: !28, file: !1, line: 5, type: !14)
!34 = !DILocation(line: 5, column: 34, scope: !28)
!35 = !DILocalVariable(name: "x", scope: !28, file: !1, line: 6, type: !14)
!36 = !DILocation(line: 6, column: 9, scope: !28)
!37 = !DILocation(line: 6, column: 13, scope: !28)
!38 = !DILocation(line: 7, column: 22, scope: !28)
!39 = !DILocation(line: 7, column: 5, scope: !28)
!40 = !DILocation(line: 8, column: 12, scope: !28)
!41 = !DILocation(line: 8, column: 5, scope: !28)
!42 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !43, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !0)
!43 = !DISubroutineType(types: !44)
!44 = !{!14}
!45 = !DILocation(line: 12, column: 12, scope: !42)
!46 = !DILocation(line: 12, column: 5, scope: !42)
