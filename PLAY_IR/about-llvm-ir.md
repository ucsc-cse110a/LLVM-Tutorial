int callee(const int* X) {
    return *X + 1;
}

int callee(const int* X) {
    return *X + 1;
}

int main() {
	int T = 4;
	return callee(&T);
}

$> clang -Xclang -disable-O0-optnone -S -emit-llvm f.c -o f.ll
  optnone will prevent the program from being optimized.

source_filename = "callee.c"
...
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
...

alloca - alocates on the stack.

Can optimize IR, e.g. 
 e.g. use an optpass:
    mem2reg (convert memory to reg)

; ModuleID = 'callee.c'
To optimize regs:
  opt -S mem2reg f.ll -o f_opt.ll

define dso_local i32 @callee(i32* %X) #0 {
entry:
  %0 = load i32, i32* %X, align 4
  %add = add nsw i32 %0, 1
  ret i32 %add
}

Change pointer to by value:

int callee(int X) {
   return X + 1;
}
int main() {
  int T = 4;
  return callee(T);
}

define dso_local i32 @callee(i32 %X) #0 {
entry:
  %add = add nsw i32 %X, 1
  ret i32 %add
}
define dso_local i32 @main() #0 {
entry:
  %call = call i32 @callee(i32 4)
  ret i32 %call
}

Say it is named:
  callee_opt.ll

Then:
  llvm-as callee_opt.ll -o callee-opt.bc
  llc callee_opt.bc -o callee_opt.x86
  as callee_opt.x86 -o callee_opt.o
  ls -la callee_opt.*
    ...bc
    ...ll
    ...o
    ...x86
  
  fernando@gcc.urmg.or
  http://lac.dcc.ufmg.br
  https://llvm.org/docs/LangRef.html


