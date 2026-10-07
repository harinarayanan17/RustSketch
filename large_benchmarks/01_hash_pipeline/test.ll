; ModuleID = 'large_benchmarks/01_hash_pipeline/test.c'
source_filename = "large_benchmarks/01_hash_pipeline/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hash_init() #0 !dbg !12 {
entry:
  ret i32 -2128831035, !dbg !16
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hash_step(i32 noundef %current_hash, i32 noundef %byte_val) #0 !dbg !17 {
entry:
  %current_hash.addr = alloca i32, align 4
  %byte_val.addr = alloca i32, align 4
  store i32 %current_hash, ptr %current_hash.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %current_hash.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 %byte_val, ptr %byte_val.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %byte_val.addr, metadata !23, metadata !DIExpression()), !dbg !24
  %0 = load i32, ptr %current_hash.addr, align 4, !dbg !25
  %1 = load i32, ptr %byte_val.addr, align 4, !dbg !26
  %and = and i32 %1, 255, !dbg !27
  %xor = xor i32 %0, %and, !dbg !28
  %mul = mul i32 %xor, 16777619, !dbg !29
  ret i32 %mul, !dbg !30
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @hash_avalanche(i32 noundef %h) #0 !dbg !31 {
entry:
  %h.addr = alloca i32, align 4
  store i32 %h, ptr %h.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %h.addr, metadata !34, metadata !DIExpression()), !dbg !35
  %0 = load i32, ptr %h.addr, align 4, !dbg !36
  %shr = lshr i32 %0, 16, !dbg !37
  %1 = load i32, ptr %h.addr, align 4, !dbg !38
  %xor = xor i32 %1, %shr, !dbg !38
  store i32 %xor, ptr %h.addr, align 4, !dbg !38
  %2 = load i32, ptr %h.addr, align 4, !dbg !39
  %mul = mul i32 %2, -2048144789, !dbg !39
  store i32 %mul, ptr %h.addr, align 4, !dbg !39
  %3 = load i32, ptr %h.addr, align 4, !dbg !40
  %shr1 = lshr i32 %3, 13, !dbg !41
  %4 = load i32, ptr %h.addr, align 4, !dbg !42
  %xor2 = xor i32 %4, %shr1, !dbg !42
  store i32 %xor2, ptr %h.addr, align 4, !dbg !42
  %5 = load i32, ptr %h.addr, align 4, !dbg !43
  %mul3 = mul i32 %5, -1028477387, !dbg !43
  store i32 %mul3, ptr %h.addr, align 4, !dbg !43
  %6 = load i32, ptr %h.addr, align 4, !dbg !44
  %shr4 = lshr i32 %6, 16, !dbg !45
  %7 = load i32, ptr %h.addr, align 4, !dbg !46
  %xor5 = xor i32 %7, %shr4, !dbg !46
  store i32 %xor5, ptr %h.addr, align 4, !dbg !46
  %8 = load i32, ptr %h.addr, align 4, !dbg !47
  ret i32 %8, !dbg !48
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @hash_update_token(ptr noundef %hash_state, i32 noundef %part1, i32 noundef %part2) #0 !dbg !49 {
entry:
  %hash_state.addr = alloca ptr, align 8
  %part1.addr = alloca i32, align 4
  %part2.addr = alloca i32, align 4
  store ptr %hash_state, ptr %hash_state.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %hash_state.addr, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 %part1, ptr %part1.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %part1.addr, metadata !55, metadata !DIExpression()), !dbg !56
  store i32 %part2, ptr %part2.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %part2.addr, metadata !57, metadata !DIExpression()), !dbg !58
  %0 = load ptr, ptr %hash_state.addr, align 8, !dbg !59
  %1 = load i32, ptr %0, align 4, !dbg !60
  %2 = load i32, ptr %part1.addr, align 4, !dbg !61
  %call = call i32 @hash_step(i32 noundef %1, i32 noundef %2), !dbg !62
  %3 = load ptr, ptr %hash_state.addr, align 8, !dbg !63
  store i32 %call, ptr %3, align 4, !dbg !64
  %4 = load ptr, ptr %hash_state.addr, align 8, !dbg !65
  %5 = load i32, ptr %4, align 4, !dbg !66
  %6 = load i32, ptr %part2.addr, align 4, !dbg !67
  %call1 = call i32 @hash_step(i32 noundef %5, i32 noundef %6), !dbg !68
  %7 = load ptr, ptr %hash_state.addr, align 8, !dbg !69
  store i32 %call1, ptr %7, align 4, !dbg !70
  ret void, !dbg !71
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_hash_pipeline(i32 noundef %word1, i32 noundef %word2) #0 !dbg !72 {
entry:
  %word1.addr = alloca i32, align 4
  %word2.addr = alloca i32, align 4
  %h = alloca i32, align 4
  store i32 %word1, ptr %word1.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %word1.addr, metadata !75, metadata !DIExpression()), !dbg !76
  store i32 %word2, ptr %word2.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %word2.addr, metadata !77, metadata !DIExpression()), !dbg !78
  call void @llvm.dbg.declare(metadata ptr %h, metadata !79, metadata !DIExpression()), !dbg !80
  %call = call i32 @hash_init(), !dbg !81
  store i32 %call, ptr %h, align 4, !dbg !80
  %0 = load i32, ptr %word1.addr, align 4, !dbg !82
  %1 = load i32, ptr %word2.addr, align 4, !dbg !83
  call void @hash_update_token(ptr noundef %h, i32 noundef %0, i32 noundef %1), !dbg !84
  %2 = load i32, ptr %h, align 4, !dbg !85
  %call1 = call i32 @hash_avalanche(i32 noundef %2), !dbg !86
  ret i32 %call1, !dbg !87
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !88 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_hash_pipeline(i32 noundef 4660, i32 noundef 22136), !dbg !90
  ret i32 %call, !dbg !91
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!4, !5, !6, !7, !8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "large_benchmarks/01_hash_pipeline/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "678dc5299aef4770e0e4e56d34ec5910")
!2 = !{!3}
!3 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!4 = !{i32 7, !"Dwarf Version", i32 5}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 8, !"PIC Level", i32 2}
!8 = !{i32 7, !"PIE Level", i32 2}
!9 = !{i32 7, !"uwtable", i32 2}
!10 = !{i32 7, !"frame-pointer", i32 2}
!11 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!12 = distinct !DISubprogram(name: "hash_init", scope: !1, file: !1, line: 4, type: !13, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0)
!13 = !DISubroutineType(types: !14)
!14 = !{!15}
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !DILocation(line: 5, column: 5, scope: !12)
!17 = distinct !DISubprogram(name: "hash_step", scope: !1, file: !1, line: 8, type: !18, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !20)
!18 = !DISubroutineType(types: !19)
!19 = !{!15, !15, !15}
!20 = !{}
!21 = !DILocalVariable(name: "current_hash", arg: 1, scope: !17, file: !1, line: 8, type: !15)
!22 = !DILocation(line: 8, column: 37, scope: !17)
!23 = !DILocalVariable(name: "byte_val", arg: 2, scope: !17, file: !1, line: 8, type: !15)
!24 = !DILocation(line: 8, column: 64, scope: !17)
!25 = !DILocation(line: 9, column: 13, scope: !17)
!26 = !DILocation(line: 9, column: 29, scope: !17)
!27 = !DILocation(line: 9, column: 38, scope: !17)
!28 = !DILocation(line: 9, column: 26, scope: !17)
!29 = !DILocation(line: 9, column: 47, scope: !17)
!30 = !DILocation(line: 9, column: 5, scope: !17)
!31 = distinct !DISubprogram(name: "hash_avalanche", scope: !1, file: !1, line: 12, type: !32, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !20)
!32 = !DISubroutineType(types: !33)
!33 = !{!15, !15}
!34 = !DILocalVariable(name: "h", arg: 1, scope: !31, file: !1, line: 12, type: !15)
!35 = !DILocation(line: 12, column: 42, scope: !31)
!36 = !DILocation(line: 13, column: 10, scope: !31)
!37 = !DILocation(line: 13, column: 12, scope: !31)
!38 = !DILocation(line: 13, column: 7, scope: !31)
!39 = !DILocation(line: 14, column: 7, scope: !31)
!40 = !DILocation(line: 15, column: 10, scope: !31)
!41 = !DILocation(line: 15, column: 12, scope: !31)
!42 = !DILocation(line: 15, column: 7, scope: !31)
!43 = !DILocation(line: 16, column: 7, scope: !31)
!44 = !DILocation(line: 17, column: 10, scope: !31)
!45 = !DILocation(line: 17, column: 12, scope: !31)
!46 = !DILocation(line: 17, column: 7, scope: !31)
!47 = !DILocation(line: 18, column: 12, scope: !31)
!48 = !DILocation(line: 18, column: 5, scope: !31)
!49 = distinct !DISubprogram(name: "hash_update_token", scope: !1, file: !1, line: 21, type: !50, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !20)
!50 = !DISubroutineType(types: !51)
!51 = !{null, !52, !15, !15}
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!53 = !DILocalVariable(name: "hash_state", arg: 1, scope: !49, file: !1, line: 21, type: !52)
!54 = !DILocation(line: 21, column: 38, scope: !49)
!55 = !DILocalVariable(name: "part1", arg: 2, scope: !49, file: !1, line: 21, type: !15)
!56 = !DILocation(line: 21, column: 63, scope: !49)
!57 = !DILocalVariable(name: "part2", arg: 3, scope: !49, file: !1, line: 21, type: !15)
!58 = !DILocation(line: 21, column: 83, scope: !49)
!59 = !DILocation(line: 22, column: 30, scope: !49)
!60 = !DILocation(line: 22, column: 29, scope: !49)
!61 = !DILocation(line: 22, column: 42, scope: !49)
!62 = !DILocation(line: 22, column: 19, scope: !49)
!63 = !DILocation(line: 22, column: 6, scope: !49)
!64 = !DILocation(line: 22, column: 17, scope: !49)
!65 = !DILocation(line: 23, column: 30, scope: !49)
!66 = !DILocation(line: 23, column: 29, scope: !49)
!67 = !DILocation(line: 23, column: 42, scope: !49)
!68 = !DILocation(line: 23, column: 19, scope: !49)
!69 = !DILocation(line: 23, column: 6, scope: !49)
!70 = !DILocation(line: 23, column: 17, scope: !49)
!71 = !DILocation(line: 24, column: 1, scope: !49)
!72 = distinct !DISubprogram(name: "caller_hash_pipeline", scope: !1, file: !1, line: 26, type: !73, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !20)
!73 = !DISubroutineType(types: !74)
!74 = !{!3, !15, !15}
!75 = !DILocalVariable(name: "word1", arg: 1, scope: !72, file: !1, line: 26, type: !15)
!76 = !DILocation(line: 26, column: 39, scope: !72)
!77 = !DILocalVariable(name: "word2", arg: 2, scope: !72, file: !1, line: 26, type: !15)
!78 = !DILocation(line: 26, column: 59, scope: !72)
!79 = !DILocalVariable(name: "h", scope: !72, file: !1, line: 27, type: !15)
!80 = !DILocation(line: 27, column: 18, scope: !72)
!81 = !DILocation(line: 27, column: 22, scope: !72)
!82 = !DILocation(line: 28, column: 27, scope: !72)
!83 = !DILocation(line: 28, column: 34, scope: !72)
!84 = !DILocation(line: 28, column: 5, scope: !72)
!85 = !DILocation(line: 29, column: 32, scope: !72)
!86 = !DILocation(line: 29, column: 17, scope: !72)
!87 = !DILocation(line: 29, column: 5, scope: !72)
!88 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 32, type: !89, scopeLine: 32, spFlags: DISPFlagDefinition, unit: !0)
!89 = !DISubroutineType(types: !2)
!90 = !DILocation(line: 33, column: 12, scope: !88)
!91 = !DILocation(line: 33, column: 5, scope: !88)
