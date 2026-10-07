; ModuleID = 'large_benchmarks/03_matrix_transform/test.c'
source_filename = "large_benchmarks/03_matrix_transform/test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Vec3 = type { i32, i32, i32 }
%struct.Mat3x3 = type { i32, i32, i32, i32, i32, i32, i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vec3_init(ptr noundef %v, i32 noundef %x, i32 noundef %y, i32 noundef %z) #0 !dbg !10 {
entry:
  %v.addr = alloca ptr, align 8
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %z.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %v.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 %y, ptr %y.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %y.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 %z, ptr %z.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %z.addr, metadata !28, metadata !DIExpression()), !dbg !29
  %0 = load i32, ptr %x.addr, align 4, !dbg !30
  %1 = load ptr, ptr %v.addr, align 8, !dbg !31
  %x1 = getelementptr inbounds %struct.Vec3, ptr %1, i32 0, i32 0, !dbg !32
  store i32 %0, ptr %x1, align 4, !dbg !33
  %2 = load i32, ptr %y.addr, align 4, !dbg !34
  %3 = load ptr, ptr %v.addr, align 8, !dbg !35
  %y2 = getelementptr inbounds %struct.Vec3, ptr %3, i32 0, i32 1, !dbg !36
  store i32 %2, ptr %y2, align 4, !dbg !37
  %4 = load i32, ptr %z.addr, align 4, !dbg !38
  %5 = load ptr, ptr %v.addr, align 8, !dbg !39
  %z3 = getelementptr inbounds %struct.Vec3, ptr %5, i32 0, i32 2, !dbg !40
  store i32 %4, ptr %z3, align 4, !dbg !41
  ret void, !dbg !42
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @vec3_dot(ptr noundef %a, ptr noundef %b) #0 !dbg !43 {
entry:
  %a.addr = alloca ptr, align 8
  %b.addr = alloca ptr, align 8
  store ptr %a, ptr %a.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %a.addr, metadata !48, metadata !DIExpression()), !dbg !49
  store ptr %b, ptr %b.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %b.addr, metadata !50, metadata !DIExpression()), !dbg !51
  %0 = load ptr, ptr %a.addr, align 8, !dbg !52
  %x = getelementptr inbounds %struct.Vec3, ptr %0, i32 0, i32 0, !dbg !53
  %1 = load i32, ptr %x, align 4, !dbg !53
  %2 = load ptr, ptr %b.addr, align 8, !dbg !54
  %x1 = getelementptr inbounds %struct.Vec3, ptr %2, i32 0, i32 0, !dbg !55
  %3 = load i32, ptr %x1, align 4, !dbg !55
  %mul = mul nsw i32 %1, %3, !dbg !56
  %4 = load ptr, ptr %a.addr, align 8, !dbg !57
  %y = getelementptr inbounds %struct.Vec3, ptr %4, i32 0, i32 1, !dbg !58
  %5 = load i32, ptr %y, align 4, !dbg !58
  %6 = load ptr, ptr %b.addr, align 8, !dbg !59
  %y2 = getelementptr inbounds %struct.Vec3, ptr %6, i32 0, i32 1, !dbg !60
  %7 = load i32, ptr %y2, align 4, !dbg !60
  %mul3 = mul nsw i32 %5, %7, !dbg !61
  %add = add nsw i32 %mul, %mul3, !dbg !62
  %8 = load ptr, ptr %a.addr, align 8, !dbg !63
  %z = getelementptr inbounds %struct.Vec3, ptr %8, i32 0, i32 2, !dbg !64
  %9 = load i32, ptr %z, align 4, !dbg !64
  %10 = load ptr, ptr %b.addr, align 8, !dbg !65
  %z4 = getelementptr inbounds %struct.Vec3, ptr %10, i32 0, i32 2, !dbg !66
  %11 = load i32, ptr %z4, align 4, !dbg !66
  %mul5 = mul nsw i32 %9, %11, !dbg !67
  %add6 = add nsw i32 %add, %mul5, !dbg !68
  ret i32 %add6, !dbg !69
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @vec3_scale(ptr noundef %v, i32 noundef %factor) #0 !dbg !70 {
entry:
  %v.addr = alloca ptr, align 8
  %factor.addr = alloca i32, align 4
  store ptr %v, ptr %v.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %v.addr, metadata !73, metadata !DIExpression()), !dbg !74
  store i32 %factor, ptr %factor.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %factor.addr, metadata !75, metadata !DIExpression()), !dbg !76
  %0 = load i32, ptr %factor.addr, align 4, !dbg !77
  %1 = load ptr, ptr %v.addr, align 8, !dbg !78
  %x = getelementptr inbounds %struct.Vec3, ptr %1, i32 0, i32 0, !dbg !79
  %2 = load i32, ptr %x, align 4, !dbg !80
  %mul = mul nsw i32 %2, %0, !dbg !80
  store i32 %mul, ptr %x, align 4, !dbg !80
  %3 = load i32, ptr %factor.addr, align 4, !dbg !81
  %4 = load ptr, ptr %v.addr, align 8, !dbg !82
  %y = getelementptr inbounds %struct.Vec3, ptr %4, i32 0, i32 1, !dbg !83
  %5 = load i32, ptr %y, align 4, !dbg !84
  %mul1 = mul nsw i32 %5, %3, !dbg !84
  store i32 %mul1, ptr %y, align 4, !dbg !84
  %6 = load i32, ptr %factor.addr, align 4, !dbg !85
  %7 = load ptr, ptr %v.addr, align 8, !dbg !86
  %z = getelementptr inbounds %struct.Vec3, ptr %7, i32 0, i32 2, !dbg !87
  %8 = load i32, ptr %z, align 4, !dbg !88
  %mul2 = mul nsw i32 %8, %6, !dbg !88
  store i32 %mul2, ptr %z, align 4, !dbg !88
  ret void, !dbg !89
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @mat3_transform(ptr noundef %m, ptr noundef %src, ptr noundef %dst) #0 !dbg !90 {
entry:
  %m.addr = alloca ptr, align 8
  %src.addr = alloca ptr, align 8
  %dst.addr = alloca ptr, align 8
  store ptr %m, ptr %m.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %m.addr, metadata !107, metadata !DIExpression()), !dbg !108
  store ptr %src, ptr %src.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %src.addr, metadata !109, metadata !DIExpression()), !dbg !110
  store ptr %dst, ptr %dst.addr, align 8
  call void @llvm.dbg.declare(metadata ptr %dst.addr, metadata !111, metadata !DIExpression()), !dbg !112
  %0 = load ptr, ptr %m.addr, align 8, !dbg !113
  %m00 = getelementptr inbounds %struct.Mat3x3, ptr %0, i32 0, i32 0, !dbg !114
  %1 = load i32, ptr %m00, align 4, !dbg !114
  %2 = load ptr, ptr %src.addr, align 8, !dbg !115
  %x = getelementptr inbounds %struct.Vec3, ptr %2, i32 0, i32 0, !dbg !116
  %3 = load i32, ptr %x, align 4, !dbg !116
  %mul = mul nsw i32 %1, %3, !dbg !117
  %4 = load ptr, ptr %m.addr, align 8, !dbg !118
  %m01 = getelementptr inbounds %struct.Mat3x3, ptr %4, i32 0, i32 1, !dbg !119
  %5 = load i32, ptr %m01, align 4, !dbg !119
  %6 = load ptr, ptr %src.addr, align 8, !dbg !120
  %y = getelementptr inbounds %struct.Vec3, ptr %6, i32 0, i32 1, !dbg !121
  %7 = load i32, ptr %y, align 4, !dbg !121
  %mul1 = mul nsw i32 %5, %7, !dbg !122
  %add = add nsw i32 %mul, %mul1, !dbg !123
  %8 = load ptr, ptr %m.addr, align 8, !dbg !124
  %m02 = getelementptr inbounds %struct.Mat3x3, ptr %8, i32 0, i32 2, !dbg !125
  %9 = load i32, ptr %m02, align 4, !dbg !125
  %10 = load ptr, ptr %src.addr, align 8, !dbg !126
  %z = getelementptr inbounds %struct.Vec3, ptr %10, i32 0, i32 2, !dbg !127
  %11 = load i32, ptr %z, align 4, !dbg !127
  %mul2 = mul nsw i32 %9, %11, !dbg !128
  %add3 = add nsw i32 %add, %mul2, !dbg !129
  %12 = load ptr, ptr %dst.addr, align 8, !dbg !130
  %x4 = getelementptr inbounds %struct.Vec3, ptr %12, i32 0, i32 0, !dbg !131
  store i32 %add3, ptr %x4, align 4, !dbg !132
  %13 = load ptr, ptr %m.addr, align 8, !dbg !133
  %m10 = getelementptr inbounds %struct.Mat3x3, ptr %13, i32 0, i32 3, !dbg !134
  %14 = load i32, ptr %m10, align 4, !dbg !134
  %15 = load ptr, ptr %src.addr, align 8, !dbg !135
  %x5 = getelementptr inbounds %struct.Vec3, ptr %15, i32 0, i32 0, !dbg !136
  %16 = load i32, ptr %x5, align 4, !dbg !136
  %mul6 = mul nsw i32 %14, %16, !dbg !137
  %17 = load ptr, ptr %m.addr, align 8, !dbg !138
  %m11 = getelementptr inbounds %struct.Mat3x3, ptr %17, i32 0, i32 4, !dbg !139
  %18 = load i32, ptr %m11, align 4, !dbg !139
  %19 = load ptr, ptr %src.addr, align 8, !dbg !140
  %y7 = getelementptr inbounds %struct.Vec3, ptr %19, i32 0, i32 1, !dbg !141
  %20 = load i32, ptr %y7, align 4, !dbg !141
  %mul8 = mul nsw i32 %18, %20, !dbg !142
  %add9 = add nsw i32 %mul6, %mul8, !dbg !143
  %21 = load ptr, ptr %m.addr, align 8, !dbg !144
  %m12 = getelementptr inbounds %struct.Mat3x3, ptr %21, i32 0, i32 5, !dbg !145
  %22 = load i32, ptr %m12, align 4, !dbg !145
  %23 = load ptr, ptr %src.addr, align 8, !dbg !146
  %z10 = getelementptr inbounds %struct.Vec3, ptr %23, i32 0, i32 2, !dbg !147
  %24 = load i32, ptr %z10, align 4, !dbg !147
  %mul11 = mul nsw i32 %22, %24, !dbg !148
  %add12 = add nsw i32 %add9, %mul11, !dbg !149
  %25 = load ptr, ptr %dst.addr, align 8, !dbg !150
  %y13 = getelementptr inbounds %struct.Vec3, ptr %25, i32 0, i32 1, !dbg !151
  store i32 %add12, ptr %y13, align 4, !dbg !152
  %26 = load ptr, ptr %m.addr, align 8, !dbg !153
  %m20 = getelementptr inbounds %struct.Mat3x3, ptr %26, i32 0, i32 6, !dbg !154
  %27 = load i32, ptr %m20, align 4, !dbg !154
  %28 = load ptr, ptr %src.addr, align 8, !dbg !155
  %x14 = getelementptr inbounds %struct.Vec3, ptr %28, i32 0, i32 0, !dbg !156
  %29 = load i32, ptr %x14, align 4, !dbg !156
  %mul15 = mul nsw i32 %27, %29, !dbg !157
  %30 = load ptr, ptr %m.addr, align 8, !dbg !158
  %m21 = getelementptr inbounds %struct.Mat3x3, ptr %30, i32 0, i32 7, !dbg !159
  %31 = load i32, ptr %m21, align 4, !dbg !159
  %32 = load ptr, ptr %src.addr, align 8, !dbg !160
  %y16 = getelementptr inbounds %struct.Vec3, ptr %32, i32 0, i32 1, !dbg !161
  %33 = load i32, ptr %y16, align 4, !dbg !161
  %mul17 = mul nsw i32 %31, %33, !dbg !162
  %add18 = add nsw i32 %mul15, %mul17, !dbg !163
  %34 = load ptr, ptr %m.addr, align 8, !dbg !164
  %m22 = getelementptr inbounds %struct.Mat3x3, ptr %34, i32 0, i32 8, !dbg !165
  %35 = load i32, ptr %m22, align 4, !dbg !165
  %36 = load ptr, ptr %src.addr, align 8, !dbg !166
  %z19 = getelementptr inbounds %struct.Vec3, ptr %36, i32 0, i32 2, !dbg !167
  %37 = load i32, ptr %z19, align 4, !dbg !167
  %mul20 = mul nsw i32 %35, %37, !dbg !168
  %add21 = add nsw i32 %add18, %mul20, !dbg !169
  %38 = load ptr, ptr %dst.addr, align 8, !dbg !170
  %z22 = getelementptr inbounds %struct.Vec3, ptr %38, i32 0, i32 2, !dbg !171
  store i32 %add21, ptr %z22, align 4, !dbg !172
  ret void, !dbg !173
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @caller_render_pipeline(i32 noundef %x, i32 noundef %y, i32 noundef %z, i32 noundef %scale) #0 !dbg !174 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %z.addr = alloca i32, align 4
  %scale.addr = alloca i32, align 4
  %input_v = alloca %struct.Vec3, align 4
  %mat = alloca %struct.Mat3x3, align 4
  %out_v = alloca %struct.Vec3, align 4
  store i32 %x, ptr %x.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %x.addr, metadata !177, metadata !DIExpression()), !dbg !178
  store i32 %y, ptr %y.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %y.addr, metadata !179, metadata !DIExpression()), !dbg !180
  store i32 %z, ptr %z.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %z.addr, metadata !181, metadata !DIExpression()), !dbg !182
  store i32 %scale, ptr %scale.addr, align 4
  call void @llvm.dbg.declare(metadata ptr %scale.addr, metadata !183, metadata !DIExpression()), !dbg !184
  call void @llvm.dbg.declare(metadata ptr %input_v, metadata !185, metadata !DIExpression()), !dbg !186
  %0 = load i32, ptr %x.addr, align 4, !dbg !187
  %1 = load i32, ptr %y.addr, align 4, !dbg !188
  %2 = load i32, ptr %z.addr, align 4, !dbg !189
  call void @vec3_init(ptr noundef %input_v, i32 noundef %0, i32 noundef %1, i32 noundef %2), !dbg !190
  %3 = load i32, ptr %scale.addr, align 4, !dbg !191
  call void @vec3_scale(ptr noundef %input_v, i32 noundef %3), !dbg !192
  call void @llvm.dbg.declare(metadata ptr %mat, metadata !193, metadata !DIExpression()), !dbg !194
  call void @llvm.memset.p0.i64(ptr align 4 %mat, i8 0, i64 36, i1 false), !dbg !194
  %4 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 0, !dbg !194
  store i32 2, ptr %4, align 4, !dbg !194
  %5 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 1, !dbg !194
  store i32 1, ptr %5, align 4, !dbg !194
  %6 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 4, !dbg !194
  store i32 2, ptr %6, align 4, !dbg !194
  %7 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 5, !dbg !194
  store i32 1, ptr %7, align 4, !dbg !194
  %8 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 6, !dbg !194
  store i32 1, ptr %8, align 4, !dbg !194
  %9 = getelementptr inbounds %struct.Mat3x3, ptr %mat, i32 0, i32 8, !dbg !194
  store i32 2, ptr %9, align 4, !dbg !194
  call void @llvm.dbg.declare(metadata ptr %out_v, metadata !195, metadata !DIExpression()), !dbg !196
  call void @mat3_transform(ptr noundef %mat, ptr noundef %input_v, ptr noundef %out_v), !dbg !197
  %call = call i32 @vec3_dot(ptr noundef %input_v, ptr noundef %out_v), !dbg !198
  ret i32 %call, !dbg !199
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !200 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %call = call i32 @caller_render_pipeline(i32 noundef 1, i32 noundef 2, i32 noundef 3, i32 noundef 2), !dbg !203
  ret i32 %call, !dbg !204
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "large_benchmarks/03_matrix_transform/test.c", directory: "/home/hari/rustsketch", checksumkind: CSK_MD5, checksum: "074b1bab847ada5ed9546b57f17daabb")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!10 = distinct !DISubprogram(name: "vec3_init", scope: !1, file: !1, line: 13, type: !11, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !18, !18, !18}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "Vec3", file: !1, line: 5, baseType: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 1, size: 96, elements: !16)
!16 = !{!17, !19, !20}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !15, file: !1, line: 2, baseType: !18, size: 32)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !15, file: !1, line: 3, baseType: !18, size: 32, offset: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !15, file: !1, line: 4, baseType: !18, size: 32, offset: 64)
!21 = !{}
!22 = !DILocalVariable(name: "v", arg: 1, scope: !10, file: !1, line: 13, type: !13)
!23 = !DILocation(line: 13, column: 22, scope: !10)
!24 = !DILocalVariable(name: "x", arg: 2, scope: !10, file: !1, line: 13, type: !18)
!25 = !DILocation(line: 13, column: 29, scope: !10)
!26 = !DILocalVariable(name: "y", arg: 3, scope: !10, file: !1, line: 13, type: !18)
!27 = !DILocation(line: 13, column: 36, scope: !10)
!28 = !DILocalVariable(name: "z", arg: 4, scope: !10, file: !1, line: 13, type: !18)
!29 = !DILocation(line: 13, column: 43, scope: !10)
!30 = !DILocation(line: 14, column: 12, scope: !10)
!31 = !DILocation(line: 14, column: 5, scope: !10)
!32 = !DILocation(line: 14, column: 8, scope: !10)
!33 = !DILocation(line: 14, column: 10, scope: !10)
!34 = !DILocation(line: 15, column: 12, scope: !10)
!35 = !DILocation(line: 15, column: 5, scope: !10)
!36 = !DILocation(line: 15, column: 8, scope: !10)
!37 = !DILocation(line: 15, column: 10, scope: !10)
!38 = !DILocation(line: 16, column: 12, scope: !10)
!39 = !DILocation(line: 16, column: 5, scope: !10)
!40 = !DILocation(line: 16, column: 8, scope: !10)
!41 = !DILocation(line: 16, column: 10, scope: !10)
!42 = !DILocation(line: 17, column: 1, scope: !10)
!43 = distinct !DISubprogram(name: "vec3_dot", scope: !1, file: !1, line: 19, type: !44, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!44 = !DISubroutineType(types: !45)
!45 = !{!18, !46, !46}
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !14)
!48 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 19, type: !46)
!49 = !DILocation(line: 19, column: 26, scope: !43)
!50 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 19, type: !46)
!51 = !DILocation(line: 19, column: 41, scope: !43)
!52 = !DILocation(line: 20, column: 13, scope: !43)
!53 = !DILocation(line: 20, column: 16, scope: !43)
!54 = !DILocation(line: 20, column: 20, scope: !43)
!55 = !DILocation(line: 20, column: 23, scope: !43)
!56 = !DILocation(line: 20, column: 18, scope: !43)
!57 = !DILocation(line: 20, column: 29, scope: !43)
!58 = !DILocation(line: 20, column: 32, scope: !43)
!59 = !DILocation(line: 20, column: 36, scope: !43)
!60 = !DILocation(line: 20, column: 39, scope: !43)
!61 = !DILocation(line: 20, column: 34, scope: !43)
!62 = !DILocation(line: 20, column: 26, scope: !43)
!63 = !DILocation(line: 20, column: 45, scope: !43)
!64 = !DILocation(line: 20, column: 48, scope: !43)
!65 = !DILocation(line: 20, column: 52, scope: !43)
!66 = !DILocation(line: 20, column: 55, scope: !43)
!67 = !DILocation(line: 20, column: 50, scope: !43)
!68 = !DILocation(line: 20, column: 42, scope: !43)
!69 = !DILocation(line: 20, column: 5, scope: !43)
!70 = distinct !DISubprogram(name: "vec3_scale", scope: !1, file: !1, line: 23, type: !71, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !13, !18}
!73 = !DILocalVariable(name: "v", arg: 1, scope: !70, file: !1, line: 23, type: !13)
!74 = !DILocation(line: 23, column: 23, scope: !70)
!75 = !DILocalVariable(name: "factor", arg: 2, scope: !70, file: !1, line: 23, type: !18)
!76 = !DILocation(line: 23, column: 30, scope: !70)
!77 = !DILocation(line: 24, column: 13, scope: !70)
!78 = !DILocation(line: 24, column: 5, scope: !70)
!79 = !DILocation(line: 24, column: 8, scope: !70)
!80 = !DILocation(line: 24, column: 10, scope: !70)
!81 = !DILocation(line: 25, column: 13, scope: !70)
!82 = !DILocation(line: 25, column: 5, scope: !70)
!83 = !DILocation(line: 25, column: 8, scope: !70)
!84 = !DILocation(line: 25, column: 10, scope: !70)
!85 = !DILocation(line: 26, column: 13, scope: !70)
!86 = !DILocation(line: 26, column: 5, scope: !70)
!87 = !DILocation(line: 26, column: 8, scope: !70)
!88 = !DILocation(line: 26, column: 10, scope: !70)
!89 = !DILocation(line: 27, column: 1, scope: !70)
!90 = distinct !DISubprogram(name: "mat3_transform", scope: !1, file: !1, line: 29, type: !91, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !93, !46, !13}
!93 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!94 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !95)
!95 = !DIDerivedType(tag: DW_TAG_typedef, name: "Mat3x3", file: !1, line: 11, baseType: !96)
!96 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 7, size: 288, elements: !97)
!97 = !{!98, !99, !100, !101, !102, !103, !104, !105, !106}
!98 = !DIDerivedType(tag: DW_TAG_member, name: "m00", scope: !96, file: !1, line: 8, baseType: !18, size: 32)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "m01", scope: !96, file: !1, line: 8, baseType: !18, size: 32, offset: 32)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "m02", scope: !96, file: !1, line: 8, baseType: !18, size: 32, offset: 64)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "m10", scope: !96, file: !1, line: 9, baseType: !18, size: 32, offset: 96)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "m11", scope: !96, file: !1, line: 9, baseType: !18, size: 32, offset: 128)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "m12", scope: !96, file: !1, line: 9, baseType: !18, size: 32, offset: 160)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "m20", scope: !96, file: !1, line: 10, baseType: !18, size: 32, offset: 192)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "m21", scope: !96, file: !1, line: 10, baseType: !18, size: 32, offset: 224)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "m22", scope: !96, file: !1, line: 10, baseType: !18, size: 32, offset: 256)
!107 = !DILocalVariable(name: "m", arg: 1, scope: !90, file: !1, line: 29, type: !93)
!108 = !DILocation(line: 29, column: 35, scope: !90)
!109 = !DILocalVariable(name: "src", arg: 2, scope: !90, file: !1, line: 29, type: !46)
!110 = !DILocation(line: 29, column: 50, scope: !90)
!111 = !DILocalVariable(name: "dst", arg: 3, scope: !90, file: !1, line: 29, type: !13)
!112 = !DILocation(line: 29, column: 61, scope: !90)
!113 = !DILocation(line: 30, column: 15, scope: !90)
!114 = !DILocation(line: 30, column: 18, scope: !90)
!115 = !DILocation(line: 30, column: 24, scope: !90)
!116 = !DILocation(line: 30, column: 29, scope: !90)
!117 = !DILocation(line: 30, column: 22, scope: !90)
!118 = !DILocation(line: 30, column: 35, scope: !90)
!119 = !DILocation(line: 30, column: 38, scope: !90)
!120 = !DILocation(line: 30, column: 44, scope: !90)
!121 = !DILocation(line: 30, column: 49, scope: !90)
!122 = !DILocation(line: 30, column: 42, scope: !90)
!123 = !DILocation(line: 30, column: 32, scope: !90)
!124 = !DILocation(line: 30, column: 55, scope: !90)
!125 = !DILocation(line: 30, column: 58, scope: !90)
!126 = !DILocation(line: 30, column: 64, scope: !90)
!127 = !DILocation(line: 30, column: 69, scope: !90)
!128 = !DILocation(line: 30, column: 62, scope: !90)
!129 = !DILocation(line: 30, column: 52, scope: !90)
!130 = !DILocation(line: 30, column: 5, scope: !90)
!131 = !DILocation(line: 30, column: 10, scope: !90)
!132 = !DILocation(line: 30, column: 12, scope: !90)
!133 = !DILocation(line: 31, column: 15, scope: !90)
!134 = !DILocation(line: 31, column: 18, scope: !90)
!135 = !DILocation(line: 31, column: 24, scope: !90)
!136 = !DILocation(line: 31, column: 29, scope: !90)
!137 = !DILocation(line: 31, column: 22, scope: !90)
!138 = !DILocation(line: 31, column: 35, scope: !90)
!139 = !DILocation(line: 31, column: 38, scope: !90)
!140 = !DILocation(line: 31, column: 44, scope: !90)
!141 = !DILocation(line: 31, column: 49, scope: !90)
!142 = !DILocation(line: 31, column: 42, scope: !90)
!143 = !DILocation(line: 31, column: 32, scope: !90)
!144 = !DILocation(line: 31, column: 55, scope: !90)
!145 = !DILocation(line: 31, column: 58, scope: !90)
!146 = !DILocation(line: 31, column: 64, scope: !90)
!147 = !DILocation(line: 31, column: 69, scope: !90)
!148 = !DILocation(line: 31, column: 62, scope: !90)
!149 = !DILocation(line: 31, column: 52, scope: !90)
!150 = !DILocation(line: 31, column: 5, scope: !90)
!151 = !DILocation(line: 31, column: 10, scope: !90)
!152 = !DILocation(line: 31, column: 12, scope: !90)
!153 = !DILocation(line: 32, column: 15, scope: !90)
!154 = !DILocation(line: 32, column: 18, scope: !90)
!155 = !DILocation(line: 32, column: 24, scope: !90)
!156 = !DILocation(line: 32, column: 29, scope: !90)
!157 = !DILocation(line: 32, column: 22, scope: !90)
!158 = !DILocation(line: 32, column: 35, scope: !90)
!159 = !DILocation(line: 32, column: 38, scope: !90)
!160 = !DILocation(line: 32, column: 44, scope: !90)
!161 = !DILocation(line: 32, column: 49, scope: !90)
!162 = !DILocation(line: 32, column: 42, scope: !90)
!163 = !DILocation(line: 32, column: 32, scope: !90)
!164 = !DILocation(line: 32, column: 55, scope: !90)
!165 = !DILocation(line: 32, column: 58, scope: !90)
!166 = !DILocation(line: 32, column: 64, scope: !90)
!167 = !DILocation(line: 32, column: 69, scope: !90)
!168 = !DILocation(line: 32, column: 62, scope: !90)
!169 = !DILocation(line: 32, column: 52, scope: !90)
!170 = !DILocation(line: 32, column: 5, scope: !90)
!171 = !DILocation(line: 32, column: 10, scope: !90)
!172 = !DILocation(line: 32, column: 12, scope: !90)
!173 = !DILocation(line: 33, column: 1, scope: !90)
!174 = distinct !DISubprogram(name: "caller_render_pipeline", scope: !1, file: !1, line: 35, type: !175, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !21)
!175 = !DISubroutineType(types: !176)
!176 = !{!18, !18, !18, !18, !18}
!177 = !DILocalVariable(name: "x", arg: 1, scope: !174, file: !1, line: 35, type: !18)
!178 = !DILocation(line: 35, column: 32, scope: !174)
!179 = !DILocalVariable(name: "y", arg: 2, scope: !174, file: !1, line: 35, type: !18)
!180 = !DILocation(line: 35, column: 39, scope: !174)
!181 = !DILocalVariable(name: "z", arg: 3, scope: !174, file: !1, line: 35, type: !18)
!182 = !DILocation(line: 35, column: 46, scope: !174)
!183 = !DILocalVariable(name: "scale", arg: 4, scope: !174, file: !1, line: 35, type: !18)
!184 = !DILocation(line: 35, column: 53, scope: !174)
!185 = !DILocalVariable(name: "input_v", scope: !174, file: !1, line: 36, type: !14)
!186 = !DILocation(line: 36, column: 10, scope: !174)
!187 = !DILocation(line: 37, column: 25, scope: !174)
!188 = !DILocation(line: 37, column: 28, scope: !174)
!189 = !DILocation(line: 37, column: 31, scope: !174)
!190 = !DILocation(line: 37, column: 5, scope: !174)
!191 = !DILocation(line: 38, column: 26, scope: !174)
!192 = !DILocation(line: 38, column: 5, scope: !174)
!193 = !DILocalVariable(name: "mat", scope: !174, file: !1, line: 40, type: !95)
!194 = !DILocation(line: 40, column: 12, scope: !174)
!195 = !DILocalVariable(name: "out_v", scope: !174, file: !1, line: 46, type: !14)
!196 = !DILocation(line: 46, column: 10, scope: !174)
!197 = !DILocation(line: 47, column: 5, scope: !174)
!198 = !DILocation(line: 49, column: 12, scope: !174)
!199 = !DILocation(line: 49, column: 5, scope: !174)
!200 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 52, type: !201, scopeLine: 52, spFlags: DISPFlagDefinition, unit: !0)
!201 = !DISubroutineType(types: !202)
!202 = !{!18}
!203 = !DILocation(line: 53, column: 12, scope: !200)
!204 = !DILocation(line: 53, column: 5, scope: !200)
