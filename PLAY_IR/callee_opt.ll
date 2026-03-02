; llvm-as calleee_opt.ll -o callee_opt.bc
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @callee(i32* %X) #0 {
entry:
  %X.addr = alloca i32*, align 8
  store i32* %X, i32** %X.addr, align 8
  %0 = load i32*, i32** %X.addr, align 8
  %1 = load i32, i32* %0, align 4
  %add = add nsw i32 %1, 1
  ret i32 %add
}
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %T = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 4, i32* %T, align 4
  %call = call i32 @callee(i32* %T)
  ret i32 %call
}
