                org $fffe
                fdb start

                org $fff8
                fdb irq *priprava IRQ

                org $7007 *podatki

                org $6606 *podprogram podatki
podatki         staa 0,x
                inx
                inca
                cpx #$700C
                bne podatki
                rts

                org $5505 *PSP
irq             staa $0002 * v A je ze dosedajna vsota, zato takoj da na PORT 1
                rti


                org $4404 *glavni program
start           lds #$f000
                ldaa #%11111111 *PORT1
                staa $00
                ldaa #%00011111 *PORT2
                staa $01
                ldx #$7007 *lokacija podatkov
                ldaa #6
                jsr podatki
                ldx #$7007
zanka           ldaa 0,x
                ldab #2
                mul
                stab $0003
                ldaa $5000 *nalozi dosedajno vsoto
                aba        *pristeje stevilo
                staa $5000 *shrani
                cli
                sei
                inx
                cpx #$700C
                bne zanka
                end

