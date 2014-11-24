; hello.asm
; 23 NOV 2014
; http://web.archive.org/web/20070830122645/http://untimedcode.com/2007/5/20/learn-nasm-assembly-on-mac-os-x
;
; nasm -f macho hello.asm
; ld -e _start -o hello hello.o
; nasm -f macho hello.asm -l hello.lst
;
section	.text			; code start
global	_start			; make externally visible
; 
section	.data			; data start
	message		db	"Hello, World!", 0xa
	message_length	equ	$-message
; 
_syscall:			; declare kernel call function
	int		0x80
	ret
;
_start:				; linker entry point
				; write message to standard output
	push	dword message_length
	push	dword message
	push	dword 1		; file descriptor
	mov	eax, 0x4	; sys_write
	call	_syscall
	add	esp, 12		; stack cleanup
	push	dword 0		; exit
	mov	eax, 0x1        ; sys_exit
	call	_syscall
;
