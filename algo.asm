
; �������������������������������������������������������������������������
; ASTRAL 2010 MASM32 ZebUI Template
; ++Meat code & technics
; http://astral.tuxfamily.org/
; �������������������������������������������������������������������������

.data?

Buffer  db 50 dup (?)

.code

; �������������������������������������������������������������������������

Algo proc

    fn zl_edit_gettext, eName, ADDR Buffer, 50
    fn zl_edit_settext, eSerial, ADDR Buffer
    ret

Algo endp

; �������������������������������������������������������������������������
