;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 140052   A
; Altaf Malik
; Phase 02
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.model small
.stack 100h
.data
;count	db 0
row dw 50
col dw 50
n1 db "LIFE= $"
n2 db "GAME$"
n3 db "SCORE= $"
n4 db "Menu $"
n5 db "Start. Press 1 $"
n6 db "Stop.  Press 2 $"
new db 10,13,"$"
choice db 0
score db 0
life db 5
diad db 1
key db 0
dianax db 24
dianay db 40
.code

main proc
    mov ax, @data
    mov ds, ax

mov ah,0
mov al,13h
int 10h

mov ax,0
mov bx,0
mov cx,0
mov dx,0 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; MENU
; call functions.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	call menu

mov ah, 01h
int 21h
sub al, 48
mov choice, al
cmp choice, 2
je exit


; call game score life.

continue:

	call printCredentials

	
; call hurdle with delay.

mov ax,0
dly2:
inc ax
cmp ax,100000000
jb dly2

	call hurdle	

; call dianasore.

	call diana	

; movement of diana.

repeat1:
; Get keystroke
mov ah,0
int 16h
; AH = BIOS scan code
cmp ah,4Dh
je right
	
	cmp life, 0
	je exit
	jne continuedia

continuedia:

	right:
	
		
		inc dianax 
			
		inc dianay
		cmp dianay, 150
		je declife
		jne continuedia
		call dianamove
	jmp repeat1
	
	declife:
	
	dec life
	cmp life, 0
	je exit
	jne continuedia

;-------------------------------------------------------------------------------diana-movement-------------------

cmp key,1
je diacon1
mov ax,0007h
mov cx,0
mov dx,50
int 33h

mov bx,0   

cmp cx,55
ja diacon1
 
mov dianay ,cl

diacon1:

mov key,0

mov ax,10
sub ax,10

mov ah,1
int 16h

cmp ah,4dh 	;4dh is askii for right
je rightkey
	
rightkey:

mov key,1
mov diad,1
	call dianamove 	
mov cx,0
mov dx,0

mov ax,4h
mov cl,dianay
mov dl,dianax
int 33h

; collision.

; end game loop.

exit:

; print score

mov dx, offset new
mov ah, 09h
int 21h

mov dx, offset n3
mov ah, 09h
int 21h
mov dl, score
add dl, 48
mov ah, 02h
int 21h

mov ah, 4ch
int 21h
main endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; procedures for menu, hurdles, dianasore.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
menu proc

mov dx,offset n4
mov ah,09h
int 21h

mov dx, offset new
mov ah, 09h
int 21h

mov dx,offset n5
mov ah,09h
int 21h

mov dx, offset new
mov ah, 09h
int 21h

mov dx, offset n6
mov ah, 09h
int 21h

menu endp
ret

; print score, life, game characters here.

printCredentials proc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print life and game characters and score.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        mov bh, 0h    ; printing character. cursor positioning
	mov ah, 02h   ; output
	mov dh, 1     ; row	
	mov dl, 1     ; col
	int 10h

mov dx,offset n2
mov ah,09h
int 21h

        mov bh, 0h    ; printing character. cursor positioning
	mov ah, 02h   ; output
	mov dh, 4     ; row	
	mov dl, 150    ; col
	int 10h

mov dx,offset n1
mov ah,09h
int 21h

        mov bh, 0h    ; printing character. cursor positioning
	mov ah, 02h   ; output
	mov dh, 4     ; row	
	mov dl, 97    ; col
	int 10h

mov dx,offset n3
mov ah,09h
int 21h
mov al, score
add al, 48
mov dl, al
mov ah, 02h
int 21h

        mov bh, 0h    ; printing character. cursor positioning
	mov ah, 02h   ; output
	mov dh, 4     ; row	
	mov dl, 156   ; col
	int 10h

mov al, life
add al, 48
mov dl, al
mov ah, 02h
int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;draw pixel code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ah, 0ch		; draw pixel on screen
mov cx, 300
mov dx, 50		; dx row num bx, 0   al, color
mov bx, 0		; reset
mov al, 7
loop1:			; call 10h in loop upto 30 till 0 to print horizental line
int 10h	
loop loop1

; use variables to record delays

mov cx, 300
mov dx, 180
mov bx, 0
mov al, 7
loop3:
int 10h			; vertical line cmp dx value to draw.
dec dx
cmp dx, 50
jne loop3

mov cx, 1
mov dx, 180
mov bx, 60
mov al, 7
loop4:
int 10h			; vertical line cmp dx value to draw.
dec dx
cmp dx, 50
jne loop4

mov ah, 0ch		; draw pixel on screen
mov cx, 300
mov dx, 180		; dx row num bx, 0   al, color
mov bx, 0		; reset
mov al, 7
loop5:			; call 10h in loop upto 30 till 0 to print horizental line
int 10h	
loop loop5


printCredentials endp
ret

; end proc.

hurdle proc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Draw Line in Rectangle and hurdles and dianosorous.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ah, 0ch		; draw pixel on screen
mov cx, 300
mov dx, 130		; dx row num bx, 0   al, color
mov bx, 0		; reset
mov al, 9
loop6:			; call 10h in loop upto 30 till 0 to print horizental line
int 10h	
loop loop6

mov ah, 0ch
mov cx, 230
mov dx, 120		; print hurdle on dx, 130
mov bx, 0
L1:
mov al, 8
inc dx
int 10h
cmp dx, 130
jne L1

mov ah, 0ch		; draw pixel on screen
mov cx, 250
mov dx, 130		; dx row num bx, 0   al, color
mov bx, 0		; reset
mov al, 9
loop16:			; call 10h in loop upto 30 till 0 to print horizental line
int 10h	
loop loop16

mov ah, 0ch
mov cx, 150
mov dx, 120		; print hurdle on dx, 130
mov bx, 0
LL1:
mov al, 8
inc dx
int 10h
cmp dx, 130
jne LL1

hurdle endp
ret
; hurdle end here.


; dianasore

diana proc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print dainasore
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ah, 0ch
mov cx, 5
mov dx, 130
mov bx, 0
mov al, 3
Loop8:
int 10h
loop loop8


mov ah, 0ch
mov cx, 5
mov dx, 120		
mov bx, 0
L2:
mov al, 3
inc dx
int 10h
cmp dx, 130
jne L2

mov ah, 0ch
mov cx, 20
mov dx, 108		
mov bx, 0
L3:
mov al, 3
inc dx
int 10h
cmp dx, 130
jne L3

mov ah, 0ch
mov cx, 35
mov dx, 120		
mov bx, 0
L4:
mov al, 3
dec cx
int 10h
cmp cx, 5
jne L4

mov ah, 0ch
mov cx, 35
mov dx, 122
L5:
mov al, 3
mov bx, 0
dec dx
dec cx
int 10h
cmp dx, 109
jne L5

diana endp
ret

; diana end here.

dianamove proc

cmp diad,1
je diacon1
mov al,dianay
dec al
cmp al,0
je diacmpout
dec dianay
jmp diacmpout


diacon1:
mov al,dianay
inc al
cmp al,53
je diacmpout
inc dianay
jmp diacmpout


diacmpout:
ret 
dianamove endp 

end 
