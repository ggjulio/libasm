## Reminder

#### RTFM : https://nasm.us/doc/nasmdoc0.html
 https://www.nekosecurity.com/x86-64-assembly/part-2-cpu-process-register-eflags-section-and-segment   
https://www.ipgirl.com/59255/ou-puis-je-trouver-une-liste-complete-des-instructions-dassemblage-x86_64.html  
http://sevanspowell.net/posts/learning-nasm-on-macos.html#sec-1-5    
https://cs.lmu.edu/~ray/notes/nasmtutorial/
### [Data size](https://www.nasm.us/doc/nasmdoc3.html)

| Size in bytes |  Size in bits |  prefixe   | Initialized ([.data](#data)) | Uninitialized ([.bss](#bss))|
|    ---        |       ---     |    ---     |     ---                      |      ---                    |
| 1             | 8             | byte       | db                           | resb                        |
| 2             | 16            | word       | dw                           | resw                        |
| 4             | 32            | dword      | dd                           | resd                        |
| 8             | 64            | qword      | dq                           | resq                        |
| 10            | 80            | tword      | dt                           | rest                        |
| 16            | 128           | oword      | do / ddq                     | reso / resdq                |
| 32            | 256           | yword      | dy                           | resy                        |
| 64            | 512           | zword      | dz                           | resz                        |

### NASM sections 
| Segment / Section       |            Meaning            |  c equivalent example  |
|   ----        |             -----             |       ---------        |
| .text         | Code                          |  printf("%d", i);      |
| [.data](#data)| Initialized Data              |  int i = 1;            |
| [.bss](#bss)  | Uninitialized Data            |  int i;                |

More about section directive:
[elf](https://nasm.us/doc/nasmdoc8.html#section-8.9.2)
[macho](https://nasm.us/doc/nasmdoc8.html#section-8.8.1)
[win](https://nasm.us/doc/nasmdoc8.html#section-8.5.1)

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


| 8-bit | 16-bit | 32-bit | 64-bit |           Purpose              | Preserved|
|-------|--------|--------|--------|               ----             |    ---   |
| al    | ax     | eax    | **rax**| accumulator                    | No       |
| bl    | bx     | ebx    | **rbx**| base, addressing               | Yes      |
| cl    | cx     | ecx    | **rcx**| counter, iterations            | No       |
| dl    | dx     | edx    | **rdx**| data                           | No       |
| sil   | si     | esi    | **rsi**|             -                  | No       |
| dil   | di     | edi    | **rdi**|             -                  | No       |
| bpl   | bp     | ebp    | **rbp**| frame pointer                  | Yes      |
| spl   | sp     | esp    | **rsp**| Stack pointer                  | Yes      |
| r8b   | r8w    | r8d    | **r8** |              -                 | No       |
| r9b   | r9w    | r9d    | **r9** |              -                 | No       |
| r10b  | r10w   | r10d   | **r10**|              -                 | No       |
| r11b  | r11w   | r11d   | **r11**|              -                 | No       |
| r12b  | r12w   | r12d   | **r12**|              -                 | Yes      |
| r13b  | r13w   | r13d   | **r13**|              -                 | Yes      |
| r14b  | r14w   | r14d   | **r14**|              -                 | Yes      |
| r15b  | r15w   | r15d   | **r15**|              -                 | Yes      |

### syscall input by register ([Fastcall convention](https://beta.hackndo.com/conventions-d-appel/#fastcall-fast-calling-convention)):

| syscall   | MacOS Id (%rax) | Linux ID (%rax) | ARG_1 (%rdi)| ARG_2 (%rsi) | ARG_3 (%rdx) | ARG_4 (if syscall `%r10` else `%rcx` ) | ARG_5 (%r8) | ARG_6 (%r9) |
|-----------|-----------------|-----------------|     :---:   |     :---:    |     :---:    |--------------|--------------|--------------|
| sys_read  |   0x2000003     |        0        |      fd     | **&** buffer |    count     |              |              |              |
| sys_write |   0x2000004     |        1        |      fd     | **&** buffer |    count     |              |              |              |
| sys_open  |   0x2000005     |        2        |   filename  |     Flags    |    mode      |              |              |              |
| sys_close |   0x2000006     |        3        |      fd     |              |              |              |              |              |
| sys_exit  |   0x2000001     |       60        |  error_code |     ...      |     ...      |     ...      |      ...     |     ...      |
|    ...    |       ...       |       ...       |     ...     |     ...      |     ...      |     ...      |      ...     |     ...      |
| pwritev2  |        -        |       328       |     ...     |     ...      |     ...      |     ...      |      ...     |     ...      |

Also, the return value goes into %rax.

- [See linux full table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [See macOS full table ( the id at the beginning of each prototype, and add 0x2000000 to the id )](https://github.com/opensource-apple/xnu/blob/master/bsd/kern/syscalls.master)  
- [caller-saved and callee-saved registers](https://stackoverflow.com/questions/9268586/what-are-callee-and-caller-saved-registers)
- [linux and osx ](https://stackoverflow.com/questions/2535989/what-are-the-calling-conventions-for-unix-linux-system-calls-on-i386-and-x86-6)
- [info++](https://wiki.osdev.org/Calling_Conventions)
- [About caller and callee rules, scratch and preserved registers](https://aaronbloomfield.github.io/pdr/book/x86-64bit-ccc-chapter.pdf)
- https://www.ired.team/miscellaneous-reversing-forensics/windows-kernel-internals/linux-x64-calling-convention-stack-frame

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
| rbp (ebp, bp) | Stack base pointer | Points to the bottom of the stack.                            |
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
| jl label      | Goto label if previous comparison came out as less-than.  Other conditionals available are: jle (<=), je (==), jge (>=), jg (>), jne (!=), and many others. Also available in unsigned comparisons: jb (<), jbe (<=), ja (>), jae (>=).  |
| [loop target](http://site.iugaza.edu.ps/ahaniya/files/Assembly-Language-Lab5.pdf)   | The execution of the Loop instruction involves two steps: 1. First, it subtracts 1 from ECX. 2. Next, it compares ECX to zero. If ECX is not equal to zero; a jump is taken to the label identified by destination. Otherwise, if ECX equals zero, no jump takes place and control passes to the instruction following the loop.|

### String instructions ([more here](https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf))

|               |                      Purpose                    |
|       ---     |                        ---                      |
| MOVS / MOVSB  |  [Move string](http://faydoc.tripod.com/cpu/movsb.htm) / [Move byte string](https://www.esaracco.fr/documentation/assembly/assembly/copie-de-chaine.html).                  | 
| MOVS / MOVSW  |  Move string / Move word string.                  |
| MOVS / MOVSD  |  Move string / Move doubleword string.            |
| CMPS / CMPSB  |  Compare string / Compare byte string.            |
| CMPS / CMPSW  |  Compare string / Compare word string.            |
| CMPS / CMPSD  |  Compare string / Compare doubleword string.      |
| SCAS / SCASB  |  [Scan string](https://www.felixcloutier.com/x86/scas:scasb:scasw:scasd) / [Scan byte string](https://www.gladir.com/LEXIQUE/ASM/scasb.htm) |
| SCAS / SCASW  |  Scan string / Scan word string.                  |
| SCAS / SCASD  |  Scan string / Scan doubleword string.            |
| LODS / LODSB  |  Load string / Load byte string.                  |
| LODS / LODSW  |  Load string / Load word string.                  |
| LODS / LODSD  |  Load string / Load doubleword string.            |
| STOS / STOSB  |  Store string / Store byte string.                |
| STOS / STOSW  |  Store string / Store word string.                |
| STOS / STOSD  |  Store string / Store doubleword string.          |
| REP           |  [Repeat while ECX not zero.](http://faydoc.tripod.com/cpu/repne.htm)                       |
| REPE / REPZ   |  Repeat while equal / Repeat while zero.          |
| REPNE / REPNZ |  Repeat while not equal / Repeat while not zero.  |


[more](https://medium.com/@ophirharpaz/a-summary-of-x86-string-instructions-87566a28c20c)

### loops in nasm
search for local labels ;)
https://nasm.us/doc/nasmdoc3.html#section-3.9
https://nasm.us/doc/nasmdoc3.html

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

### Including external files

```nasm
%include "filename.inc"
```

### Debugging using lldb

###### Examples :

```lldb
// Flow
thread step-inst
thread step-inst-over
n

// man 
help thread
help thread step-inst
help thread step-inst-over
```

```lldb
// Show expression based on registers
print $rax
p $rax
p/s $rax
p/s $rax
p  (int)$rax + 1
p  $rdi + $rsi
```
```nasm
// SHow register values
register read
reg read
reg r
re r
re r/s
re r rax
re r rax rdi sil
```

```lldb
// Show memory values
memory read $rax
mem rea $rax
mem rea/s $rax

x $rsi
x -c5 $rsi // -c : the number of total items to display (here 5 octets / bytes)
```

```lldb
// man
help x
help memory
help memory read
help register
help register read
// etc....

// help about format
register read -f 42

```

https://www.nesono.com/sites/default/files/lldb%20cheat%20sheet.pdf
http://nickdesaulniers.github.io/blog/2016/01/20/debugging-x86-64-assembly-with-lldb-and-dtrace/
https://stackoverflow.com/questions/30512452/lldb-read-memory-pointer
lldb - switch from at&t to [intel syntax](https://stackoverflow.com/questions/9829136/setting-disassembly-flavour-to-intel-in-lldb) (you can put this line in ~/.lldbinit to make it permanent):   
`settings set target.x86-disassembly-flavor intel`

### debugging reverse engineering

https://mirrors.ocf.berkeley.edu/parrot/misc/openbooks/programming/ReverseEngineeringForBeginners.en.pdf

### Errno and ___error
https://pubs.opengroup.org/onlinepubs/009695399/functions/errno.html
https://pubs.opengroup.org/onlinepubs/9699919799/
https://stackoverflow.com/questions/29047592/accessing-errno-h-in-assembly-language
https://stackoverflow.com/questions/44319762/how-to-use-errno-from-asm
https://www.thegeekstuff.com/2010/10/linux-error-codes/
man errno
man error

#### Are the Prologue and Epilogue mandatory ?
Not really...But usefull still...

- https://stackoverflow.com/questions/42208087/are-the-prologue-and-epilogue-mandatory-when-writing-assembly-functions 

### errors

##### undefined reference to ... (linux and macos):
When making a label global, Macos want leading underscore (_ft_strlen), and linux don't want it...

https://stackoverflow.com/questions/19101815/how-can-c-code-call-an-external-function-without-a-leading-underscore
https://en.wikipedia.org/wiki/Name_mangling
https://clang.llvm.org/docs/UsersManual.html#differences-between-various-standard-modes
https://stackoverflow.com/questions/5313536/whats-the-difference-between-gnu99-and-c99-clang
https://stackoverflow.com/questions/1034852/adding-leading-underscores-to-assembly-symbols-with-gcc-on-win32/1035937#1035937
https://stackoverflow.com/questions/1703670/is-there-anything-to-change-the-exports-name-mangling-scheme-in-gcc
https://stackoverflow.com/questions/50763624/cant-link-an-assembly-file-s-with-gcc-on-macos-sierra
https://stackoverflow.com/questions/44358292/how-to-override-prefix-option-in-nasm-per-symbol

To make it work under linux and osx, you can use the attibute asm('label_name').  
For example `int ft_strlen(char *s) asm('_ft_strlen');`
https://clang.llvm.org/docs/AttributeReference.html#asm  
https://gcc.gnu.org/onlinedocs/gcc/Asm-Labels.html

Another solution is to use pragma gprefix to add _ when is osx :
`%pragma macho gprefix _` (will add '_' prefix if format is macho32|macho64)
To check if the prefix is added to global and extern symbols, use the nm command :
`nm libasm.a`

##### Mach-O 64-bit format does not support 32-bit absolute addresses :
Using macho64 format produce this error.
Instead of `mov rax, [var]`, do `mov rax, [rel var]`
OR 
use `DEFAULT REL` at the top of your souce code...

https://nasm.us/doc/nasmdoc7.html#section-7.2.1  
https://nasm.us/doc/nasmdoc3.html#section-3.3
https://stackoverflow.com/questions/26394359/mach-o-64-bit-format-does-not-support-32-bit-absolute-addresses-nasm   
https://forum.nasm.us/index.php?topic=1970.0   

##### Linux: GCC and PIE : relocation R_X86_64_PC32 against symbol `malloc' can not be used when making a PIE object; recompile with -fPIE

While calling like that :  
`call malloc`
The Linker is lost trying to make a PIE.
So use `wrt ..plt`:
`call malloc wrt ..plt`

```
Referring to a procedure name using wrt ..plt causes the linker to build a procedure linkage table entry for the symbol, and the reference gives the address of the PLT entry. You can only use this in contexts which would generate a PC-relative relocation normally (i.e. as the destination for CALL or JMP), since ELF contains no relocation type to refer to PLT entries absolutely.
```

Of course in order to make a position independent executable, you should address all in relative. (except data section maybe ??)
`call [rel malloc wrt ..plt]` or DEFAULT REL.....

- https://stackoverflow.com/questions/28699032/assembly-coding-strdup-malloc-calling-in-shared-library
- https://www.nasm.us/xdoc/2.11.08/html/nasmdoc7.html#section-7.9.3
- https://stackoverflow.com/questions/58106310/nasm-linux-shared-object-error-relocation-r-x86-64-32s-against-data
-


##### Segfault (stack_not_16_byte_aligned_error) :
http://sevanspowell.net/posts/learning-nasm-on-macos.html

### Ressources

##### NASM documentation
https://www.nasm.us/xdoc/2.14.03rc2/nasmdoc.pdf

##### call convention
https://www.agner.org/optimize/calling_conventions.pdf
https://wiki.osdev.org/Calling_Conventions
https://beta.hackndo.com/conventions-d-appel
https://h-deb.clg.qc.ca/Sujets/AuSecours/Conventions-appel.html
https://docs.microsoft.com/fr-fr/cpp/build/x64-calling-convention?view=vs-2019
https://www.raywenderlich.com/615-assembly-register-calling-convention-tutorial
https://stackoverflow.com/questions/9268586/what-are-callee-and-caller-saved-registers
#### call tables
https://filippo.io/linux-syscall-table/
https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
https://blog.packagecloud.io/eng/2016/04/05/the-definitive-guide-to-linux-system-calls/

#### Man
https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
https://planetpdf.com/codecuts/pdfs/aoa.pdf
http://www.egr.unlv.edu/~ed/assembly64.pdf
https://sites.google.com/site/microprocessorsbits/string-instructions/cmps-cmpsb-cmpsw
https://blog.packagecloud.io/eng/2016/04/05/the-definitive-guide-to-linux-system-calls/  
https://stackoverflow.com/tags/x86/info   

### Instructions
https://fr.wikipedia.org/wiki/Jeu_d%27instructions_x86
https://fr.wikipedia.org/wiki/Jeu_d%27instructions#%C2%AB_%C3%A0_accumulateur_%C2%BB  
#### other

##### string instructions
[repn scasb](https://books.google.fr/books?id=veMTOpapeZkC&pg=PT366&lpg=PT366&dq=repne+scas+tuto&source=bl&ots=_lKLckx8fG&sig=ACfU3U3P0jYXeNL3P9q2Xo0ZdTdoxbM_Ug&hl=fr&sa=X&ved=2ahUKEwi9ucyyuuPpAhXUDmMBHe84BYgQ6AEwB3oECAoQAQ#v=snippet&q=repne%20scasb&f=false)
[end conditions](https://c9x.me/x86/html/file_module_x86_id_279.html)   
https://www.conradk.com/codebase/2017/06/06/x86-64-assembly-from-scratch/   
https://www.csc.depauw.edu/~bhoward/asmtut/asmtut7.html

#### Best practice
https://www.codeproject.com/Articles/1116188/40-Basic-Practices-in-Assembly-Language-Programmin#Introduction


#### cld and std direction flag
https://stackoverflow.com/questions/23860583/x86-abi-should-df-flag-be-always-0   
https://c9x.me/x86/html/file_module_x86_id_29.html
https://en.wikipedia.org/wiki/Direction_flag
https://www.agner.org/optimize/calling_conventions.pdf
