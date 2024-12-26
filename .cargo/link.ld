OUTPUT_ARCH(riscv)

ENTRY(__start)

MEMORY
{
    FLASH_RX (rx) : ORIGIN = 0x10000, LENGTH = 512K
    SRAM_RW  (rw) : ORIGIN = 0x90000, LENGTH = 512K
}

SECTIONS
{
    . = 0x10000;

    .text : ALIGN(0x1000)
    {
        KEEP(*(.text .text.*));
    } > FLASH_RX

    .rodata : ALIGN(0x1000)
    {
        *(.rodata .rodata.*);
    } > FLASH_RX

    .data : ALIGN(0x1000)
    {
        *(.data .data.*);
    } > SRAM_RW

    .bss : ALIGN(0x1000)
    {
      *(.bss .bss.*);
      *(COMMON);
    } > SRAM_RW

    . = ALIGN(0x1000);
    __end_of_bss = .;

    /* Optionally place a stack top */
    _stack_top = __end_of_bss + 0x4000; /* 16 KB stack, e.g. */
}