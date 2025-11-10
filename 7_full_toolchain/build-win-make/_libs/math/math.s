	.file	"math.cpp"
	.text
.Ltext0:
	.p2align 4
	.globl	_ZN4math3addEii
	.def	_ZN4math3addEii;	.scl	2;	.type	32;	.endef
	.seh_proc	_ZN4math3addEii
_ZN4math3addEii:
.LVL0:
.LFB0:
	.file 1 "/home/womackow/cpp_projects/cmake_examples/7_full_toolchain/_libs/math/_core/_src/math.cpp"
	.loc 1 5 58 view -0
	.loc 1 5 58 is_stmt 0 view .LVU1
	.seh_endprologue
	.loc 1 5 60 is_stmt 1 view .LVU2
	.loc 1 5 73 is_stmt 0 view .LVU3
	leal	(%rcx,%rdx), %eax
	.loc 1 5 78 view .LVU4
	ret
.LFE0:
	.seh_endproc
	.section	.debug_frame,"dr"
.Lframe0:
	.long	.LECIE0-.LSCIE0
.LSCIE0:
	.long	0xffffffff
	.byte	0x3
	.ascii "\0"
	.uleb128 0x1
	.sleb128 -8
	.uleb128 0x10
	.byte	0xc
	.uleb128 0x7
	.uleb128 0x8
	.byte	0x90
	.uleb128 0x1
	.align 8
.LECIE0:
.LSFDE0:
	.long	.LEFDE0-.LASFDE0
.LASFDE0:
	.secrel32	.Lframe0
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.align 8
.LEFDE0:
	.text
.Letext0:
	.file 2 "/home/womackow/cpp_projects/cmake_examples/7_full_toolchain/_libs/math/_core/_inc/math.h"
	.section	.debug_info,"dr"
.Ldebug_info0:
	.long	0x1a1
	.word	0x4
	.secrel32	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.ascii "GNU C++17 10-win32 20220113 -mtune=generic -march=x86-64 -g -O3 -std=gnu++17\0"
	.byte	0x4
	.ascii "/home/womackow/cpp_projects/cmake_examples/7_full_toolchain/_libs/math/_core/_src/math.cpp\0"
	.ascii "/home/womackow/cpp_projects/cmake_examples/7_full_toolchain/build-win-make/_libs/math\0"
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.secrel32	.Ldebug_line0
	.uleb128 0x2
	.ascii "mycustomtype\0"
	.byte	0x2
	.byte	0x3
	.byte	0xd
	.long	0x134
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.ascii "int\0"
	.uleb128 0x4
	.ascii "math\0"
	.byte	0x2
	.byte	0x5
	.byte	0xb
	.long	0x170
	.uleb128 0x5
	.ascii "add\0"
	.byte	0x1
	.byte	0x5
	.byte	0x12
	.ascii "_ZN4math3addEii\0"
	.long	0x11f
	.uleb128 0x6
	.long	0x11f
	.uleb128 0x6
	.long	0x11f
	.byte	0
	.byte	0
	.uleb128 0x7
	.long	0x148
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x8
	.ascii "lhs\0"
	.byte	0x1
	.byte	0x5
	.byte	0x23
	.long	0x11f
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x8
	.ascii "rhs\0"
	.byte	0x1
	.byte	0x5
	.byte	0x35
	.long	0x11f
	.uleb128 0x1
	.byte	0x51
	.byte	0
	.byte	0
	.section	.debug_abbrev,"dr"
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0x8
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x1b
	.uleb128 0x8
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x47
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"dr"
	.long	0x2c
	.word	0x2
	.secrel32	.Ldebug_info0
	.byte	0x8
	.byte	0
	.word	0
	.word	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"dr"
.Ldebug_line0:
	.section	.debug_str,"dr"
	.ident	"GCC: (GNU) 10-win32 20220113"
