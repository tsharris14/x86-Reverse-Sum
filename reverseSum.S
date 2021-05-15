# ----------------------------------------------------------------------------------------
# TaCoya S. Harris
# CSC220
# Prof. Nwanze
# 14 April 2020
# 
# Adds numbers 0 to 10 in order and prints the sum to the console.
# To assemble and run with gcc:
#
#     gcc -no-pie sum.s && ./a.out
#
# ----------------------------------------------------------------------------------------
	.global main


format:
	.asciz  "%5ld\n"

	.text
main:
	push    %rbx			# we have to save this since we use it

	mov     $1, %rcx		# initialize ecx at 1
	mov     $0, %rax		# initialize rax to 0
printandadd:
	add     %rcx, %rax		# Add to rcx to rax (sum)

	# We need to call printf, but we are using eax, ebx, and ecx.  printf
	# may destroy eax and ecx so we will save these before the call and
	# restore them afterwards.
	push    %rax			# caller-save register
	push    %rcx			# caller-save register

	lea format(%rip), %rdi		# set 1st parameter (format)
	mov %rax, %rsi			# set 2nd parameter (current_number)
	xor %rax, %rax			# clear AL

	# Stack is already aligned because we pushed three 8 byte registers
	call    printf		  	# printf(format, current_number)

	pop     %rcx			# restore caller-save register
	pop     %rax			# restore caller-save register

	inc     %rcx			# count down
	cmp     $10, %rcx       # see if rcx is less than or equal to 10
	jLE     printandadd	   	# if not(i.e. if not done counting jump to print)

	pop     %rbx			# restore rbx before returning
	ret
