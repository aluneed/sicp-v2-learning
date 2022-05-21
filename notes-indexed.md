# 0 目录 Contents
# 0 非官方说明 Unofficial Texinfo Format
# 0 献词 Dedication
# 0 序 Foreword
# 0 第2版前言 Preface to the Second Edition
# 0 第1版前言 Preface to the First Edition
# 0 致谢 Acknowledgments
# 1 通过过程(procedure)建立抽象 Building Abstractions with Procedures 构造过程抽象
## 1.1 程序设计的基本元素 The Elements of Programming
### 1.1.1 表达式 Expressions
### 1.1.2 命名和环境 Naming and the Environment
### 1.1.3 组合式的求值(计算组合式) Evaluating Combinations
### 1.1.4 符合过程 Compound Procedures
### 1.1.5 过程应用的代换模型 The Substitution Model for Procedure Application
### 1.1.6 条件表达式和谓词 Conditional Expressions and Predicates
### 1.1.7 实例: 采用牛顿法求平方根 Example: Square Roots by Newton's Method
### 1.1.8 过程作为黑箱抽象 Procedures as Black-Box Abstractions
## 1.2 过程与它们所产生的计算 Procedures and the Processes They Generate
### 1.2.1 线性的递归和迭代 Linear Recursion and Iteration
### 1.2.2 树形递归 Tree Recursion
### 1.2.3 增长的阶 Orders of Growth (增长)的阶, 不是 (增长的)阶
### 1.2.4 求幂 Exponentiation 指数运算
### 1.2.5 最大公约数 Greatest Common Divisors 最大工共因子(把乘数看作因子之积)
### 1.2.6 实例: 素数检测 Example: Testing for Primality
## 1.3 用高阶函数做抽象 Formulating Abstractions with Higher-Order Procedures 用高阶函数构造抽象
### 1.3.1 过程作为参数 Procedures as Arguments
### 1.3.2 用lambda构造过程 Constructing Procedures Using lambda
### 1.3.3 过程作为一般性的方法 Procedures as General Methods
### 1.3.4 过程作为返回值 Procedures as Returned Values
# 2 通过数据建立抽象 Building Abstractions with Data 构造数据抽象
## 2.1 数据抽象导论 Introduction to Data Abstraction 不知道怎么翻译成数据抽象引导的
### 2.1.1 实例: 有理数的算数运算 Example: Arithmetic Operations for Rational Numbers
### 2.1.2 抽象屏障 Abstraction Barriers
### 2.1.3 数据意味着什么 What Is Meant by Data?
### 2.1.4 扩展练习: 区间算术 Extended Exercise: Interval Arithmetic
## 2.2 层次性数据和闭包性质 Hierarchical Data and the Closure Property 分层数据
### 2.2.1 序列的表示 Representing Sequences
### 2.2.2 层次性结构 Hierarchical Structures
### 2.2.3 序列作为传统常见接口 Sequences as Conventional Interfaces 序列作为一种约定的界面
### 2.2.4 实例: 一个图形语言 Example: A Picture Language
## 2.3 符号数据 Symbolic Data
### 2.3.1 引号 Quotation
### 2.3.2 实例: 符号求导 Example: Symbolic Differentiation 符号微分
### 2.3.3 实例: 集合的表示 Example: Representing Sets
### 2.3.4 实例: Huffman编码树 Example: Huffman Encoding Trees
## 2.4 抽象数据的多重表示 Multiple Representations for Abstract Data
### 2.4.1 复数的表示 Representations for Complex Numbers
### 2.4.2 带标志的数据 Tagged Data
### 2.4.3 数据导向程序设计和可加性 Data-Directed Programming and Additivity 数据导向的程序设计和可加性 
## 2.5 带有通用型操作的系统 Systems with Generic Operations
### 2.5.1 通用型算数运算 Generic Arithmetic Operations
### 2.5.2 不同类型数据的组合 Combining Data of Different Types
### 2.5.3 实例: 符号代数 Example: Symbolic Algebra
# 3 模块化, 对象和状态 Modularity, Objects, and State
## 3.1 赋值和局部状态 Assignment and Local State
### 3.1.1 局部状态变量 Local State Variables
### 3.1.2 引进赋值带来的利益 The Benefits of Introducing Assignment
### 3.1.3 引进赋值的代价 The Costs of Introducing Assignment
## 3.2 求值的环境模型 The Environment Model of Evaluation
### 3.2.1 求值规则 The Rules for Evaluation
### 3.2.2 简单过程的应用 Applying Simple Procedures
### 3.2.3 框架作为局部状态的仓库 Frames as the Repository of Local State 将框架看作局部状态的展台
### 3.2.4 内部定义 Internal Definitions
## 3.3 通过变动数据建模 Modeling with Mutable Data 用变动数据做模拟
### 3.3.1 变动的表结构 Mutable List Structure
### 3.3.2 队列的表示 Representing Queues
### 3.3.3 表格的表示 Representing Tables
### 3.3.4 数字电路的模拟器 A Simulator for Digital Circuits
### 3.3.5 约束的传播 Propagation of Constraints
checked exception和null检查算么?
## 3.4 并发: 时间至关重要 Concurrency: Time Is of the Essence 并发: 时间是一个本质问题
### 3.4.1 并发系统中时间的性质 The Nature of Time in Concurrent Systems
### 3.4.2 控制并发的机制 Mechanisms for Controlling Concurrency
## 3.5 流 Streams
### 3.5.1 流是延时的List Streams Are Delayed Lists 流作为延时的表
### 3.5.2 无穷流 Infinite Streams
### 3.5.3 流范式的使用 Exploiting the Stream Paradigm 流计算模式的使用
### 3.5.4 流和延时求值 Streams and Delayed Evaluation
### 3.5.5 函数式程序的模块化和对象的模块化 Modularity of Functional Programs and Modularity of Objects
# 4 元语言抽象 Metalinguistic Abstraction
## 4.1 元循环求值器 The Metacircular Evaluator (元循环)求值器
### 4.1.1 求值器的内核 The Core of the Evaluator
### 4.1.2 表达式的表示 Representing Expressions
### 4.1.3 求值器数据结构 Evaluator Data Structures
### 4.1.4 求值器作为程序运行 Running the Evaluator as a Program 作为程序运行这个求值器
### 4.1.5 数据作为程序 Data as Programs
### 4.1.6 内部定义 Internal Definitions
### 4.1.7 将语法分析与执行分离 Separating Syntactic Analysis from Execution
## 4.2 Scheme的变体 - 惰性求值 Variations on a Scheme — Lazy Evaluation Scheme的变形
### 4.2.1 常规(正则)序和应用序 Normal Order and Applicative Order 正则序和应用序
### 4.2.2 一个采用惰性求值的解释器 An Interpreter with Lazy Evaluation
### 4.2.3 流作为惰性的List Streams as Lazy Lists
## 4.3 Scheme的变体 - 非确定性计算 Variations on a Scheme — Nondeterministic Computing Scheme的变形
### 4.3.1 amb和搜索 Amb and Search
### 4.3.2 非确定性程序的实例 Examples of Nondeterministic Programs
### 4.3.3 实现amb求值器 Implementing the amb Evaluator
## 4.4 逻辑程序设计 Logic Programming
### 4.4.1 演绎信息检索 Deductive Information Retrieval
### 4.4.2 查询系统如何工作 How the Query System Works
### 4.4.3 逻辑程序设计是数理逻辑吗 Is Logic Programming Mathematical Logic?
### 4.4.4 查询系统的实现 Implementing the Query System
#### 4.4.4.1 驱动循环及实例化 The Driver Loop and Instantiation
#### 4.4.4.2 求值器 The Evaluator
#### 4.4.4.3 通过模式匹配寻找断言 Finding Assertions by Pattern Matching
#### 4.4.4.4 规则和一致性(单一化?) Rules and Unification
#### 4.4.4.5 数据库的维护 Maintaining the Data Base
#### 4.4.4.6 流操作 Stream Operations
#### 4.4.4.7 查询语法过程 Query Syntax Procedures
#### 4.4.4.8 框架和绑定 Frames and Bindings
# 5 通过寄存器机器计算 Computing with Register Machines 寄存器机器里的计算
## 5.1 寄存器机器里的计算 Designing Register Machines
### 5.1.1 一种描述寄存器机器的语言 A Language for Describing Register Machines
### 5.1.2 机器设计的抽象 Abstraction in Machine Design
### 5.1.3 子程序 Subroutines
### 5.1.4 通过栈实现递归 Using a Stack to Implement Recursion 采用堆栈实现递归
### 5.1.5 指令总结 Instruction Summary
## 5.2 一个寄存器机器模拟器 A Register-Machine Simulator
### 5.2.1 机器模型 The Machine Model
### 5.2.2 汇编器 The Assembler 汇编程序
### 5.2.3 构造指令的执行过程 Generating Execution Procedures for Instructions 为指令生成执行过程
### 5.2.4 监视机器执行 Monitoring Machine Performance
## 5.3 存储分配和垃圾回收 Storage Allocation and Garbage Collection 存储分配和废料收集
### 5.3.1 内存作为向量 Memory as Vectors 将存储看作向量
### 5.3.2 维持无线内存的假象 Maintaining the Illusion of Infinite Memory 维持一种无穷存储的假象
## 5.4 显示控制的求值器 The Explicit-Control Evaluator
### 5.4.1 显示控制的求值器的内核 The Core of the Explicit-Control Evaluator
### 5.4.2 顺序求值和尾递归 Sequence Evaluation and Tail Recursion 序列的求值和尾递归
### 5.4.3 条件, 赋值和定义 Conditionals, Assignments, and Definitions
### 5.4.4 求值器的运行 Running the Evaluator
## 5.5 编译 Compilation
### 5.5.1 编译器的结构 Structure of the Compiler
### 5.5.2 表达式的编译 Compiling Expressions
### 5.5.3 组合式的编译 Compiling Combinations
### 5.5.4 指令序列的组合 Combining Instruction Sequences
### 5.5.5 编译代码的实例 An Example of Compiled Code
### 5.5.6 词法寻址 Lexical Addressing 词法地址
### 5.5.7 连接编译后的代码至求值器 Interfacing Compiled Code to the Evaluator 编译代码与求值器的互连
# 6 参考文献 References
# 7 练习列表 List of Exercises
# 8 配图列表 List of Figures
# 9 索引 Index
# 10 尾页 说明 Colophon
