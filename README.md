## Reminder

### Data

|          Size        | Instruction |
|          ---         |     ---     |
| 8-bits               |    db       |
| 16-bits              |    dw       |
| 32-bits              |    dd       |
| 64-bits              |    ddq / do |
| float                |    dd       |
| double               |    dq       |
| extended precision   |    dt       |


### NASM code-sections 
| Segment       |    Meaning         |  c equivalent example  |
|   ----        |        -----       |       ---------        |
| .text         | Code               |  printf("%d", i);      |
| [.data](#bss) | Initialized Data   |  int i = 1;            |
| [.bss](#bss)  | Uninitialized Data |  int i;                |


#### <a name="data">.data</a> (`Initialized Data`) :

|     unit    |          | Size in bytes (octet) |     c equivalent example              |
|     ----    |   ----   |        -----          |          ---------                    |
| Byte        | db       | 1                     |  `char c = 'a';`                      |
| Word        | dw       | 2                     |  `short int i = 4;`                   |
| Double Word | dd       | 4                     |  `int i = 42;`  `float f = 1.4f;`     |
| Quad Word   | dq       | 8                     |  `long int i = 13;`  `double d = 1.4;`|
| 10 bytes    | dt       | 10                    |  `long double d = 4.42;`              |

`d` stand for `defined`.

#### <a name="bss">.bss</a> (`Uninitialized Data`) :

|     unit    |          | Size in bytes (octet) |     c equivalent example  |
|     ----    |   ----   |        -----          |          ---------        |
| Byte        | resb     | 1                     | `char c;`                 |
| Word        | resw     | 2                     | `short int i;`            |
| Double Word | resd     | 4                     | `int i;`  `float f;`      |
| Quad Word   | resq     | 8                     | `long int i;` `double d;` |
| 10 bytes    | rest     | 10                    | `long double d;`          |

`res` stand for `reserved`.



### Registers :

<table>
  <tr>
    <td>00000000</td><td>00000000</td><td>00000000</td><td>00000000</td>
    <td>00000000</td><td>00000000</td><td>00000000</td><td>00000000</td>
  </tr>
  <tr><td colspan="7"></td><td colspan="1" align="center">al </td></tr>
  <tr><td colspan="6"></td><td colspan="2" align="center">ax </td></tr>
  <tr><td colspan="4"></td><td colspan="4" align="center">eax</td></tr>
  <tr><td colspan="8" align="center">rax</td></tr>
</table>


| 8-bit | 16-bit | 32-bit | 64-bit |                                |
|-------|--------|--------|--------|               ----             |
| al    | ax     | eax    | **rax**| accumulaor                     |
| bl    | bx     | ebx    | **rbx**| base, addressing               |
| cl    | cx     | ecx    | **rcx**| counter, iterations            |
| dl    | dx     | edx    | **rdx**| data                           |
| sil   | si     | esi    | **rsi**|             -                  |
| dil   | di     | edi    | **rdi**|             -                  |
| bpl   | bp     | ebp    | **rbp**| frame pointer                  |
| spl   | sp     | esp    | **rsp**| Stack pointer                  |
| r8b   | r8w    | r8d    | **r8** |              -                 |
| r9b   | r9w    | r9d    | **r9** |              -                 |
| r10b  | r10w   | r10d   | **r10**|              -                 |
| r11b  | r11w   | r11d   | **r11**|              -                 |
| r12b  | r12w   | r12d   | **r12**|              -                 |
| r13b  | r13w   | r13d   | **r13**|              -                 |
| r14b  | r14w   | r14d   | **r14**|              -                 |
| r15b  | r15w   | r15d   | **r15**|              -                 |


### syscall input by register :

| syscall   | ID (%rax) | ARG_1 (%rdi)| ARG_2 (%rsi) | ARG_3 (%rdx) | ARG_4 (%r10) | ARG_5 (%r8) | ARG_6 (%r9) |
|-----------|-----------|     :---:   |     :---:    |     :---:    |--------------|--------------|--------------|
| sys_read  |     0     |      fd     | **&** buffer |    count     |              |              |              |
| sys_write |     1     |      fd     | **&** buffer |    count     |              |              |              |
| sys_open  |     2     |   filename  |     Flags    |    mode      |              |              |              |
| sys_close |     3     |      fd     |              |              |              |              |              |
| sys_exit  |    60     |  error_code |     ...      |     ...      |     ...      |      ...     |     ...      |
|    ...    |    ...    |     ...     |     ...      |     ...      |     ...      |      ...     |     ...      |
| pwritev2  |    328    |     ...     |     ...      |     ...      |     ...      |      ...     |     ...      |


### Flags 

| Flag symbol |        Type Flag       |        Description                    |
|    :---:    |         ---            |        ---                            | 
|     CF      |    Carry               |   It contains the carry of 0 or 1 from a high-order bit (leftmost) after an arithmetic operation. It also stores the contents of last bit of a shift or rotate operation. |
|     PF      |    Parity              | It indicates the total number of 1-bits in the result obtained from an arithmetic operation. An even number of 1-bits clears the parity flag to 0 and an odd number of 1-bits sets the parity flag to 1. |
|     ZF      |    Zero                | It indicates the result of an arithmetic or comparison operation. A nonzero result clears the zero flag to 0, and a zero result sets it to 1. |
|     SF      |    Sign                | It shows the sign of the result of an arithmetic operation. This flag is set according to the sign of a data item following the arithmetic operation. The sign is indicated by the high-order of leftmost bit. A positive result clears the value of SF to 0 and negative result sets it to 1. |
|     OF      |    Overflow            | It indicates the overflow of a high-order bit (leftmost bit) of data after a signed arithmetic operation.   |
|     AF      |    Auxiliary Carry     | It contains the carry from bit 3 to bit 4 following an arithmetic operation; used for specialized arithmetic. The AF is set when a 1-byte arithmetic operation causes a carry from bit 3 into bit 4. |
|     IF      |    Interrupt Enabed    | It determines whether the external interrupts like keyboard entry, etc., are to be ignored or processed. It disables the external interrupt when the value is 0 and enables interrupts when set to 1. |
|     TF      |    Trap                |  It allows setting the operation of the processor in single-step mode. The DEBUG program we used sets the trap flag, so we could step through the execution one instruction at a time. |
|     DF      |    Direction           | It determines left or right direction for moving or comparing string data. When the DF value is 0, the string operation takes left-to-right direction and when the value is set to 1, the string operation takes right-to-left direction.  |


### Pointers 

| Pointer Name  |      Meaning       |                       Description                             |
|---------------|--------------------|---------------------------------------------------------------|
| rip (eip, ip) | Index pointer      | Points to next address to be executed in the control flow.    |
| rsp (esp, sp) | Stack pointer      | Points to the top address of the stack.                       |
| rbp (ebp, bp)  | Stack base pointer | Points to the bottom of the stack.                            |
|      ...      |        ...         |                         ...                                   |


### jump symbols

| Jump symbol (signed) | Jump symbol (unsigned) | result of cmp a, b    |
|       :---:          |          :---:         |        :---:          |
|         je           |            -           |        a =  b         |
|         jne          |            -           |        a != b         |
|         jg           |           ja           |        a >  b         |
|         jge          |           jae          |        a >= b         |
|         jl           |           jb           |        a <  b         |
|         jle          |           jbe          |        a <= b         |
|         jz           |            -           |        a =  0         |
|         jnz          |            -           |        a != 0         |
|         jo           |            -           | Overflow occured      |
|         jno          |            -           | Overlow did not occur |
|         js           |            -           | Jump if signed        |
|         jns          |            -           | Jump if not signed    |

### Registers as pointers

The default registers can be treated as pointers.
To treat a register as  a pointer, surround the register name with square brackets.
Such as, "rax" becomes "[rax]".

mov rax, rbx      # loads the value of rbx into rax    
mov rax, [rbx]    # loads the value the rbx register is pointing to, into rax. Like dereferencing pointer in c

### Math operations list

| Operation Name | Operation Name (signed)  |      Description     |
|       ---      |          :---:           |          ---         |
|    add a, b    |             -            |     a = a + b        |
|    sub a, b    |             -            |     a = a - b        |
|    mul reg     |         imul reg         |   rax = rax * reg    |
|    div reg     |         idiv reg         |   rax = rax / reg    |
|    neg reg     |             -            |   reg = -reg         |
|    inc reg     |             -            |   reg = reg + 1      |
|    dec reg     |             -            |   reg = reg - 1      |
|    adc a, b    |             -            |     a = a + b + CF   |
|    sbb a, b    |             -            |     a = a - b - CF   |

%rdx hold the remainder of division. Also, if %rdx is not zero, %rax and %rdx will act as a 128bits registers. To avoid unexpected results. Set %rdx to 0.


### Stack operations

|   Operation    |                   Description                   |
|     :---:      |                       ---                       |
| push reg/value | Pushes a value onto the stack                   |
| pop reg        | Pops a value off the stack and stores it in reg |
| mov reg, [rsp] | Stores the peek value in reg                    |

Note : Usually in places where you can use registers, you can also use pointers.
Such as, instead of "pop reg", you can use "pop [label]" to pop a value off the stack directly into a position in memory.


### Instructions

|               |                                                 Purpose                                                  |
|       ---     |                                                   ---                                                    |
| mov dest, src | Move data between registers, load immediate data into registers, move data between registers and memory. |
| push src      | Insert a value onto the stack.  Useful for passing arguments, saving registers, etc.                     |
| pop dest      | Remove topmost value from the stack.  Equivalent to "mov dest, [rsp]; add 8,rsp".                        |
| call label     | Push the address of the next instruction and start executing func.                                       |
| ret           | Pop the return program counter, and jump there.  Ends a subroutine.                                      |
| add dest, src | dest = dest + src                                                                                        |
| mul src       | Multiply rax and src as unsigned integers, and put the result in rax.  High 64 bits of product (usually zero) go into rdx                                                                                                          |
| div src       | Divide rax by src, and put the ratio into rax, and the remainder into rdx. Bizarrely, on input rdx must be zero, or you get a SIGFPE.                                                                                                 |
| shr val,bits  | Bitshift a value right by a constant, or the low 8 bits of rcx ("cl"). Shift count MUST go in rcx, no other register will do!                                                                                                          |
| jmp label     | Goto the instruction label:.  Skips anything else in the way.                                            |
| cmp a,b       | Compare two values.  Sets flags that are used by the conditional jumps (below).                          |
| jl label      | Goto label if previous comparison came out as less-than.  Other conditionals available are:
jle (<=), je (==), jge (>=), jg (>), jne (!=), and many others.
Also available in unsigned comparisons: jb (<), jbe (<=), ja (>), jae (>=).  |


### Defining macro



- name : Name of macro.
- argc : NUmber of arguments the macro will take. Within the macro body, these inputs are referenced using "%n". "%1" == first input, "%2" == the second...
- macro body : the definition of the macro

```nasm
%macro <name> <argc>
  <macro body>
%endmacro

; Example :

%macro exit 0
  mov rax, 60
  mov rdi, 0
  syscall
%endmacro
 ```

### Defining constants

```nasm

STDIN equ 0
STDOUT equ 1

SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60

section .data
  text db "Hello, world !", 10, 0

section .text
  global _start
  
_start:
  mov rax, SYS_WRITE
  mov rdi, STDOUT
  mov rsi, text
  mov rdx, 14
  syscall
  
  mov rax, SYS_EXIT
  mov rdi, 0
  syscall
```

### Including extrernal files

```nasm
%include "filename,inc"
```




