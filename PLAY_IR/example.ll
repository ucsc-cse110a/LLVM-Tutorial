; example.ll
; Demonstrates printf, scanf, and basic arithmetic in LLVM IR
; Works on x86_64 Linux

@prompt = private unnamed_addr constant [17 x i8] c"Enter a number: \00"
@result_str = private unnamed_addr constant [27 x i8] c"Your number plus 5 is: %d\0A\00"
@int_format = private unnamed_addr constant [3 x i8] c"%d\00"

declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)

define i32 @main() {
entry:
    ; Allocate space for an integer
    %num = alloca i32

    ; Print prompt
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @prompt, i32 0, i32 0))

    ; Read integer from user
    call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @int_format, i32 0, i32 0), i32* %num)

    ; Load, add 5
    %val = load i32, i32* %num
    %sum = add i32 %val, 5

    ; Print result
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @result_str, i32 0, i32 0), i32 %sum)

    ret i32 0
}
