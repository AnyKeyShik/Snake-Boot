          [bits 16]                    
          [org 0x7C00]                 
          mov bl, 1                    
          push 0xa000                  
          pop es

restart_game:
          mov       si, 320*100+160    
          mov       ax, 0x0013
          int       0x10
          mov       di, 320*199
          mov       cx, 2176
          rep

draw_loop:
          stosb                        
          stosb                        
          add       di, 318
          jnc       draw_loop          

game_loop:
          in        al, 0x60
          cmp       al, 0x48
          jb        kb_handle_end
          cmp       al, 0x50
          ja        kb_handle_end
          
          aaa
          cbw
          dec       ax
          dec       ax
          jc        kb_handle
          sub       al, 2
          imul      ax, ax, byte -0x50

kb_handle:
          mov       bx, ax

kb_handle_end:
          add       si, bx
          
          mov       ah, 0x86
          mov       dh, 0xef
          int       0x15
          
          mov ah, 0x45
          xor [es:si], ah
          
          jpo       game_loop
          jmp       restart_game

TIMES 510 - ($ - $$) db 0              
dw 0xaa55                              
