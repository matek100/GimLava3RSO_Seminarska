                org $fffe
                fdb start

                org $fff8
                fdb irq  *za IRQ

                org $2440
                fcb 4    *majhni stevili
                fcb 10

                org $3333 *podprogram
vpis            ldaa 0,x
                adda 1,x
                staa 2,x
                rts


                org $4444 *PSP
irq             stx $5000
                ldd $5000
                subd #$243D *od x odsteje razliko, x - 243D = zaporedno stevilo
                tba
                staa $0003
                rti


                org $2222 *glavni program
start           lds #$f000
                ldx #$2440
                ldaa #%11111111 *priprava PORT 1
                staa $0000
                ldaa #%00011111 *priprava PORT 2
                staa $0001
zanka           jsr vpis
                staa $0002
                cli  *zacentek moznosti prekiniteve
                sei  *konec moznosti prekiniteve, drugace jo INX zmede
                inx
                cpx  #$2445 *poišèe nadaljnih 5 stevil (zanka izvede 5 krat)
                bne  zanka
                end




