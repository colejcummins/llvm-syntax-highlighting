target triple="x86_64"
%struct.simple = type {i64}
%struct.foo = type {i64, i64, %struct.simple*}

@globalfoo = common global %struct.foo* null, align 4

define void @tailrecursive(i64 %num)
{
vector.vector:
  br label %LU3
LU3:
  %u0 = icmp sle i64 %num, 0
  %u1 = zext i1 %u0 to i64
  %u2 = trunc i64 %u1 to i1
  br i1 %u2, label %LU5, label %LU4
LU5:
  ret void
LU4:
  %u5 = sub i64 %num, 1
  call void @tailrecursive(i64 %u5)
  ret void
}


define i64 @add(i64 %x, i64 %y)
{
LU11:
  br label %LU12
LU12:
  %u6 = add i64 %x, %y
  ret i64 %u6
}

define void @domath(i64 %num)
{
LU21:
  br label %LU22
LU22:
  %u7 = call i8* @malloc(i64 24)
  %u8 = bitcast i8* %u7 to %struct.foo*
  %u9 = call i8* @malloc(i64 8)
  %u10 = bitcast i8* %u9 to %struct.simple*
  %u11 = getelementptr %struct.foo, %struct.foo* %u8, i1 0, i32 2
  store %struct.simple* %u10, %struct.simple** %u11
  %u12 = call i8* @malloc(i64 24)
  %u13 = bitcast i8* %u12 to %struct.foo*
  %u14 = call i8* @malloc(i64 8)
  %u15 = bitcast i8* %u14 to %struct.simple*
  %u16 = getelementptr %struct.foo, %struct.foo* %u13, i1 0, i32 2
  store %struct.simple* %u15, %struct.simple** %u16
  %u17 = getelementptr %struct.foo, %struct.foo* %u8, i1 0, i32 0
  store i64 %num, i64* %u17
  %u18 = getelementptr %struct.foo, %struct.foo* %u13, i1 0, i32 0
  store i64 3, i64* %u18
  %u19 = getelementptr %struct.foo, %struct.foo* %u8, i1 0, i32 0
  %u20 = load i64, i64* %u19
  %u21 = getelementptr %struct.foo, %struct.foo* %u8, i1 0, i32 2
  %u22 = load %struct.simple*, %struct.simple** %u21
  %u23 = getelementptr %struct.simple, %struct.simple* %u22, i1 0, i32 0
  store i64 %u20, i64* %u23
  %u24 = getelementptr %struct.foo, %struct.foo* %u13, i1 0, i32 0
  %u25 = load i64, i64* %u24
  %u26 = getelementptr %struct.foo, %struct.foo* %u13, i1 0, i32 2
  %u27 = load %struct.simple*, %struct.simple** %u26
  %u28 = getelementptr %struct.simple, %struct.simple* %u27, i1 0, i32 0
  store i64 %u25, i64* %u28
  %u29 = icmp sgt i64 %num, 0
  %u30 = zext i1 %u29 to i64
  %u31 = trunc i64 %u30 to i1
  br i1 %u31, label %LU24, label %LU23
LU24:
  %u32 = phi i64 [%num, %LU22], [%u61, %LU24]
  %u33 = phi %struct.foo* [%u8, %LU22], [%u33, %LU24]
  %u34 = phi %struct.foo* [%u13, %LU22], [%u34, %LU24]
  %u61 = sub i64 %u32, 1
  %u62 = icmp sgt i64 %u61, 0
  %u63 = zext i1 %u62 to i64
  %u64 = trunc i64 %u63 to i1
  br i1 %u64, label %LU24, label %LU23
LU23:
  %u66 = phi %struct.foo* [%u33, %LU24], [%u8, %LU22]
  %u67 = phi %struct.foo* [%u34, %LU24], [%u13, %LU22]
  %u69 = bitcast %struct.foo* %u66 to i8*
  call void @free(i8* %u69)
  %u70 = bitcast %struct.foo* %u67 to i8*
  call void @free(i8* %u70)
  ret void
}


define void @objinstantiation(i64 %num) {
LU31:
  br label %LU32
LU32:
  %u71 = icmp sgt i64 %num, 0
  %u72 = zext i1 %u71 to i64
  %u73 = trunc i64 %u72 to i1
  br i1 %u73, label %LU34, label %LU33
LU34:
  %u74 = phi i64 [%num, %LU32], [%u79, %LU34]
  %u76 = call i8* @malloc(i64 24)
  %u77 = bitcast i8* %u76 to %struct.foo*
  %u78 = bitcast %struct.foo* %u77 to i8*
  call void @free(i8* %u78)
  %u79 = sub i64 %u74, 1
  %u80 = icmp sgt i64 %u79, 0
  %u81 = zext i1 %u80 to i64
  %u82 = trunc i64 %u81 to i1
  br i1 %u82, label %LU34, label %LU33
LU33:
  ret void
}


define i64 @ackermann(i64 %m, i64 %n)
{
LU41:
  br label %LU42
LU42:
  %u85 = icmp eq i64 %m, 0
  %u86 = zext i1 %u85 to i64
  %u87 = trunc i64 %u86 to i1
  br i1 %u87, label %LU44, label %LU43
LU44:
  %u88 = add i64 %n, 1
  ret i64 %u88
LU43:
  %u89 = icmp eq i64 %n, 0
  %u90 = zext i1 %u89 to i64
  %u91 = trunc i64 %u90 to i1
  br i1 %u91, label %LU47, label %LU48
LU47:
  %u92 = sub i64 %m, 1
  %u93 = call i64 @ackermann(i64 %u92, i64 1)
  ret i64 %u93
LU48:
  %u94 = sub i64 %m, 1
  %u95 = sub i64 %n, 1
  %u96 = call i64 @ackermann(i64 %m, i64 %u95)
  %u97 = call i64 @ackermann(i64 %u94, i64 %u96)
  ret i64 %u97
}


define i64 @main()
{
LU51:
  br label %LU52
LU52:
  call i64 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i64* @.read_scratch)
  %u98 = load i64, i64* @.read_scratch
  call i64 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i64* @.read_scratch)
  %u99 = load i64, i64* @.read_scratch
  call i64 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i64* @.read_scratch)
  %u100 = load i64, i64* @.read_scratch
  call i64 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i64* @.read_scratch)
  %u101 = load i64, i64* @.read_scratch
  call i64 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i64* @.read_scratch)
  %u102 = load i64, i64* @.read_scratch
  call void @tailrecursive(i64 %u98)
  call i64 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i64 %u98)
  call void @domath(i64 %u99)
  call i64 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i64 %u99)
  call void @objinstantiation(i64 %u100)
  call i64 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i64 %u100)
  %u103 = call i64 @ackermann(i64 %u101, i64 %u102)
  call i64 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i64 %u103)
  ret i64 0
}


declare i8* @malloc(i64)
declare void @free(i8*)
declare i64 @printf(i8*, ...)
declare i64 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i64 0, align 4

