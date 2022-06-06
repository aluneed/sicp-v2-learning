# goal

java实现scheme编译至go

编译后的代码应当与scheme直接运行的代码拥有相同的行为  

尽可能支持scheme的表达(标准关键字和标准过程), 以及go的关键字  

# ref

https://zh.wikipedia.org/zh-cn/Scheme  
- 标准形式和过程概述



# code map

为了支持go的一些特性(比如接口和类型)也需要额外的定义  
定义过程还是定义新的扩展语法有待商榷  

大小写区分export也是个麻烦事  

## define -> func/const

```scheme
(define x (PROCEDURE))
(define (functionName PARAM_LIST) (PROCEDURE))
```

```go
const x = COMPILED_PROCEDURE
func functionName(PARAM_LIST_WITH_TYPE) <TYPE> {  //需要对PROCEDURE代码进行类型推断
  COMPILED_PROCEDURE
}
```

## ? -> type

```scheme
(type TestType (field1Name Type1Name) (field2Name Type2Name))  ;;需要扩展语法, 如果不追求scheme bootstrap的话, 可以直接用java解析

;;???
(type TestType Field1 Field2 ..)
(define Field1 (cons field1Name Type1Name))
(define Field2 (cons field2Name Type2Name))
```

```go
type TestType struct {
  field1 Type1
  field2 Type2
}
```


## delay -> defer? 感觉差别很大


# features

type, interface

closure  
lambda  
let -> var  

if, cond, case

tail recursion/call optimizing