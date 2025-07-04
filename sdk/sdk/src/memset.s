// This is musl-libc memset commit 37e18b7bf307fa4a8c745feebfcba54a0ba74f30:
// 
// src/string/memset.c
// 
// This was compiled into assembly with:
// 
// clang-14 -target riscv32 -march=rv32im -O3 -S memset.c -nostdlib -fno-builtin -funroll-loops
// 
// and labels manually updated to not conflict.
// 
// musl as a whole is licensed under the following standard MIT license:
// 
// ----------------------------------------------------------------------
// Copyright © 2005-2020 Rich Felker, et al.
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
// ----------------------------------------------------------------------
// 
// Authors/contributors include:
// 
// A. Wilcox
// Ada Worcester
// Alex Dowad
// Alex Suykov
// Alexander Monakov
// Andre McCurdy
// Andrew Kelley
// Anthony G. Basile
// Aric Belsito
// Arvid Picciani
// Bartosz Brachaczek
// Benjamin Peterson
// Bobby Bingham
// Boris Brezillon
// Brent Cook
// Chris Spiegel
// Clément Vasseur
// Daniel Micay
// Daniel Sabogal
// Daurnimator
// David Carlier
// David Edelsohn
// Denys Vlasenko
// Dmitry Ivanov
// Dmitry V. Levin
// Drew DeVault
// Emil Renner Berthing
// Fangrui Song
// Felix Fietkau
// Felix Janda
// Gianluca Anzolin
// Hauke Mehrtens
// He X
// Hiltjo Posthuma
// Isaac Dunham
// Jaydeep Patil
// Jens Gustedt
// Jeremy Huntwork
// Jo-Philipp Wich
// Joakim Sindholt
// John Spencer
// Julien Ramseier
// Justin Cormack
// Kaarle Ritvanen
// Khem Raj
// Kylie McClain
// Leah Neukirchen
// Luca Barbato
// Luka Perkov
// M Farkas-Dyck (Strake)
// Mahesh Bodapati
// Markus Wichmann
// Masanori Ogino
// Michael Clark
// Michael Forney
// Mikhail Kremnyov
// Natanael Copa
// Nicholas J. Kain
// orc
// Pascal Cuoq
// Patrick Oppenlander
// Petr Hosek
// Petr Skocik
// Pierre Carrier
// Reini Urban
// Rich Felker
// Richard Pennington
// Ryan Fairfax
// Samuel Holland
// Segev Finer
// Shiz
// sin
// Solar Designer
// Stefan Kristiansson
// Stefan O'Rear
// Szabolcs Nagy
// Timo Teräs
// Trutz Behn
// Valentin Ochs
// Will Dietz
// William Haddon
// William Pitcock
// 
// Portions of this software are derived from third-party works licensed
// under terms compatible with the above MIT license:
// 
// The TRE regular expression implementation (src/regex/reg* and
// src/regex/tre*) is Copyright © 2001-2008 Ville Laurikari and licensed
// under a 2-clause BSD license (license text in the source files). The
// included version has been heavily modified by Rich Felker in 2012, in
// the interests of size, simplicity, and namespace cleanliness.
// 
// Much of the math library code (src/math/* and src/complex/*) is
// Copyright © 1993,2004 Sun Microsystems or
// Copyright © 2003-2011 David Schultz or
// Copyright © 2003-2009 Steven G. Kargl or
// Copyright © 2003-2009 Bruce D. Evans or
// Copyright © 2008 Stephen L. Moshier or
// Copyright © 2017-2018 Arm Limited
// and labelled as such in comments in the individual source files. All
// have been licensed under extremely permissive terms.
// 
// The ARM memcpy code (src/string/arm/memcpy.S) is Copyright © 2008
// The Android Open Source Project and is licensed under a two-clause BSD
// license. It was taken from Bionic libc, used on Android.
// 
// The AArch64 memcpy and memset code (src/string/aarch64/*) are
// Copyright © 1999-2019, Arm Limited.
// 
// The implementation of DES for crypt (src/crypt/crypt_des.c) is
// Copyright © 1994 David Burren. It is licensed under a BSD license.
// 
// The implementation of blowfish crypt (src/crypt/crypt_blowfish.c) was
// originally written by Solar Designer and placed into the public
// domain. The code also comes with a fallback permissive license for use
// in jurisdictions that may not recognize the public domain.
// 
// The smoothsort implementation (src/stdlib/qsort.c) is Copyright © 2011
// Valentin Ochs and is licensed under an MIT-style license.
// 
// The x86_64 port was written by Nicholas J. Kain and is licensed under
// the standard MIT terms.
// 
// The mips and microblaze ports were originally written by Richard
// Pennington for use in the ellcc project. The original code was adapted
// by Rich Felker for build system and code conventions during upstream
// integration. It is licensed under the standard MIT terms.
// 
// The mips64 port was contributed by Imagination Technologies and is
// licensed under the standard MIT terms.
// 
// The powerpc port was also originally written by Richard Pennington,
// and later supplemented and integrated by John Spencer. It is licensed
// under the standard MIT terms.
// 
// All other files which have no copyright comments are original works
// produced specifically for use as part of this library, written either
// by Rich Felker, the main author of the library, or by one or more
// contributors listed above. Details on authorship of individual files
// can be found in the git version control history of the project. The
// omission of copyright and license comments in each file is in the
// interest of source tree size.
// 
// In addition, permission is hereby granted for all public header files
// (include/* and arch/* /bits/* ) and crt files intended to be linked into
// applications (crt/*, ldso/dlstart.c, and arch/* /crt_arch.h) to omit
// the copyright notice and permission notice otherwise required by the
// license, and to use these files without any requirement of
// attribution. These files include substantial contributions from:
// 
// Bobby Bingham
// John Spencer
// Nicholas J. Kain
// Rich Felker
// Richard Pennington
// Stefan Kristiansson
// Szabolcs Nagy
// 
// all of whom have explicitly granted such permission.
// 
// This file previously contained text expressing a belief that most of
// the files covered by the above exception were sufficiently trivial not
// to be subject to copyright, resulting in confusion over whether it
// negated the permissions granted in the license. In the spirit of
// permissive licensing, and of not having licensing issues being an
// obstacle to adoption, that text has been removed.
	.text
	.attribute	4, 16
	.attribute	5, "rv32im"
	.file	"musl_memset.c"
	.globl	memset
	.p2align	2
	.type	memset,@function
memset:
	beqz	a2, .LBB0_9memset
	sb	a1, 0(a0)
	add	a3, a2, a0
	li	a4, 3
	sb	a1, -1(a3)
	bltu	a2, a4, .LBB0_9memset
	sb	a1, 1(a0)
	sb	a1, 2(a0)
	sb	a1, -2(a3)
	li	a4, 7
	sb	a1, -3(a3)
	bltu	a2, a4, .LBB0_9memset
	sb	a1, 3(a0)
	li	a5, 9
	sb	a1, -4(a3)
	bltu	a2, a5, .LBB0_9memset
	neg	a3, a0
	andi	a4, a3, 3
	add	a3, a0, a4
	sub	a2, a2, a4
	andi	a2, a2, -4
	andi	a1, a1, 255
	lui	a4, 4112
	addi	a4, a4, 257
	mul	a1, a1, a4
	sw	a1, 0(a3)
	add	a4, a3, a2
	sw	a1, -4(a4)
	bltu	a2, a5, .LBB0_9memset
	sw	a1, 4(a3)
	sw	a1, 8(a3)
	sw	a1, -12(a4)
	li	a5, 25
	sw	a1, -8(a4)
	bltu	a2, a5, .LBB0_9memset
	sw	a1, 12(a3)
	sw	a1, 16(a3)
	sw	a1, 20(a3)
	sw	a1, 24(a3)
	sw	a1, -28(a4)
	sw	a1, -24(a4)
	sw	a1, -20(a4)
	andi	a5, a3, 4
	ori	a5, a5, 24
	sub	a2, a2, a5
	li	a6, 32
	sw	a1, -16(a4)
	bltu	a2, a6, .LBB0_9memset
	add	a3, a3, a5
	li	a4, 31
.LBB0_8memset:
	sw	a1, 0(a3)
	sw	a1, 4(a3)
	sw	a1, 8(a3)
	sw	a1, 12(a3)
	sw	a1, 16(a3)
	sw	a1, 20(a3)
	sw	a1, 24(a3)
	sw	a1, 28(a3)
	addi	a2, a2, -32
	addi	a3, a3, 32
	bltu	a4, a2, .LBB0_8memset
.LBB0_9memset:
	ret
.Lfunc_end0memset:
	.size	memset, .Lfunc_end0memset-memset

	.ident	"Ubuntu clang version 14.0.6-++20220622053131+f28c006a5895-1~exp1~20220622173215.157"
	.section	".note.GNU-stack","",@progbits
	.addrsig
