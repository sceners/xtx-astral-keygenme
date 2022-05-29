
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
; ASTRAL 2010 MASM32 ZebUI Template
; ++Meat code & technics
; http://astral.tuxfamily.org/
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
    include \masm32\include\masm32rt.inc
    include sys\zebui.inc
    includelib sys\zebui.lib
    include \masm32\include\winmm.inc
    includelib \masm32\lib\winmm.lib
    include sys\ufmod.inc
    includelib sys\ufmod.lib
    include data.asm
    include algo.asm
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

WinMain PROTO :DWORD,:DWORD,:DWORD,:DWORD
WndProc PROTO :DWORD,:DWORD,:DWORD,:DWORD

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.data?

hInstance   dd ?

.code

start:

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

    fn GetModuleHandle, NULL
    mov hInstance, eax

    fn WinMain, hInstance, NULL, NULL, SW_SHOWDEFAULT

    exit

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

WndProc proc hwnd:HWND, umsg:DWORD, wparam:WPARAM, lparam:LPARAM
    .if umsg==WM_DESTROY || umsg==WM_HOTKEY
@@:     exit
    .elseif umsg==WM_CREATE
        fn RegisterHotKey, hwnd, NULL, NULL, VK_ESCAPE
    .elseif umsg==WM_COMMAND
        mov eax, wparam
        .if ax==bCheck
            call Algo
        .elseif ax==bQuit
            jmp @B
        .endif
    .else
        fn DefWindowProc, hwnd, umsg, wparam, lparam
    .endif

    ret
WndProc endp

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    LOCAL hWin:DWORD

    fn zl_init, hInst
    fn zl_set_colors, 0361317h, 0361317h, 0bbfeffh

    fn zl_img_window, NULL, 10, 10, wMain, Bg, 0, "ASTRAL", offset WndProc
    mov hWin, eax

    fn zl_edit, hWin, 40, 52, 220, 20, eName, NULL
    fn zl_ctl_style, eName, 80h
    fn zl_edit, hWin, 40, 122, 220, 20, eSerial, NULL
    fn zl_ctl_style, eSerial, 80h

    fn zl_img_button, hWin, 10, 160, bCheck, Checkoff, Checkon
    fn zl_ctl_style, bCheck, 80h
    fn zl_img_button, hWin, 130, 160, bQuit, Quitoff, Quiton
    fn zl_ctl_style, bQuit, 80h

    fn zl_ctl_show, 1
    fn zl_main
    mov ebx, eax
    fn zl_end
    mov eax,ebx
    ret

WinMain endp

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

end start
