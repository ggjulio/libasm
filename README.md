Registers :

00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

<table>
  <tr>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
    <td>00000000</td>
  </tr>
  <tr>
    <td colspan="6"></td>
    <td colspan="2">al</td>
  </tr>
  
</table>

| 8-bit | 16-bit | 32-bit | 64-bit |
|-------|--------|--------|--------|
| al    | ax     | eax    | rax    |
| bl    | bx     | ebx    | rbx    |
| cl    | cx     | ecx    | rcx    |
| dl    | dx     | edx    | rdx    |
| sil   | si     | esi    | rsi    |
| dil   | di     | edi    | rdi    |
| bpl   | bp     | ebp    | rbp    |
| spl   | sp     | esp    | rsp    |
| r8b   | r8w    | r8d    | r8     |
| r9b   | r9w    | r9d    | r9     |
| r10b  | r10w   | r10d   | r10    |
| r11b  | r11w   | r11d   | r11    |
| r12b  | r12w   | r12d   | r12    |
| r13b  | r13w   | r13d   | r13    |
| r14b  | r14w   | r14d   | r14    |
| r15b  | r15w   | r15d   | r15    |

syscall input by register :

| Argument | Registers |
|----------|-----------|
| ID       | rax       |
| 1        | rdi       |
| 2        | rsi       |
| 3        | rdx       |
| 4        | r10       |
| 5        | r8        |
| 6        | r9        |
