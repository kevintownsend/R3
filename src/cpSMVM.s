#TODO: add header information
	.file	"cpSMVM.s"
	.ctext

cpLoadMore:
    .globl  cpLoadMore
    .type   cpLoadMore. @function
    .signature pdk=65309
    mov %a8, $6, %aeg
    mov %a8, $5, %aeg
    mov %a8, $1, %aeg
    rtn

cpCaep00:
    .globl cpCaep00
    .type cpCaep00. @function
    .signature pdk=65309
    caep00 $0
    rtn

cpSpoonSmvm:
    .globl  cpSpoonSmvm
    .type   cpSpoonSmvm. @function
    .signature pdk=65309
    mov %a8, $1, %aeg
    #TODO: loop store 102 values to aegs
    ldi.uq $6, %a1
Loop0:
    cmp.uq %a1, $102, %ac0
    br %AC0.eq, EndLoop0
    ld.uq $0(%A9), %s2
    mov.ae0 %s2, %a1, %aeg
    add.uq %a1, $1, %a1
    add.uq %A9, $8, %A9
    br Loop0
EndLoop0:
    ldi.uq $6, %a1
Loop1:
    cmp.uq %a1, $102, %ac0
    br %AC0.eq, EndLoop1
    ld.uq $0(%A9), %s2
    mov.ae1 %s2, %a1, %aeg
    add.uq %a1, $1, %a1
    add.uq %A9, $8, %A9
    br Loop1
EndLoop1:
    ldi.uq $6, %a1
Loop2:
    cmp.uq %a1, $102, %ac0
    br %AC0.eq, EndLoop2
    ld.uq $0(%A9), %s2
    mov.ae2 %s2, %a1, %aeg
    add.uq %a1, $1, %a1
    add.uq %A9, $8, %A9
    br Loop2
EndLoop2:
    ldi.uq $6, %a1
Loop3:
    cmp.uq %a1, $102, %ac0
    br %AC0.eq, EndLoop3
    ld.uq $0(%A9), %s2
    mov.ae3 %s2, %a1, %aeg
    add.uq %a1, $1, %a1
    add.uq %A9, $8, %A9
    br Loop3
EndLoop3:
    caep00 $0
    #mov.ae0 %aeg, $6, %a8
    rtn

    .cend
