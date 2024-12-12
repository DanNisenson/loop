.global _main // Declare the entry point of the program
.align 4      // Align the next instruction to a 4-byte boundary

_main:
  mov X9, #0 
  
loop:
  adr X1, message
  mov X2, #14
  bl print
  add X9, X9, #1
  cmp X9, #10
  b.lt loop
  
  mov X0, #0      // Put the exit code into register X0
  b exit          // Jump to the exit subroutine

print: 
  mov X16, #4
  mov X0, #1
  svc #0x80
  ret


exit:         // Pass in: X0 = exit code
  mov X16, #1 // 1 = specify the 'exit' syscall
  svc #0x80   // Execute the syscall, terminating the program

// Note we're not using the .data section to simplify a few things in this
// example. If you want to use it, consult this stackoverflow answer:
// https://stackoverflow.com/a/65354324

// Otherwise, you can use labels and the .ascii directive to define strings
// And `adr` to load the address of the string into a register
message:
  .ascii "Hello, world!\n"

