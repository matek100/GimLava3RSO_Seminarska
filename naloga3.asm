        org     $fffe
        fdb     start

        org     $fff8
        fdb     irq

        org     $8800  *podprogram zapor, zpaise stevila od 13 do 7 na $7500
zapor   ldaa    #13
zanka   staa    0,x
        deca
        dex
        cpx     #$74F9
        bne     zanka
        rts

        org     $5000 *PSP
irq     ldaa    0,x
        adda    1,x
        staa    $03
        rti


        org     $6500 *glavni program
start   lds     #$f000
        ldx     #$7500
        ldaa    #%11111111  *pripravi PORT 1
        staa    $00
        ldaa    #%00011111  *pripravi PORT 2
        staa    $01
        pshx
        jsr     zapor
        pulx
        ldaa    #1
        staa    $1000
zanka2  asla           *nalozi stevec v a, ga za 4 bite premakne v levo
        asla
        asla
        asla
        ldab     0,x  *nolzi stevilo v b
        aba           * sesteje a in b, b4-b7 zaporedno mesto, b0-b3 stevilo
        staa    $0002
        ldaa    $1000  *nalozi stevec v a in ga poveca potem pa spet shrani
        inca
        staa    $1000
        cli
        sei
        dex
        cpx     #$74F9
        bne     zanka2

        end


        end

