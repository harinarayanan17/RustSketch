; ModuleID = 'tests2/composition/test.c'
source_filename = "tests2/composition/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @helper_step1(i32 noundef %a) #0 !dbg !10 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, ptr %a.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %a.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, ptr %a.addr, align 4, !dbg !17
  %mul = mul nsw i32 %0, 2, !dbg !18
  %add = add nsw i32 %mul, 3, !dbg !19
  ret i32 %add, !dbg !20
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @helper_step2(i32 noundef %b) #0 !dbg !21 {
entry:
  %b.addr = alloca i32, align 4
  store i32 %b, ptr %b.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %b.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32, ptr %b.addr, align 4, !dbg !24
  %xor = xor i32 %0, 15, !dbg !25
  ret i32 %xor, !dbg !26
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @helper_step3(ptr noundef %state, i32 noundef %factor) #0 !dbg !27 {
entry:
  %state.addr = alloca ptr, align 8
  %factor.addr = alloca i32, align 4
  store ptr %state, ptr %state.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %state.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store i32 %factor, ptr %factor.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %factor.addr, metadata !33, metadata !DIExpression()), !dbg !34
  %0 = load ptr, ptr %state.addr, align 8, !dbg !35
  %1 = load i32, ptr %0, align 4, !dbg !36
  %2 = load i32, ptr %factor.addr, align 4, !dbg !37
  %add = add nsw i32 %1, %2, !dbg !38
  %3 = load ptr, ptr %state.addr, align 8, !dbg !39
  store i32 %add, ptr %3, align 4, !dbg !40
  ret void, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_pipeline(i32 noundef %input, i32 noundef %factor) #0 !dbg !42 {
entry:
  %input.addr = alloca i32, align 4
  %factor.addr = alloca i32, align 4
  %s1 = alloca i32, align 4
  %s2 = alloca i32, align 4
  %res = alloca i32, align 4
  store i32 %input, ptr %input.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %input.addr, metadata !45, metadata !DIExpression()), !dbg !46
  store i32 %factor, ptr %factor.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %factor.addr, metadata !47, metadata !DIExpression()), !dbg !48
  call void @llvm.dbg.declare(metadata ptr %s1, metadata !49, metadata !DIExpression()), !dbg !50
  %0 = load i32, ptr %input.addr, align 4, !dbg !51
  %call = call i32 @helper_step1(i32 noundef %0), !dbg !52
  store i32 %call, ptr %s1, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata ptr %s2, metadata !53, metadata !DIExpression()), !dbg !54
  %1 = load i32, ptr %s1, align 4, !dbg !55
  %call1 = call i32 @helper_step2(i32 noundef %1), !dbg !56
  store i32 %call1, ptr %s2, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata ptr %res, metadata !57, metadata !DIExpression()), !dbg !58
  %2 = load i32, ptr %s2, align 4, !dbg !59
  store i32 %2, ptr %res, align 4, !dbg !58
  %3 = load i32, ptr %factor.addr, align 4, !dbg !60
  call void @helper_step3(ptr noundef %res, i32 noundef %3), !dbg !61
  %4 = load i32, ptr %res, align 4, !dbg !62
  ret i32 %4, !dbg !63
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !64 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_pipeline(i32 noundef 10, i32 noundef 5), !dbg !67
  ret i32 %call, !dbg !68
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/composition/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "715a44ebe4d6dbb57052dc9b31e86782")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "helper_step1", scope: !1, file: !1, line: 1, type: !11, scopeLine: 1, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{}
!15 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 1, type: !13)
!16 = !DILocation(line: 1, column: 22, scope: !10)
!17 = !DILocation(line: 2, column: 12, scope: !10)
!18 = !DILocation(line: 2, column: 14, scope: !10)
!19 = !DILocation(line: 2, column: 18, scope: !10)
!20 = !DILocation(line: 2, column: 5, scope: !10)
!21 = distinct !DISubprogram(name: "helper_step2", scope: !1, file: !1, line: 5, type: !11, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!22 = !DILocalVariable(name: "b", arg: 1, scope: !21, file: !1, line: 5, type: !13)
!23 = !DILocation(line: 5, column: 22, scope: !21)
!24 = !DILocation(line: 6, column: 12, scope: !21)
!25 = !DILocation(line: 6, column: 14, scope: !21)
!26 = !DILocation(line: 6, column: 5, scope: !21)
!27 = distinct !DISubprogram(name: "helper_step3", scope: !1, file: !1, line: 9, type: !28, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!28 = !DISubroutineType(types: !29)
!29 = !{null, !30, !13}
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!31 = !DILocalVariable(name: "state", arg: 1, scope: !27, file: !1, line: 9, type: !30)
!32 = !DILocation(line: 9, column: 24, scope: !27)
!33 = !DILocalVariable(name: "factor", arg: 2, scope: !27, file: !1, line: 9, type: !13)
!34 = !DILocation(line: 9, column: 35, scope: !27)
!35 = !DILocation(line: 10, column: 16, scope: !27)
!36 = !DILocation(line: 10, column: 15, scope: !27)
!37 = !DILocation(line: 10, column: 25, scope: !27)
!38 = !DILocation(line: 10, column: 23, scope: !27)
!39 = !DILocation(line: 10, column: 6, scope: !27)
!40 = !DILocation(line: 10, column: 12, scope: !27)
!41 = !DILocation(line: 11, column: 1, scope: !27)
!42 = distinct !DISubprogram(name: "caller_pipeline", scope: !1, file: !1, line: 13, type: !43, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !14)
!43 = !DISubroutineType(types: !44)
!44 = !{!13, !13, !13}
!45 = !DILocalVariable(name: "input", arg: 1, scope: !42, file: !1, line: 13, type: !13)
!46 = !DILocation(line: 13, column: 25, scope: !42)
!47 = !DILocalVariable(name: "factor", arg: 2, scope: !42, file: !1, line: 13, type: !13)
!48 = !DILocation(line: 13, column: 36, scope: !42)
!49 = !DILocalVariable(name: "s1", scope: !42, file: !1, line: 14, type: !13)
!50 = !DILocation(line: 14, column: 9, scope: !42)
!51 = !DILocation(line: 14, column: 27, scope: !42)
!52 = !DILocation(line: 14, column: 14, scope: !42)
!53 = !DILocalVariable(name: "s2", scope: !42, file: !1, line: 15, type: !13)
!54 = !DILocation(line: 15, column: 9, scope: !42)
!55 = !DILocation(line: 15, column: 27, scope: !42)
!56 = !DILocation(line: 15, column: 14, scope: !42)
!57 = !DILocalVariable(name: "res", scope: !42, file: !1, line: 16, type: !13)
!58 = !DILocation(line: 16, column: 9, scope: !42)
!59 = !DILocation(line: 16, column: 15, scope: !42)
!60 = !DILocation(line: 17, column: 24, scope: !42)
!61 = !DILocation(line: 17, column: 5, scope: !42)
!62 = !DILocation(line: 18, column: 12, scope: !42)
!63 = !DILocation(line: 18, column: 5, scope: !42)
!64 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 21, type: !65, scopeLine: 21, spFlags: DISPFlagDefinition, unit: !0)
!65 = !DISubroutineType(types: !66)
!66 = !{!13}
!67 = !DILocation(line: 22, column: 12, scope: !64)
!68 = !DILocation(line: 22, column: 5, scope: !64)
