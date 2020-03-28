
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


| syscall   |    ID     |   ARG1   |     ARG2     |   ARG3   |    ARG4   |    ARG5  |    ARG6   |
|-----------|-----------|  :---:   |--------------|----------|-----------|----------|-----------|
| sys_read  |     0     |    fd    | **&** buffer |  count   |           |          |           |
| sys_write |     1     |    fd    | **&** buffer |  count   |           |          |           |
| sys_open  |     2     | filename |     Flags    |  mode    |           |          |           |
| sys_close |     3     |    fd    |              |          |           |          |           |
|    ...    |    ...    |   ...    |     ...      |   ...    |   ...     |   ...    |   ...     |
| pwritev2  |    328    |   ...    |     ...      |   ...    |   ...     |   ...    |   ...     |




