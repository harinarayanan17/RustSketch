; ModuleID = 'large_benchmarks/02_packet_ringbuffer/test.c'
source_filename = "large_benchmarks/02_packet_ringbuffer/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.RingBuffer = type { i32, i32, i32, i32, i32 }
%struct.PacketHeader = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ring_init(ptr noundef %rb, i32 noundef %cap) #0 !dbg !10 {
entry:
  %rb.addr = alloca ptr, align 8
  %cap.addr = alloca i32, align 4
  store ptr %rb, ptr %rb.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %rb.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 %cap, ptr %cap.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %cap.addr, metadata !26, metadata !DIExpression()), !dbg !27
  %0 = load ptr, ptr %rb.addr, align 8, !dbg !28
  %head = getelementptr inbounds %struct.RingBuffer, ptr %0, i32 0, i32 0, !dbg !29
  store i32 0, ptr %head, align 4, !dbg !30
  %1 = load ptr, ptr %rb.addr, align 8, !dbg !31
  %tail = getelementptr inbounds %struct.RingBuffer, ptr %1, i32 0, i32 1, !dbg !32
  store i32 0, ptr %tail, align 4, !dbg !33
  %2 = load ptr, ptr %rb.addr, align 8, !dbg !34
  %count = getelementptr inbounds %struct.RingBuffer, ptr %2, i32 0, i32 2, !dbg !35
  store i32 0, ptr %count, align 4, !dbg !36
  %3 = load i32, ptr %cap.addr, align 4, !dbg !37
  %cmp = icmp sgt i32 %3, 0, !dbg !38
  br i1 %cmp, label %land.lhs.true, label %cond.false, !dbg !39

land.lhs.true:                                    ; preds = %entry
  %4 = load i32, ptr %cap.addr, align 4, !dbg !40
  %cmp1 = icmp sle i32 %4, 16, !dbg !41
  br i1 %cmp1, label %cond.true, label %cond.false, !dbg !42

cond.true:                                        ; preds = %land.lhs.true
  %5 = load i32, ptr %cap.addr, align 4, !dbg !43
  br label %cond.end, !dbg !42

cond.false:                                       ; preds = %land.lhs.true, %entry
  br label %cond.end, !dbg !42

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %5, %cond.true ], [ 8, %cond.false ], !dbg !42
  %6 = load ptr, ptr %rb.addr, align 8, !dbg !44
  %capacity = getelementptr inbounds %struct.RingBuffer, ptr %6, i32 0, i32 3, !dbg !45
  store i32 %cond, ptr %capacity, align 4, !dbg !46
  %7 = load ptr, ptr %rb.addr, align 8, !dbg !47
  %dropped_packets = getelementptr inbounds %struct.RingBuffer, ptr %7, i32 0, i32 4, !dbg !48
  store i32 0, ptr %dropped_packets, align 4, !dbg !49
  ret void, !dbg !50
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @ring_push(ptr noundef %rb, i32 noundef %item) #0 !dbg !51 {
entry:
  %retval = alloca i32, align 4
  %rb.addr = alloca ptr, align 8
  %item.addr = alloca i32, align 4
  store ptr %rb, ptr %rb.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %rb.addr, metadata !54, metadata !DIExpression()), !dbg !55
  store i32 %item, ptr %item.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %item.addr, metadata !56, metadata !DIExpression()), !dbg !57
  %0 = load ptr, ptr %rb.addr, align 8, !dbg !58
  %count = getelementptr inbounds %struct.RingBuffer, ptr %0, i32 0, i32 2, !dbg !60
  %1 = load i32, ptr %count, align 4, !dbg !60
  %2 = load ptr, ptr %rb.addr, align 8, !dbg !61
  %capacity = getelementptr inbounds %struct.RingBuffer, ptr %2, i32 0, i32 3, !dbg !62
  %3 = load i32, ptr %capacity, align 4, !dbg !62
  %cmp = icmp sge i32 %1, %3, !dbg !63
  br i1 %cmp, label %if.then, label %if.end, !dbg !64

if.then:                                          ; preds = %entry
  %4 = load ptr, ptr %rb.addr, align 8, !dbg !65
  %dropped_packets = getelementptr inbounds %struct.RingBuffer, ptr %4, i32 0, i32 4, !dbg !67
  %5 = load i32, ptr %dropped_packets, align 4, !dbg !68
  %inc = add nsw i32 %5, 1, !dbg !68
  store i32 %inc, ptr %dropped_packets, align 4, !dbg !68
  store i32 0, ptr %retval, align 4, !dbg !69
  br label %return, !dbg !69

if.end:                                           ; preds = %entry
  %6 = load ptr, ptr %rb.addr, align 8, !dbg !70
  %head = getelementptr inbounds %struct.RingBuffer, ptr %6, i32 0, i32 0, !dbg !71
  %7 = load i32, ptr %head, align 4, !dbg !71
  %add = add nsw i32 %7, 1, !dbg !72
  %8 = load ptr, ptr %rb.addr, align 8, !dbg !73
  %capacity1 = getelementptr inbounds %struct.RingBuffer, ptr %8, i32 0, i32 3, !dbg !74
  %9 = load i32, ptr %capacity1, align 4, !dbg !74
  %rem = srem i32 %add, %9, !dbg !75
  %10 = load ptr, ptr %rb.addr, align 8, !dbg !76
  %head2 = getelementptr inbounds %struct.RingBuffer, ptr %10, i32 0, i32 0, !dbg !77
  store i32 %rem, ptr %head2, align 4, !dbg !78
  %11 = load ptr, ptr %rb.addr, align 8, !dbg !79
  %count3 = getelementptr inbounds %struct.RingBuffer, ptr %11, i32 0, i32 2, !dbg !80
  %12 = load i32, ptr %count3, align 4, !dbg !81
  %inc4 = add nsw i32 %12, 1, !dbg !81
  store i32 %inc4, ptr %count3, align 4, !dbg !81
  %13 = load i32, ptr %item.addr, align 4, !dbg !82
  %xor = xor i32 %13, 170, !dbg !83
  store i32 %xor, ptr %retval, align 4, !dbg !84
  br label %return, !dbg !84

return:                                           ; preds = %if.end, %if.then
  %14 = load i32, ptr %retval, align 4, !dbg !85
  ret i32 %14, !dbg !85
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @parse_header(ptr noundef %hdr, i32 noundef %expected_magic) #0 !dbg !86 {
entry:
  %retval = alloca i32, align 4
  %hdr.addr = alloca ptr, align 8
  %expected_magic.addr = alloca i32, align 4
  store ptr %hdr, ptr %hdr.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %hdr.addr, metadata !96, metadata !DIExpression()), !dbg !97
  store i32 %expected_magic, ptr %expected_magic.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %expected_magic.addr, metadata !98, metadata !DIExpression()), !dbg !99
  %0 = load ptr, ptr %hdr.addr, align 8, !dbg !100
  %magic = getelementptr inbounds %struct.PacketHeader, ptr %0, i32 0, i32 0, !dbg !102
  %1 = load i32, ptr %magic, align 4, !dbg !102
  %2 = load i32, ptr %expected_magic.addr, align 4, !dbg !103
  %cmp = icmp ne i32 %1, %2, !dbg !104
  br i1 %cmp, label %if.then, label %if.end, !dbg !105

if.then:                                          ; preds = %entry
  %3 = load ptr, ptr %hdr.addr, align 8, !dbg !106
  %status_flags = getelementptr inbounds %struct.PacketHeader, ptr %3, i32 0, i32 2, !dbg !108
  %4 = load i32, ptr %status_flags, align 4, !dbg !109
  %or = or i32 %4, 1, !dbg !109
  store i32 %or, ptr %status_flags, align 4, !dbg !109
  store i32 -1, ptr %retval, align 4, !dbg !110
  br label %return, !dbg !110

if.end:                                           ; preds = %entry
  %5 = load ptr, ptr %hdr.addr, align 8, !dbg !111
  %status_flags1 = getelementptr inbounds %struct.PacketHeader, ptr %5, i32 0, i32 2, !dbg !112
  %6 = load i32, ptr %status_flags1, align 4, !dbg !113
  %and = and i32 %6, -2, !dbg !113
  store i32 %and, ptr %status_flags1, align 4, !dbg !113
  %7 = load ptr, ptr %hdr.addr, align 8, !dbg !114
  %payload_length = getelementptr inbounds %struct.PacketHeader, ptr %7, i32 0, i32 1, !dbg !115
  %8 = load i32, ptr %payload_length, align 4, !dbg !115
  store i32 %8, ptr %retval, align 4, !dbg !116
  br label %return, !dbg !116

return:                                           ; preds = %if.end, %if.then
  %9 = load i32, ptr %retval, align 4, !dbg !117
  ret i32 %9, !dbg !117
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_process_frame(i32 noundef %magic_in, i32 noundef %len_in) #0 !dbg !118 {
entry:
  %magic_in.addr = alloca i32, align 4
  %len_in.addr = alloca i32, align 4
  %rb = alloca %struct.RingBuffer, align 4
  %hdr = alloca %struct.PacketHeader, align 4
  %parse_res = alloca i32, align 4
  store i32 %magic_in, ptr %magic_in.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %magic_in.addr, metadata !121, metadata !DIExpression()), !dbg !122
  store i32 %len_in, ptr %len_in.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %len_in.addr, metadata !123, metadata !DIExpression()), !dbg !124
  call void @llvm.dbg.declare(metadata ptr %rb, metadata !125, metadata !DIExpression()), !dbg !126
  call void @ring_init(ptr noundef %rb, i32 noundef 4), !dbg !127
  call void @llvm.dbg.declare(metadata ptr %hdr, metadata !128, metadata !DIExpression()), !dbg !129
  %0 = load i32, ptr %magic_in.addr, align 4, !dbg !130
  %magic = getelementptr inbounds %struct.PacketHeader, ptr %hdr, i32 0, i32 0, !dbg !131
  store i32 %0, ptr %magic, align 4, !dbg !132
  %1 = load i32, ptr %len_in.addr, align 4, !dbg !133
  %payload_length = getelementptr inbounds %struct.PacketHeader, ptr %hdr, i32 0, i32 1, !dbg !134
  store i32 %1, ptr %payload_length, align 4, !dbg !135
  %status_flags = getelementptr inbounds %struct.PacketHeader, ptr %hdr, i32 0, i32 2, !dbg !136
  store i32 0, ptr %status_flags, align 4, !dbg !137
  call void @llvm.dbg.declare(metadata ptr %parse_res, metadata !138, metadata !DIExpression()), !dbg !139
  %call = call i32 @parse_header(ptr noundef %hdr, i32 noundef 21930), !dbg !140
  store i32 %call, ptr %parse_res, align 4, !dbg !139
  %2 = load i32, ptr %parse_res, align 4, !dbg !141
  %cmp = icmp sge i32 %2, 0, !dbg !143
  br i1 %cmp, label %if.then, label %if.end, !dbg !144

if.then:                                          ; preds = %entry
  %3 = load i32, ptr %parse_res, align 4, !dbg !145
  %call1 = call i32 @ring_push(ptr noundef %rb, i32 noundef %3), !dbg !147
  %4 = load i32, ptr %parse_res, align 4, !dbg !148
  %add = add nsw i32 %4, 1, !dbg !149
  %call2 = call i32 @ring_push(ptr noundef %rb, i32 noundef %add), !dbg !150
  br label %if.end, !dbg !151

if.end:                                           ; preds = %if.then, %entry
  %count = getelementptr inbounds %struct.RingBuffer, ptr %rb, i32 0, i32 2, !dbg !152
  %5 = load i32, ptr %count, align 4, !dbg !152
  %status_flags3 = getelementptr inbounds %struct.PacketHeader, ptr %hdr, i32 0, i32 2, !dbg !153
  %6 = load i32, ptr %status_flags3, align 4, !dbg !153
  %and = and i32 %6, 255, !dbg !154
  %add4 = add nsw i32 %5, %and, !dbg !155
  ret i32 %add4, !dbg !156
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !157 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_process_frame(i32 noundef 21930, i32 noundef 10), !dbg !160
  ret i32 %call, !dbg !161
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "large_benchmarks/02_packet_ringbuffer/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "1e093162ea78c0f5b132f571ac9ff0e4")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "ring_init", scope: !1, file: !1, line: 15, type: !11, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !18}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "RingBuffer", file: !1, line: 7, baseType: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 1, size: 160, elements: !16)
!16 = !{!17, !19, !20, !21, !22}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !15, file: !1, line: 2, baseType: !18, size: 32)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "tail", scope: !15, file: !1, line: 3, baseType: !18, size: 32, offset: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "count", scope: !15, file: !1, line: 4, baseType: !18, size: 32, offset: 64)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "capacity", scope: !15, file: !1, line: 5, baseType: !18, size: 32, offset: 96)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "dropped_packets", scope: !15, file: !1, line: 6, baseType: !18, size: 32, offset: 128)
!23 = !{}
!24 = !DILocalVariable(name: "rb", arg: 1, scope: !10, file: !1, line: 15, type: !13)
!25 = !DILocation(line: 15, column: 28, scope: !10)
!26 = !DILocalVariable(name: "cap", arg: 2, scope: !10, file: !1, line: 15, type: !18)
!27 = !DILocation(line: 15, column: 36, scope: !10)
!28 = !DILocation(line: 16, column: 5, scope: !10)
!29 = !DILocation(line: 16, column: 9, scope: !10)
!30 = !DILocation(line: 16, column: 14, scope: !10)
!31 = !DILocation(line: 17, column: 5, scope: !10)
!32 = !DILocation(line: 17, column: 9, scope: !10)
!33 = !DILocation(line: 17, column: 14, scope: !10)
!34 = !DILocation(line: 18, column: 5, scope: !10)
!35 = !DILocation(line: 18, column: 9, scope: !10)
!36 = !DILocation(line: 18, column: 15, scope: !10)
!37 = !DILocation(line: 19, column: 21, scope: !10)
!38 = !DILocation(line: 19, column: 25, scope: !10)
!39 = !DILocation(line: 19, column: 29, scope: !10)
!40 = !DILocation(line: 19, column: 32, scope: !10)
!41 = !DILocation(line: 19, column: 36, scope: !10)
!42 = !DILocation(line: 19, column: 20, scope: !10)
!43 = !DILocation(line: 19, column: 45, scope: !10)
!44 = !DILocation(line: 19, column: 5, scope: !10)
!45 = !DILocation(line: 19, column: 9, scope: !10)
!46 = !DILocation(line: 19, column: 18, scope: !10)
!47 = !DILocation(line: 20, column: 5, scope: !10)
!48 = !DILocation(line: 20, column: 9, scope: !10)
!49 = !DILocation(line: 20, column: 25, scope: !10)
!50 = !DILocation(line: 21, column: 1, scope: !10)
!51 = distinct !DISubprogram(name: "ring_push", scope: !1, file: !1, line: 23, type: !52, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!52 = !DISubroutineType(types: !53)
!53 = !{!18, !13, !18}
!54 = !DILocalVariable(name: "rb", arg: 1, scope: !51, file: !1, line: 23, type: !13)
!55 = !DILocation(line: 23, column: 27, scope: !51)
!56 = !DILocalVariable(name: "item", arg: 2, scope: !51, file: !1, line: 23, type: !18)
!57 = !DILocation(line: 23, column: 35, scope: !51)
!58 = !DILocation(line: 24, column: 9, scope: !59)
!59 = distinct !DILexicalBlock(scope: !51, file: !1, line: 24, column: 9)
!60 = !DILocation(line: 24, column: 13, scope: !59)
!61 = !DILocation(line: 24, column: 22, scope: !59)
!62 = !DILocation(line: 24, column: 26, scope: !59)
!63 = !DILocation(line: 24, column: 19, scope: !59)
!64 = !DILocation(line: 24, column: 9, scope: !51)
!65 = !DILocation(line: 25, column: 9, scope: !66)
!66 = distinct !DILexicalBlock(scope: !59, file: !1, line: 24, column: 36)
!67 = !DILocation(line: 25, column: 13, scope: !66)
!68 = !DILocation(line: 25, column: 28, scope: !66)
!69 = !DILocation(line: 26, column: 9, scope: !66)
!70 = !DILocation(line: 28, column: 17, scope: !51)
!71 = !DILocation(line: 28, column: 21, scope: !51)
!72 = !DILocation(line: 28, column: 26, scope: !51)
!73 = !DILocation(line: 28, column: 33, scope: !51)
!74 = !DILocation(line: 28, column: 37, scope: !51)
!75 = !DILocation(line: 28, column: 31, scope: !51)
!76 = !DILocation(line: 28, column: 5, scope: !51)
!77 = !DILocation(line: 28, column: 9, scope: !51)
!78 = !DILocation(line: 28, column: 14, scope: !51)
!79 = !DILocation(line: 29, column: 5, scope: !51)
!80 = !DILocation(line: 29, column: 9, scope: !51)
!81 = !DILocation(line: 29, column: 14, scope: !51)
!82 = !DILocation(line: 30, column: 12, scope: !51)
!83 = !DILocation(line: 30, column: 17, scope: !51)
!84 = !DILocation(line: 30, column: 5, scope: !51)
!85 = !DILocation(line: 31, column: 1, scope: !51)
!86 = distinct !DISubprogram(name: "parse_header", scope: !1, file: !1, line: 33, type: !87, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!87 = !DISubroutineType(types: !88)
!88 = !{!18, !89, !18}
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = !DIDerivedType(tag: DW_TAG_typedef, name: "PacketHeader", file: !1, line: 13, baseType: !91)
!91 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 9, size: 96, elements: !92)
!92 = !{!93, !94, !95}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "magic", scope: !91, file: !1, line: 10, baseType: !18, size: 32)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "payload_length", scope: !91, file: !1, line: 11, baseType: !18, size: 32, offset: 32)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "status_flags", scope: !91, file: !1, line: 12, baseType: !18, size: 32, offset: 64)
!96 = !DILocalVariable(name: "hdr", arg: 1, scope: !86, file: !1, line: 33, type: !89)
!97 = !DILocation(line: 33, column: 32, scope: !86)
!98 = !DILocalVariable(name: "expected_magic", arg: 2, scope: !86, file: !1, line: 33, type: !18)
!99 = !DILocation(line: 33, column: 41, scope: !86)
!100 = !DILocation(line: 34, column: 9, scope: !101)
!101 = distinct !DILexicalBlock(scope: !86, file: !1, line: 34, column: 9)
!102 = !DILocation(line: 34, column: 14, scope: !101)
!103 = !DILocation(line: 34, column: 23, scope: !101)
!104 = !DILocation(line: 34, column: 20, scope: !101)
!105 = !DILocation(line: 34, column: 9, scope: !86)
!106 = !DILocation(line: 35, column: 9, scope: !107)
!107 = distinct !DILexicalBlock(scope: !101, file: !1, line: 34, column: 39)
!108 = !DILocation(line: 35, column: 14, scope: !107)
!109 = !DILocation(line: 35, column: 27, scope: !107)
!110 = !DILocation(line: 36, column: 9, scope: !107)
!111 = !DILocation(line: 38, column: 5, scope: !86)
!112 = !DILocation(line: 38, column: 10, scope: !86)
!113 = !DILocation(line: 38, column: 23, scope: !86)
!114 = !DILocation(line: 39, column: 12, scope: !86)
!115 = !DILocation(line: 39, column: 17, scope: !86)
!116 = !DILocation(line: 39, column: 5, scope: !86)
!117 = !DILocation(line: 40, column: 1, scope: !86)
!118 = distinct !DISubprogram(name: "caller_process_frame", scope: !1, file: !1, line: 42, type: !119, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !23)
!119 = !DISubroutineType(types: !120)
!120 = !{!18, !18, !18}
!121 = !DILocalVariable(name: "magic_in", arg: 1, scope: !118, file: !1, line: 42, type: !18)
!122 = !DILocation(line: 42, column: 30, scope: !118)
!123 = !DILocalVariable(name: "len_in", arg: 2, scope: !118, file: !1, line: 42, type: !18)
!124 = !DILocation(line: 42, column: 44, scope: !118)
!125 = !DILocalVariable(name: "rb", scope: !118, file: !1, line: 43, type: !14)
!126 = !DILocation(line: 43, column: 16, scope: !118)
!127 = !DILocation(line: 44, column: 5, scope: !118)
!128 = !DILocalVariable(name: "hdr", scope: !118, file: !1, line: 46, type: !90)
!129 = !DILocation(line: 46, column: 18, scope: !118)
!130 = !DILocation(line: 47, column: 17, scope: !118)
!131 = !DILocation(line: 47, column: 9, scope: !118)
!132 = !DILocation(line: 47, column: 15, scope: !118)
!133 = !DILocation(line: 48, column: 26, scope: !118)
!134 = !DILocation(line: 48, column: 9, scope: !118)
!135 = !DILocation(line: 48, column: 24, scope: !118)
!136 = !DILocation(line: 49, column: 9, scope: !118)
!137 = !DILocation(line: 49, column: 22, scope: !118)
!138 = !DILocalVariable(name: "parse_res", scope: !118, file: !1, line: 51, type: !18)
!139 = !DILocation(line: 51, column: 9, scope: !118)
!140 = !DILocation(line: 51, column: 21, scope: !118)
!141 = !DILocation(line: 52, column: 9, scope: !142)
!142 = distinct !DILexicalBlock(scope: !118, file: !1, line: 52, column: 9)
!143 = !DILocation(line: 52, column: 19, scope: !142)
!144 = !DILocation(line: 52, column: 9, scope: !118)
!145 = !DILocation(line: 53, column: 24, scope: !146)
!146 = distinct !DILexicalBlock(scope: !142, file: !1, line: 52, column: 25)
!147 = !DILocation(line: 53, column: 9, scope: !146)
!148 = !DILocation(line: 54, column: 24, scope: !146)
!149 = !DILocation(line: 54, column: 34, scope: !146)
!150 = !DILocation(line: 54, column: 9, scope: !146)
!151 = !DILocation(line: 55, column: 5, scope: !146)
!152 = !DILocation(line: 57, column: 15, scope: !118)
!153 = !DILocation(line: 57, column: 28, scope: !118)
!154 = !DILocation(line: 57, column: 41, scope: !118)
!155 = !DILocation(line: 57, column: 21, scope: !118)
!156 = !DILocation(line: 57, column: 5, scope: !118)
!157 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 60, type: !158, scopeLine: 60, spFlags: DISPFlagDefinition, unit: !0)
!158 = !DISubroutineType(types: !159)
!159 = !{!18}
!160 = !DILocation(line: 61, column: 12, scope: !157)
!161 = !DILocation(line: 61, column: 5, scope: !157)
