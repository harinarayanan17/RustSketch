; ModuleID = 'tests2/memory_layout/test.c'
source_filename = "tests2/memory_layout/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.PaddedStruct = type { i8, i32 }
%union.ValueUnion = type { i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_union(ptr noundef %u, i32 noundef %v) #0 !dbg !10 {
entry:
  %u.addr = alloca ptr, align 8
  %v.addr = alloca i32, align 4
  store ptr %u, ptr %u.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %u.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i32 %v, ptr %v.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %v.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load i32, ptr %v.addr, align 4, !dbg !26
  %1 = load ptr, ptr %u.addr, align 8, !dbg !27
  store i32 %0, ptr %1, align 4, !dbg !28
  ret void, !dbg !29
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @get_union(ptr noundef %u) #0 !dbg !30 {
entry:
  %u.addr = alloca ptr, align 8
  store ptr %u, ptr %u.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %u.addr, metadata !33, metadata !DIExpression()), !dbg !34
  %0 = load ptr, ptr %u.addr, align 8, !dbg !35
  %1 = load i32, ptr %0, align 4, !dbg !36
  ret i32 %1, !dbg !37
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init_struct(ptr noundef %s, i8 noundef signext %t, i32 noundef %d) #0 !dbg !38 {
entry:
  %s.addr = alloca ptr, align 8
  %t.addr = alloca i8, align 1
  %d.addr = alloca i32, align 4
  store ptr %s, ptr %s.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %s.addr, metadata !48, metadata !DIExpression()), !dbg !49
  store i8 %t, ptr %t.addr, align 1
  call void @llvm.dbg.declare(metadata ptr %t.addr, metadata !50, metadata !DIExpression()), !dbg !51
  store i32 %d, ptr %d.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %d.addr, metadata !52, metadata !DIExpression()), !dbg !53
  %0 = load i8, ptr %t.addr, align 1, !dbg !54
  %1 = load ptr, ptr %s.addr, align 8, !dbg !55
  %tag = getelementptr inbounds %struct.PaddedStruct, ptr %1, i32 0, i32 0, !dbg !56
  store i8 %0, ptr %tag, align 4, !dbg !57
  %2 = load i32, ptr %d.addr, align 4, !dbg !58
  %3 = load ptr, ptr %s.addr, align 8, !dbg !59
  %data = getelementptr inbounds %struct.PaddedStruct, ptr %3, i32 0, i32 1, !dbg !60
  store i32 %2, ptr %data, align 4, !dbg !61
  ret void, !dbg !62
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @read_struct(ptr noundef %s) #0 !dbg !63 {
entry:
  %s.addr = alloca ptr, align 8
  store ptr %s, ptr %s.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %s.addr, metadata !66, metadata !DIExpression()), !dbg !67
  %0 = load ptr, ptr %s.addr, align 8, !dbg !68
  %data = getelementptr inbounds %struct.PaddedStruct, ptr %0, i32 0, i32 1, !dbg !69
  %1 = load i32, ptr %data, align 4, !dbg !69
  ret i32 %1, !dbg !70
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_layout(i32 noundef %val) #0 !dbg !71 {
entry:
  %val.addr = alloca i32, align 4
  %u = alloca %union.ValueUnion, align 4
  %s = alloca %struct.PaddedStruct, align 4
  store i32 %val, ptr %val.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %val.addr, metadata !74, metadata !DIExpression()), !dbg !75
  call void @llvm.dbg.declare(metadata ptr %u, metadata !76, metadata !DIExpression()), !dbg !77
  %0 = load i32, ptr %val.addr, align 4, !dbg !78
  call void @init_union(ptr noundef %u, i32 noundef %0), !dbg !79
  call void @llvm.dbg.declare(metadata ptr %s, metadata !80, metadata !DIExpression()), !dbg !81
  %call = call i32 @get_union(ptr noundef %u), !dbg !82
  call void @init_struct(ptr noundef %s, i8 noundef signext 65, i32 noundef %call), !dbg !83
  %call1 = call i32 @read_struct(ptr noundef %s), !dbg !84
  ret i32 %call1, !dbg !85
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !86 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_layout(i32 noundef 42), !dbg !89
  ret i32 %call, !dbg !90
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "tests2/memory_layout/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "9a0fc5fab56cdca0948f4897c1e57deb")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "init_union", scope: !1, file: !1, line: 11, type: !11, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !18}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "ValueUnion", file: !1, line: 4, baseType: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !1, line: 1, size: 32, elements: !16)
!16 = !{!17, !19}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "i", scope: !15, file: !1, line: 2, baseType: !18, size: 32)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !15, file: !1, line: 3, baseType: !20, size: 32)
!20 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!21 = !{}
!22 = !DILocalVariable(name: "u", arg: 1, scope: !10, file: !1, line: 11, type: !13)
!23 = !DILocation(line: 11, column: 29, scope: !10)
!24 = !DILocalVariable(name: "v", arg: 2, scope: !10, file: !1, line: 11, type: !18)
!25 = !DILocation(line: 11, column: 36, scope: !10)
!26 = !DILocation(line: 12, column: 12, scope: !10)
!27 = !DILocation(line: 12, column: 5, scope: !10)
!28 = !DILocation(line: 12, column: 10, scope: !10)
!29 = !DILocation(line: 13, column: 1, scope: !10)
!30 = distinct !DISubprogram(name: "get_union", scope: !1, file: !1, line: 15, type: !31, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!31 = !DISubroutineType(types: !32)
!32 = !{!18, !13}
!33 = !DILocalVariable(name: "u", arg: 1, scope: !30, file: !1, line: 15, type: !13)
!34 = !DILocation(line: 15, column: 27, scope: !30)
!35 = !DILocation(line: 16, column: 12, scope: !30)
!36 = !DILocation(line: 16, column: 15, scope: !30)
!37 = !DILocation(line: 16, column: 5, scope: !30)
!38 = distinct !DISubprogram(name: "init_struct", scope: !1, file: !1, line: 19, type: !39, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!39 = !DISubroutineType(types: !40)
!40 = !{null, !41, !46, !18}
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "PaddedStruct", file: !1, line: 9, baseType: !43)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 6, size: 64, elements: !44)
!44 = !{!45, !47}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "tag", scope: !43, file: !1, line: 7, baseType: !46, size: 8)
!46 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !43, file: !1, line: 8, baseType: !18, size: 32, offset: 32)
!48 = !DILocalVariable(name: "s", arg: 1, scope: !38, file: !1, line: 19, type: !41)
!49 = !DILocation(line: 19, column: 32, scope: !38)
!50 = !DILocalVariable(name: "t", arg: 2, scope: !38, file: !1, line: 19, type: !46)
!51 = !DILocation(line: 19, column: 40, scope: !38)
!52 = !DILocalVariable(name: "d", arg: 3, scope: !38, file: !1, line: 19, type: !18)
!53 = !DILocation(line: 19, column: 47, scope: !38)
!54 = !DILocation(line: 20, column: 14, scope: !38)
!55 = !DILocation(line: 20, column: 5, scope: !38)
!56 = !DILocation(line: 20, column: 8, scope: !38)
!57 = !DILocation(line: 20, column: 12, scope: !38)
!58 = !DILocation(line: 21, column: 15, scope: !38)
!59 = !DILocation(line: 21, column: 5, scope: !38)
!60 = !DILocation(line: 21, column: 8, scope: !38)
!61 = !DILocation(line: 21, column: 13, scope: !38)
!62 = !DILocation(line: 22, column: 1, scope: !38)
!63 = distinct !DISubprogram(name: "read_struct", scope: !1, file: !1, line: 24, type: !64, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!64 = !DISubroutineType(types: !65)
!65 = !{!18, !41}
!66 = !DILocalVariable(name: "s", arg: 1, scope: !63, file: !1, line: 24, type: !41)
!67 = !DILocation(line: 24, column: 31, scope: !63)
!68 = !DILocation(line: 25, column: 12, scope: !63)
!69 = !DILocation(line: 25, column: 15, scope: !63)
!70 = !DILocation(line: 25, column: 5, scope: !63)
!71 = distinct !DISubprogram(name: "caller_layout", scope: !1, file: !1, line: 28, type: !72, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!72 = !DISubroutineType(types: !73)
!73 = !{!18, !18}
!74 = !DILocalVariable(name: "val", arg: 1, scope: !71, file: !1, line: 28, type: !18)
!75 = !DILocation(line: 28, column: 23, scope: !71)
!76 = !DILocalVariable(name: "u", scope: !71, file: !1, line: 29, type: !14)
!77 = !DILocation(line: 29, column: 16, scope: !71)
!78 = !DILocation(line: 30, column: 20, scope: !71)
!79 = !DILocation(line: 30, column: 5, scope: !71)
!80 = !DILocalVariable(name: "s", scope: !71, file: !1, line: 31, type: !42)
!81 = !DILocation(line: 31, column: 18, scope: !71)
!82 = !DILocation(line: 32, column: 26, scope: !71)
!83 = !DILocation(line: 32, column: 5, scope: !71)
!84 = !DILocation(line: 33, column: 12, scope: !71)
!85 = !DILocation(line: 33, column: 5, scope: !71)
!86 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 36, type: !87, scopeLine: 36, spFlags: DISPFlagDefinition, unit: !0)
!87 = !DISubroutineType(types: !88)
!88 = !{!18}
!89 = !DILocation(line: 37, column: 12, scope: !86)
!90 = !DILocation(line: 37, column: 5, scope: !86)
