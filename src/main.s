.global _main       // Declare the entry point of the program
.align 4            // Align the next instruction to a 4-byte boundary

_main:
  mov X9, #0        // init counter
  adr X10, message  // init char pointer to string start address

loop:
  bl print          // print char
  add X9, X9, #1    // increment counter
  add X10, X10, #1  // increment char pointer
  cmp X9, #10       // compare counter to max iteration amount
  b.lt loop         // if less than max, iterate
  
  mov X0, #0        // Put the exit code into register X0
  b exit            // Jump to the exit subroutine

print: 
  mov X1, X10       // set character address
  mov X2, #1        // set print length
  mov X16, #4       // set syscall
  mov X0, #1        // set stout
  svc #0x80         // interrupt and make syscall
  ret

exit:               // Pass in: X0 = exit code
  mov X16, #1       // 1 = specify the 'exit' syscall
  svc #0x80         // Execute the syscall, terminating the program

message:
  .ascii "0123456789"

