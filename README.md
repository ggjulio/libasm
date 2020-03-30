
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


| 8-bit | 16-bit | 32-bit | 64-bit |
|-------|--------|--------|--------|
| al    | ax     | eax    | **rax**|
| bl    | bx     | ebx    | **rbx**|
| cl    | cx     | ecx    | **rcx**|
| dl    | dx     | edx    | **rdx**|
| sil   | si     | esi    | **rsi**|
| dil   | di     | edi    | **rdi**|
| bpl   | bp     | ebp    | **rbp**|
| spl   | sp     | esp    | **rsp**|
| r8b   | r8w    | r8d    | **r8** |
| r9b   | r9w    | r9d    | **r9** |
| r10b  | r10w   | r10d   | **r10**|
| r11b  | r11w   | r11d   | **r11**|
| r12b  | r12w   | r12d   | **r12**|
| r13b  | r13w   | r13d   | **r13**|
| r14b  | r14w   | r14d   | **r14**|
| r15b  | r15w   | r15d   | **r15**|


### syscall input by register :

| Argument | Registers |
|----------|-----------|
| ID       | rax       |
| 1        | rdi       |
| 2        | rsi       |
| 3        | rdx       |
| 4        | r10       |
| 5        | r8        |
| 6        | r9        |

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

| Flag symbol |    Description         |
|    :---:    |         ---            |
|     CF      |    Carry               |
|     PF      |    Parity              |
|     ZF      |    Zero                |
|     SF      |    Sign                |
|     OF      |    Overflow            |
|     AF      |    Adjust              |
|     IF      |    Interrupt Enabed    |


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




### Stack operations

|   Operation    |                   Description                   |
|     :---:      |                       ---                       |
| push reg/value | Pushes a value onto the stack                   |
| pop reg        | Pops a value off the stack and stores it in reg |
| mov reg, [rsp] | Stores the peek value in reg                    |

Note : Usually in places where you can use registers, you can also use pointers.
Such as, instead of "pop reg", you can use "pop [label]" to pop a value off the stack directly into a position in memory.



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




