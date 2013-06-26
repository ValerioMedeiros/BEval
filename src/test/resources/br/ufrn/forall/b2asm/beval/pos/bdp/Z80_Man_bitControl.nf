Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Z80_Man_bitControl))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Z80_Man_bitControl))==(Machine(Z80_Man_bitControl));
  Level(Machine(Z80_Man_bitControl))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Z80_Man_bitControl)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Z80_Man_bitControl))==(ALU,TYPES,BIT_DEFINITION,BYTE_DEFINITION,BV16_DEFINITION,UCHAR_DEFINITION,SCHAR_DEFINITION,SSHORT_DEFINITION,USHORT_DEFINITION,POWER2)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Z80_Man_bitControl))==(MEMORY);
  List_Includes(Machine(Z80_Man_bitControl))==(MEMORY)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Z80_Man_bitControl))==(?);
  Context_List_Variables(Machine(Z80_Man_bitControl))==(?);
  Abstract_List_Variables(Machine(Z80_Man_bitControl))==(?);
  Local_List_Variables(Machine(Z80_Man_bitControl))==(io_ports,im,iff2,iff1,r_,i_,iy,ix,sp,pc,rgs8);
  List_Variables(Machine(Z80_Man_bitControl))==(io_ports,im,iff2,iff1,r_,i_,iy,ix,sp,pc,rgs8,mem);
  External_List_Variables(Machine(Z80_Man_bitControl))==(io_ports,im,iff2,iff1,r_,i_,iy,ix,sp,pc,rgs8,mem)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Z80_Man_bitControl))==(?);
  Abstract_List_VisibleVariables(Machine(Z80_Man_bitControl))==(?);
  External_List_VisibleVariables(Machine(Z80_Man_bitControl))==(?);
  Expanded_List_VisibleVariables(Machine(Z80_Man_bitControl))==(?);
  List_VisibleVariables(Machine(Z80_Man_bitControl))==(?);
  Internal_List_VisibleVariables(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Z80_Man_bitControl))==(btrue);
  Gluing_List_Invariant(Machine(Z80_Man_bitControl))==(btrue);
  Abstract_List_Invariant(Machine(Z80_Man_bitControl))==(btrue);
  Expanded_List_Invariant(Machine(Z80_Man_bitControl))==(mem: BV16 --> BYTE);
  Context_List_Invariant(Machine(Z80_Man_bitControl))==(btrue);
  List_Invariant(Machine(Z80_Man_bitControl))==(rgs8: id_reg_8 --> BYTE & pc: USHORT & sp: BV16 & ix: BV16 & iy: BV16 & i_: BYTE & r_: BYTE & iff1: BIT & iff2: BIT & im: BIT*BIT & io_ports: BYTE --> BYTE)
END
&
THEORY ListAssertionsX IS
  Abstract_List_Assertions(Machine(Z80_Man_bitControl))==(btrue);
  Expanded_List_Assertions(Machine(Z80_Man_bitControl))==(ran(mem) <: BYTE & dom(mem) = BV16 & !(address,value).(address: BV16 & value: BYTE => mem<+{address|->value}: BV16 --> BYTE));
  Context_List_Assertions(Machine(Z80_Man_bitControl))==(is_zero16USHORT: USHORT --> BIT & is_negative: BYTE --> BIT & half8UCHAR: UCHAR --> UCHAR & inc: BYTE --> BYTE & dec: BYTE --> BYTE & simple_add8UCHAR: UCHAR*UCHAR --> UCHAR & add16USHORT: BIT*USHORT*USHORT --> USHORT & substract8UCHAR: BIT*UCHAR*UCHAR --> UCHAR*BIT*BIT*BIT*BIT & add_carryUSHORT: BIT*USHORT*USHORT --> BIT & sub16USHORT: BIT*USHORT*USHORT --> USHORT & sub_carryUSHORT: BIT*USHORT*USHORT --> BIT & inc_BV16: BV16 --> BV16 & dec_BV16: BV16 --> BV16 & update_refresh_reg: BYTE --> BYTE & instruction_next: USHORT --> USHORT & instruction_jump: USHORT*(-126..129) --> USHORT & dom(is_zero16USHORT) = USHORT & ran(is_zero16USHORT) = BIT & dom(is_negative) = BYTE & ran(is_negative) = BIT & dom(half8UCHAR) = UCHAR & ran(half8UCHAR) <: UCHAR & dom(inc) = BYTE & ran(inc) = BYTE & dom(dec) = BYTE & ran(dec) = BYTE & dom(simple_add8UCHAR) = UCHAR*UCHAR & ran(simple_add8UCHAR) = UCHAR & dom(add8UCHAR) = BIT*UCHAR*UCHAR & ran(add8UCHAR): POW(UCHAR*BIT*BIT*BIT*BIT) & dom(substract8UCHAR) = BIT*UCHAR*UCHAR & ran(substract8UCHAR): POW(UCHAR*BIT*BIT*BIT*BIT) & dom(add16USHORT) = BIT*USHORT*USHORT & ran(add16USHORT) = USHORT & dom(add_carryUSHORT) = BIT*USHORT*USHORT & ran(add_carryUSHORT) = BIT & dom(sub16USHORT) = BIT*USHORT*USHORT & ran(sub16USHORT) = USHORT & dom(sub_carryUSHORT) = BIT*USHORT*USHORT & ran(sub_carryUSHORT) = BIT & dom(inc_BV16) = BV16 & ran(inc_BV16) = BV16 & dom(dec_BV16) = BV16 & ran(dec_BV16) = BV16 & dom(update_refresh_reg) = BYTE & ran(update_refresh_reg) = BYTE & dom(instruction_next) = USHORT & ran(instruction_next) = USHORT & dom(instruction_jump) = USHORT*(-126..129) & ran(instruction_jump) = USHORT & 0 = schar_sshort(0,0) & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16 & byte_uchar: BYTE >->> UCHAR & uchar_byte: UCHAR >->> BYTE & byte_uchar = uchar_byte~ & schar_uchar: SCHAR >->> UCHAR & uchar_schar: UCHAR >->> SCHAR & schar_uchar = uchar_schar~ & byte_schar: BYTE >->> SCHAR & schar_byte: SCHAR >->> BYTE & byte_schar = schar_byte~ & bv16_byte: BV16 >->> BYTE*BYTE & byte_bv16: BYTE*BYTE >->> BV16 & bv16_byte = byte_bv16~ & bv16_ushort: BV16 >->> USHORT & ushort_bv16: USHORT >->> BV16 & bv16_ushort = ushort_bv16~ & uchar_ushort: UCHAR*UCHAR >->> USHORT & bv16_sshort: BV16 >->> SSHORT & sshort_bv16: SSHORT >->> BV16 & bv16_sshort = sshort_bv16~ & schar_sshort: SCHAR*SCHAR >->> SSHORT & sshort_ushort: SSHORT >->> USHORT & ushort_sshort: USHORT >->> SSHORT & sshort_ushort = ushort_sshort~ & !bb.(bb: BIT => bit_not(bb) = 1-bb) & dom(bit_and) = BIT*BIT & ran(bit_not) = BIT & bit_not(0) = 1 & bit_not(1) = 0 & !bb.(bb: BIT => bit_not(bit_not(bb)) = bb) & dom(bit_and) = BIT*BIT & ran(bit_and) = BIT & bit_and(0,0) = 0 & bit_and(0,1) = 0 & bit_and(1,0) = 0 & bit_and(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_and(b1,b2) = bit_and(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 1 => bit_and(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 0 => bit_and(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_and(b1,bit_and(b2,b3)) = bit_and(bit_and(b1,b2),b3)) & !b1.(b1: BIT => bit_and(b1,1) = b1) & !b1.(b1: BIT => bit_and(b1,0) = 0) & dom(bit_or) = BIT*BIT & ran(bit_or) = BIT & bit_or(0,0) = 0 & bit_or(0,1) = 1 & bit_or(1,0) = 1 & bit_or(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_or(b1,b2) = bit_or(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 1 => bit_or(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 0 => bit_or(b2,b1) = 0) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 1 => b1 = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 0 => b1 = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_or(b1,bit_or(b2,b3)) = bit_or(bit_or(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = 1) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = bit_or(1,b3)) & !b1.(b1: BIT => bit_or(b1,1) = 1) & !b1.(b1: BIT => bit_or(b1,0) = b1) & !b1.(b1: BIT => bit_or(1,b1) = 1) & !b1.(b1: BIT => bit_or(0,b1) = b1) & dom(bit_xor) = BIT*BIT & ran(bit_xor) = BIT & bit_xor(0,0) = 0 & bit_xor(0,1) = 1 & bit_xor(1,0) = 1 & bit_xor(1,1) = 0 & !(b1,b2).(b1: BIT & b2: BIT => bit_xor(b1,b2) = bit_xor(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 1 => bit_xor(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 0 => bit_xor(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(bit_xor(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_xor(b1,b2) = 1 => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(1,b3)) & !bb.(bb: BIT => bit_xor(bb,bb) = 0) & dom(bool_bit) = BOOL & ran(bit_xor) = BIT & bool_bit(TRUE) = 1 & bool_bit(FALSE) = 0 & !bb.(bb: BIT => bb = 0 or bb = 1) & !bb.(bb: BIT & not(bb = 0) => bb = 1) & !bb.(bb: BIT & not(bb = 1) => bb = 0) & (card(BYTE) = 256 & is_zero: BYTE --> BIT;parity_even: BYTE --> BIT;bv8_and: BYTE*BYTE --> BYTE;bv8_or: BYTE*BYTE --> BYTE;bv8_xor: BYTE*BYTE --> BYTE;complement: BYTE --> BYTE;swap: BYTE --> BYTE;rotateleft: BYTE --> BYTE;rotateright: BYTE --> BYTE;!bt.(bt: BYTE => size(bt) = 8);8: NATURAL;dom(is_zero) = BYTE;ran(is_zero) <: BIT;dom(parity_even) = BYTE;ran(parity_even) <: BIT;bv8_and: BYTE*BYTE --> BYTE;dom(complement) = BYTE;ran(complement) <: BYTE;dom(swap) = BYTE;ran(swap) <: BYTE;dom(rotateleft) = BYTE;ran(rotateleft) <: BYTE;dom(rotateright) = BYTE;ran(rotateright) <: BYTE;dom(get_upper_digit) = BYTE;ran(get_upper_digit) <: 0..16-1;dom(get_lower_digit) = BYTE;ran(get_lower_digit) <: 0..16-1;[1,1,1,1,1,1,1,1]: BYTE & [0,0,0,0,0,0,0,0]: BYTE & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16) & card(BV16) = 65536 & complement16: BV16 --> BV16 & byte_bv16 = bv16_byte~ & [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]: BV16 & [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]: BV16 & card(byte_uchar) = 256 & card(uchar_byte) = 256 & UCHAR_MAX: INTEGER & UCHAR_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & card(byte_schar) = 256 & card(schar_byte) = 256 & SCHAR_MAX: INTEGER & SCHAR_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & card(bv16_sshort) = 65536 & card(sshort_bv16) = 65536 & SSHORT_MIN: SSHORT & SSHORT_MAX: SSHORT & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16 & card(bv16_ushort) = 65536 & card(ushort_bv16) = 65536 & USHORT_MAX: INTEGER & USHORT_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16 & (2**0 = 1;2**1 = 2;2**2 = 4;2**3 = 8;2**4 = 16;2**5 = 32;2**6 = 64;2**7 = 128;(-2)**7 = -128;2**8 = 256;2**9 = 512;2**10 = 1024;2**11 = 2048;2**12 = 4096;2**13 = 8192;2**14 = 16384;2**15 = 32768;2**16 = 65536));
  List_Assertions(Machine(Z80_Man_bitControl))==(card(REG16_TO_REG8) = 5 & card(update_flag_reg) = 64 & get_bv_reg16: BV16*(id_reg_8 --> BYTE)*id_reg_16 +-> BV16 & cc_get: (id_reg_8 --> BYTE)*(0..8) +-> BIT & ran(mem) <: BYTE & dom(mem) = BV16 & ran(rgs8) <: BYTE & dom(rgs8) = id_reg_8 & instruction_next(pc): USHORT & mem(byte_bv16(rgs8(b0),rgs8(c0))): BYTE & mem(byte_bv16(schar_byte(0),mem(byte_bv16(rgs8(b0),rgs8(c0))))): BYTE & mem(byte_bv16(rgs8(d0),rgs8(e0))): BYTE & mem(byte_bv16(schar_byte(0),mem(byte_bv16(rgs8(d0),rgs8(e0))))): BYTE & mem(byte_bv16(rgs8(h0),rgs8(l0))): BYTE & mem(byte_bv16(schar_byte(0),mem(byte_bv16(rgs8(h0),rgs8(l0))))): BYTE & mem(byte_bv16(rgs8(a0),rgs8(f0))): BYTE & mem(byte_bv16(schar_byte(0),mem(byte_bv16(rgs8(a0),rgs8(f0))))): BYTE & mem(sp): BYTE & mem(ix): BYTE & mem(iy): BYTE & update_refresh_reg(r_): BYTE & dom(update_flag_reg) = BIT*BIT*BIT*BIT*BIT*BIT & ran(update_flag_reg): POW({f0}*BYTE) & !(b1,b2,b3,b4,b5,b6).(b1: BIT & b2: BIT & b3: BIT & b4: BIT & b5: BIT & b6: BIT => update_flag_reg(b1,b2,b3,b4,b5,b6): {f0}*BYTE) & !xx.(xx: id_reg_8 --> BYTE => rgs8<+xx: id_reg_8 --> BYTE) & !(xx,xxr).(xx: id_reg_8 & xxr: BYTE => rgs8<+{xx|->xxr}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & not(xx = yy) => rgs8<+{xx|->xxr,yy|->yyr}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr,zz,zzr).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & zz: id_reg_8 & zzr: BYTE & not(xx = yy) & not(xx = zz) & not(yy = zz) => rgs8<+{xx|->xxr,yy|->yyr,zz|->zzr}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr,zz,zzr,vv,vvr).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & zz: id_reg_8 & zzr: BYTE & vv: id_reg_8 & vvr: BYTE & not(xx = yy) & not(xx = zz) & not(xx = vv) & not(yy = zz) & not(yy = vv) & not(zz = vv) => rgs8<+{xx|->xxr,yy|->yyr,zz|->zzr,vv|->vvr}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & zz: id_reg_8 & zzr: BYTE & vv: id_reg_8 & vvr: BYTE & ww: id_reg_8 & wwr: BYTE & not(xx = yy) & not(xx = zz) & not(xx = vv) & not(xx = ww) & not(yy = zz) & not(yy = vv) & not(yy = ww) & not(zz = vv) & not(zz = ww) & not(vv = ww) => rgs8<+{xx|->xxr,yy|->yyr,zz|->zzr,vv|->vvr,ww|->wwr}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr,aa,aar).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & zz: id_reg_8 & zzr: BYTE & vv: id_reg_8 & vvr: BYTE & ww: id_reg_8 & wwr: BYTE & aa: id_reg_8 & aar: BYTE & not(xx = yy) & not(xx = zz) & not(xx = vv) & not(xx = ww) & not(xx = aa) & not(yy = zz) & not(yy = vv) & not(yy = ww) & not(yy = aa) & not(zz = vv) & not(zz = ww) & not(zz = aa) & not(vv = ww) & not(vv = aa) & not(ww = aa) => rgs8<+{xx|->xxr,yy|->yyr,zz|->zzr,vv|->vvr,ww|->wwr,aa|->aar}: id_reg_8 --> BYTE) & !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr,aa,aar,bb,bbr).(xx: id_reg_8 & xxr: BYTE & yy: id_reg_8 & yyr: BYTE & zz: id_reg_8 & zzr: BYTE & vv: id_reg_8 & vvr: BYTE & ww: id_reg_8 & wwr: BYTE & aa: id_reg_8 & aar: BYTE & bb: id_reg_8 & bbr: BYTE & not(xx = yy) & not(xx = zz) & not(xx = vv) & not(xx = ww) & not(xx = aa) & not(xx = bb) & not(yy = zz) & not(yy = vv) & not(yy = ww) & not(yy = aa) & not(yy = bb) & not(zz = vv) & not(zz = ww) & not(zz = aa) & not(zz = bb) & not(vv = ww) & not(vv = aa) & not(vv = bb) & not(ww = aa) & not(ww = bb) & not(aa = bb) => rgs8<+{xx|->xxr,yy|->yyr,zz|->zzr,vv|->vvr,ww|->wwr,aa|->aar,bb|->bbr}: id_reg_8 --> BYTE) & byte_bv16(rgs8(b0),rgs8(c0)): BV16 & byte_bv16(rgs8(h0),rgs8(l0)): BV16 & byte_bv16(rgs8(d0),rgs8(e0)): BV16 & byte_bv16(rgs8(a0),rgs8(f0)): BV16 & mem(byte_bv16(rgs8(b0),rgs8(c0))): BYTE & mem(byte_bv16(rgs8(d0),rgs8(e0))): BYTE & mem(byte_bv16(rgs8(h0),rgs8(l0))): BYTE & mem(byte_bv16(rgs8(a0),rgs8(f0))): BYTE & mem(sp): BYTE & mem(ix): BYTE & mem(iy): BYTE & dec_BV16(byte_bv16(rgs8(b0),rgs8(c0))): BV16 & inc_BV16(byte_bv16(rgs8(b0),rgs8(c0))): BV16 & dec_BV16(byte_bv16(rgs8(d0),rgs8(e0))): BV16 & inc_BV16(byte_bv16(rgs8(d0),rgs8(e0))): BV16 & inc_BV16(byte_bv16(rgs8(h0),rgs8(l0))): BV16 & dec_BV16(byte_bv16(rgs8(h0),rgs8(l0))): BV16 & ushort_bv16(add16USHORT(0,bv16_ushort(sp),1)): BV16 & ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)): BV16 & ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1)): BV16 & ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)): BV16 & bv8get(rgs8(f0),7): BIT & bv8get(rgs8(f0),6): BIT & bv8get(rgs8(f0),5): BIT & bv8get(rgs8(f0),4): BIT & bv8get(rgs8(f0),3): BIT & bv8get(rgs8(f0),2): BIT & bv8get(rgs8(f0),1): BIT & bv8get(rgs8(f0),0): BIT & io_ports(rgs8(c0)): BYTE & dec(rgs8(b0)): BYTE)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Z80_Man_bitControl))==(mem:=%xx.(xx: BV16 | [0,0,0,0,0,0,0,0]);(rgs8,pc,sp,ix,iy,i_,r_:={a0|->[1,1,1,1,1,1,1,1],f0|->[1,1,1,1,1,1,1,1],f_0|->[1,1,1,1,1,1,1,1],a_0|->[1,1,1,1,1,1,1,1],b0|->[1,1,1,1,1,1,1,1],c0|->[1,1,1,1,1,1,1,1],b_0|->[1,1,1,1,1,1,1,1],c_0|->[1,1,1,1,1,1,1,1],d0|->[1,1,1,1,1,1,1,1],e0|->[1,1,1,1,1,1,1,1],d_0|->[1,1,1,1,1,1,1,1],e_0|->[1,1,1,1,1,1,1,1],h0|->[1,1,1,1,1,1,1,1],l0|->[1,1,1,1,1,1,1,1],h_0|->[1,1,1,1,1,1,1,1],l_0|->[1,1,1,1,1,1,1,1]},0,[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0] || @(io_ports$0).(io_ports$0: BYTE --> {[0,0,0,0,0,0,0,0]} ==> io_ports:=io_ports$0) || iff1:=0 || iff2:=0 || im:=0|->0));
  Context_List_Initialisation(Machine(Z80_Man_bitControl))==(skip);
  List_Initialisation(Machine(Z80_Man_bitControl))==(rgs8:={a0|->[1,1,1,1,1,1,1,1],f0|->[1,1,1,1,1,1,1,1],f_0|->[1,1,1,1,1,1,1,1],a_0|->[1,1,1,1,1,1,1,1],b0|->[1,1,1,1,1,1,1,1],c0|->[1,1,1,1,1,1,1,1],b_0|->[1,1,1,1,1,1,1,1],c_0|->[1,1,1,1,1,1,1,1],d0|->[1,1,1,1,1,1,1,1],e0|->[1,1,1,1,1,1,1,1],d_0|->[1,1,1,1,1,1,1,1],e_0|->[1,1,1,1,1,1,1,1],h0|->[1,1,1,1,1,1,1,1],l0|->[1,1,1,1,1,1,1,1],h_0|->[1,1,1,1,1,1,1,1],l_0|->[1,1,1,1,1,1,1,1]} || pc:=0 || sp:=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] || ix:=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] || iy:=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] || i_:=[0,0,0,0,0,0,0,0] || r_:=[0,0,0,0,0,0,0,0] || io_ports:: BYTE --> {[0,0,0,0,0,0,0,0]} || iff1:=0 || iff2:=0 || im:=0|->0)
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListInstanciatedParametersX IS
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(MEMORY))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(ALU))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(TYPES))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(BIT_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(BYTE_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(BV16_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(UCHAR_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(SCHAR_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(SSHORT_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(USHORT_DEFINITION))==(?);
  List_Instanciated_Parameters(Machine(Z80_Man_bitControl),Machine(POWER2))==(?)
END
&
THEORY ListConstraintsX IS
  List_Constraints(Machine(Z80_Man_bitControl),Machine(MEMORY))==(btrue);
  List_Context_Constraints(Machine(Z80_Man_bitControl))==(btrue);
  List_Constraints(Machine(Z80_Man_bitControl))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Z80_Man_bitControl))==(RLCA,RLA,RRCA,RRA,RLC_r,RLC_9HL0,RLC_9IX_d0,RLC_9IY_d0,RL_r,RL_9HL,RL_9IX_d0,RL_9IY_d0,RRC_r,RRC_9HL0,RRC_9IX_d0,RRC_9IY_d0,RR_r,RR_9HL,RR_9IX_d0,RR_9IY_d0,SLA_r,SLA_9HL0,SRA_9HL0,SRA_9IX_d0,SRA_9IY_d0,SRL_r,SRL_9HL0,SRL_9IX_d0,SRL_9IY_d0,RLD,RRD,BIT_b_rr,BIT_b_9HL0,BIT_b_9IX_d0,BIT_b_9IY_d0,SET_b_r,SET_b_9HL0,SET_b_9IX_d0,SET_b_9IY_d0,RES_b_r,RES_b_9HL0,RES_b_9IX_d0,RES_b_9IY_d0,JP_nn,JP_cc_nn,JR_e,JR_C_e,JR_NC_e,JR_Z_e,JR_NZ_e,JP_HL,JP_IX,JP_IY,DJNZ_e,CALL_nn,CALL_cc_nn,RET,RET_cc,RETI,RETN,RST_p);
  List_Operations(Machine(Z80_Man_bitControl))==(RLCA,RLA,RRCA,RRA,RLC_r,RLC_9HL0,RLC_9IX_d0,RLC_9IY_d0,RL_r,RL_9HL,RL_9IX_d0,RL_9IY_d0,RRC_r,RRC_9HL0,RRC_9IX_d0,RRC_9IY_d0,RR_r,RR_9HL,RR_9IX_d0,RR_9IY_d0,SLA_r,SLA_9HL0,SRA_9HL0,SRA_9IX_d0,SRA_9IY_d0,SRL_r,SRL_9HL0,SRL_9IX_d0,SRL_9IY_d0,RLD,RRD,BIT_b_rr,BIT_b_9HL0,BIT_b_9IX_d0,BIT_b_9IY_d0,SET_b_r,SET_b_9HL0,SET_b_9IX_d0,SET_b_9IY_d0,RES_b_r,RES_b_9HL0,RES_b_9IX_d0,RES_b_9IY_d0,JP_nn,JP_cc_nn,JR_e,JR_C_e,JR_NC_e,JR_Z_e,JR_NZ_e,JP_HL,JP_IX,JP_IY,DJNZ_e,CALL_nn,CALL_cc_nn,RET,RET_cc,RETI,RETN,RST_p)
END
&
THEORY ListInputX IS
  List_Input(Machine(Z80_Man_bitControl),RLCA)==(?);
  List_Input(Machine(Z80_Man_bitControl),RLA)==(?);
  List_Input(Machine(Z80_Man_bitControl),RRCA)==(?);
  List_Input(Machine(Z80_Man_bitControl),RRA)==(?);
  List_Input(Machine(Z80_Man_bitControl),RLC_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),RLC_9HL0)==(?);
  List_Input(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RL_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),RL_9HL)==(?);
  List_Input(Machine(Z80_Man_bitControl),RL_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RL_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RRC_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),RRC_9HL0)==(?);
  List_Input(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RR_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),RR_9HL)==(?);
  List_Input(Machine(Z80_Man_bitControl),RR_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RR_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),SLA_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),SLA_9HL0)==(?);
  List_Input(Machine(Z80_Man_bitControl),SRA_9HL0)==(?);
  List_Input(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),SRL_r)==(rr);
  List_Input(Machine(Z80_Man_bitControl),SRL_9HL0)==(?);
  List_Input(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(desloc);
  List_Input(Machine(Z80_Man_bitControl),RLD)==(?);
  List_Input(Machine(Z80_Man_bitControl),RRD)==(?);
  List_Input(Machine(Z80_Man_bitControl),BIT_b_rr)==(bb,rr);
  List_Input(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(bb);
  List_Input(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(desloc,bb);
  List_Input(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(desloc,bb);
  List_Input(Machine(Z80_Man_bitControl),SET_b_r)==(bb,rr);
  List_Input(Machine(Z80_Man_bitControl),SET_b_9HL0)==(bb);
  List_Input(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(bb,desloc);
  List_Input(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(bb,desloc);
  List_Input(Machine(Z80_Man_bitControl),RES_b_r)==(bb,rr);
  List_Input(Machine(Z80_Man_bitControl),RES_b_9HL0)==(bb);
  List_Input(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(bb,desloc);
  List_Input(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(bb,desloc);
  List_Input(Machine(Z80_Man_bitControl),JP_nn)==(nn);
  List_Input(Machine(Z80_Man_bitControl),JP_cc_nn)==(cc,nn);
  List_Input(Machine(Z80_Man_bitControl),JR_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),JR_C_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),JR_NC_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),JR_Z_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),JR_NZ_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),JP_HL)==(?);
  List_Input(Machine(Z80_Man_bitControl),JP_IX)==(?);
  List_Input(Machine(Z80_Man_bitControl),JP_IY)==(?);
  List_Input(Machine(Z80_Man_bitControl),DJNZ_e)==(ee_p);
  List_Input(Machine(Z80_Man_bitControl),CALL_nn)==(nn);
  List_Input(Machine(Z80_Man_bitControl),CALL_cc_nn)==(cc,nn);
  List_Input(Machine(Z80_Man_bitControl),RET)==(?);
  List_Input(Machine(Z80_Man_bitControl),RET_cc)==(cc);
  List_Input(Machine(Z80_Man_bitControl),RETI)==(?);
  List_Input(Machine(Z80_Man_bitControl),RETN)==(?);
  List_Input(Machine(Z80_Man_bitControl),RST_p)==(pp)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Z80_Man_bitControl),RLCA)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLA)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRCA)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRA)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLC_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLC_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RL_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),RL_9HL)==(?);
  List_Output(Machine(Z80_Man_bitControl),RL_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RL_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRC_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRC_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RR_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),RR_9HL)==(?);
  List_Output(Machine(Z80_Man_bitControl),RR_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RR_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SLA_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),SLA_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRA_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRL_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRL_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RLD)==(?);
  List_Output(Machine(Z80_Man_bitControl),RRD)==(?);
  List_Output(Machine(Z80_Man_bitControl),BIT_b_rr)==(?);
  List_Output(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SET_b_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),SET_b_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RES_b_r)==(?);
  List_Output(Machine(Z80_Man_bitControl),RES_b_9HL0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(?);
  List_Output(Machine(Z80_Man_bitControl),JP_nn)==(?);
  List_Output(Machine(Z80_Man_bitControl),JP_cc_nn)==(?);
  List_Output(Machine(Z80_Man_bitControl),JR_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),JR_C_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),JR_NC_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),JR_Z_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),JR_NZ_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),JP_HL)==(?);
  List_Output(Machine(Z80_Man_bitControl),JP_IX)==(?);
  List_Output(Machine(Z80_Man_bitControl),JP_IY)==(?);
  List_Output(Machine(Z80_Man_bitControl),DJNZ_e)==(?);
  List_Output(Machine(Z80_Man_bitControl),CALL_nn)==(?);
  List_Output(Machine(Z80_Man_bitControl),CALL_cc_nn)==(?);
  List_Output(Machine(Z80_Man_bitControl),RET)==(?);
  List_Output(Machine(Z80_Man_bitControl),RET_cc)==(?);
  List_Output(Machine(Z80_Man_bitControl),RETI)==(?);
  List_Output(Machine(Z80_Man_bitControl),RETN)==(?);
  List_Output(Machine(Z80_Man_bitControl),RST_p)==(?)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Z80_Man_bitControl),RLCA)==(RLCA);
  List_Header(Machine(Z80_Man_bitControl),RLA)==(RLA);
  List_Header(Machine(Z80_Man_bitControl),RRCA)==(RRCA);
  List_Header(Machine(Z80_Man_bitControl),RRA)==(RRA);
  List_Header(Machine(Z80_Man_bitControl),RLC_r)==(RLC_r(rr));
  List_Header(Machine(Z80_Man_bitControl),RLC_9HL0)==(RLC_9HL0);
  List_Header(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(RLC_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(RLC_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RL_r)==(RL_r(rr));
  List_Header(Machine(Z80_Man_bitControl),RL_9HL)==(RL_9HL);
  List_Header(Machine(Z80_Man_bitControl),RL_9IX_d0)==(RL_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RL_9IY_d0)==(RL_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RRC_r)==(RRC_r(rr));
  List_Header(Machine(Z80_Man_bitControl),RRC_9HL0)==(RRC_9HL0);
  List_Header(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(RRC_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(RRC_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RR_r)==(RR_r(rr));
  List_Header(Machine(Z80_Man_bitControl),RR_9HL)==(RR_9HL);
  List_Header(Machine(Z80_Man_bitControl),RR_9IX_d0)==(RR_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RR_9IY_d0)==(RR_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),SLA_r)==(SLA_r(rr));
  List_Header(Machine(Z80_Man_bitControl),SLA_9HL0)==(SLA_9HL0);
  List_Header(Machine(Z80_Man_bitControl),SRA_9HL0)==(SRA_9HL0);
  List_Header(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(SRA_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(SRA_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),SRL_r)==(SRL_r(rr));
  List_Header(Machine(Z80_Man_bitControl),SRL_9HL0)==(SRL_9HL0);
  List_Header(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(SRL_9IX_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(SRL_9IY_d0(desloc));
  List_Header(Machine(Z80_Man_bitControl),RLD)==(RLD);
  List_Header(Machine(Z80_Man_bitControl),RRD)==(RRD);
  List_Header(Machine(Z80_Man_bitControl),BIT_b_rr)==(BIT_b_rr(bb,rr));
  List_Header(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(BIT_b_9HL0(bb));
  List_Header(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(BIT_b_9IX_d0(desloc,bb));
  List_Header(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(BIT_b_9IY_d0(desloc,bb));
  List_Header(Machine(Z80_Man_bitControl),SET_b_r)==(SET_b_r(bb,rr));
  List_Header(Machine(Z80_Man_bitControl),SET_b_9HL0)==(SET_b_9HL0(bb));
  List_Header(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(SET_b_9IX_d0(bb,desloc));
  List_Header(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(SET_b_9IY_d0(bb,desloc));
  List_Header(Machine(Z80_Man_bitControl),RES_b_r)==(RES_b_r(bb,rr));
  List_Header(Machine(Z80_Man_bitControl),RES_b_9HL0)==(RES_b_9HL0(bb));
  List_Header(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(RES_b_9IX_d0(bb,desloc));
  List_Header(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(RES_b_9IY_d0(bb,desloc));
  List_Header(Machine(Z80_Man_bitControl),JP_nn)==(JP_nn(nn));
  List_Header(Machine(Z80_Man_bitControl),JP_cc_nn)==(JP_cc_nn(cc,nn));
  List_Header(Machine(Z80_Man_bitControl),JR_e)==(JR_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),JR_C_e)==(JR_C_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),JR_NC_e)==(JR_NC_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),JR_Z_e)==(JR_Z_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),JR_NZ_e)==(JR_NZ_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),JP_HL)==(JP_HL);
  List_Header(Machine(Z80_Man_bitControl),JP_IX)==(JP_IX);
  List_Header(Machine(Z80_Man_bitControl),JP_IY)==(JP_IY);
  List_Header(Machine(Z80_Man_bitControl),DJNZ_e)==(DJNZ_e(ee_p));
  List_Header(Machine(Z80_Man_bitControl),CALL_nn)==(CALL_nn(nn));
  List_Header(Machine(Z80_Man_bitControl),CALL_cc_nn)==(CALL_cc_nn(cc,nn));
  List_Header(Machine(Z80_Man_bitControl),RET)==(RET);
  List_Header(Machine(Z80_Man_bitControl),RET_cc)==(RET_cc(cc));
  List_Header(Machine(Z80_Man_bitControl),RETI)==(RETI);
  List_Header(Machine(Z80_Man_bitControl),RETN)==(RETN);
  List_Header(Machine(Z80_Man_bitControl),RST_p)==(RST_p(pp))
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Z80_Man_bitControl),RLCA)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RLA)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RRCA)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RRA)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RLC_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),RLC_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(desloc: SCHAR & bv16_ushort(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(desloc: SCHAR & bv16_ushort(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RL_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),RL_9HL)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RL_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RL_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RRC_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),RRC_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RR_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),RR_9HL)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): STACK_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RR_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RR_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SLA_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),SLA_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRA_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRL_r)==(rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),SRL_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RLD)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RRD)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),BIT_b_rr)==(bb: 0..7 & rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(bb: 0..7);
  List_Precondition(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR);
  List_Precondition(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR);
  List_Precondition(Machine(Z80_Man_bitControl),SET_b_r)==(bb: 0..7 & rr: id_reg_8);
  List_Precondition(Machine(Z80_Man_bitControl),SET_b_9HL0)==(bb: 0..7 & bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RES_b_r)==(bb: 0..7 & rr: id_reg_8 & rr/=f0);
  List_Precondition(Machine(Z80_Man_bitControl),RES_b_9HL0)==(bb: 0..7 & bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),JP_nn)==(nn: USHORT);
  List_Precondition(Machine(Z80_Man_bitControl),JP_cc_nn)==(cc: 0..7 & nn: USHORT);
  List_Precondition(Machine(Z80_Man_bitControl),JR_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),JR_C_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),JR_NC_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),JR_Z_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),JR_NZ_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),JP_HL)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),JP_IX)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),JP_IY)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),DJNZ_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126);
  List_Precondition(Machine(Z80_Man_bitControl),CALL_nn)==(nn: USHORT & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),CALL_cc_nn)==(cc: 0..8 & nn: USHORT & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR);
  List_Precondition(Machine(Z80_Man_bitControl),RET)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RET_cc)==(cc: 0..7);
  List_Precondition(Machine(Z80_Man_bitControl),RETI)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RETN)==(btrue);
  List_Precondition(Machine(Z80_Man_bitControl),RST_p)==(pp: 0..7 & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RST_p)==(pp: 0..7 & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR | @(pc_l,pc_h).(pc_l: BYTE & pc_h: BYTE & bv16_byte(ushort_bv16(pc)) = pc_l,pc_h ==> ({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->pc_h,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->pc_l}: BV16 +-> BYTE | mem:=mem<+{ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->pc_h,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->pc_l} || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=pp*8 || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RETN)==(btrue | pc,sp,r_,iff1:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))),ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)),update_refresh_reg(r_),iff2);
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RETI)==(btrue | pc,sp,r_:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))),ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RET_cc)==(cc: 0..7 | cc_get(rgs8,cc) = 1 ==> pc,sp:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))),ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)) [] not(cc_get(rgs8,cc) = 1) ==> pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RET)==(btrue | pc,sp,r_:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))),ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),CALL_cc_nn)==(cc: 0..8 & nn: USHORT & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR | @(high,low).(high: BYTE & low: BYTE & high,low = bv16_byte(ushort_bv16(pc)) ==> (cc_get(rgs8,cc) = 1 ==> ({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low}: BV16 +-> BYTE | mem:=mem<+{ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low} || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=nn) [] not(cc_get(rgs8,cc) = 1) ==> pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),CALL_nn)==(nn: USHORT & bv16_ushort(ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))): STACK_R_ADR & bv16_ushort(sp): STACK_R_ADR | @(high,low).(high: BYTE & low: BYTE & high,low = bv16_byte(ushort_bv16(pc)) & ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))/=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) ==> ({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low}: BV16 +-> BYTE | mem:=mem<+{ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low} || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=nn)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),DJNZ_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | rgs8:=rgs8<+{b0|->dec(rgs8(b0))} || (is_zero(dec(rgs8(b0))) = 1 ==> pc:=instruction_next(pc) [] not(is_zero(dec(rgs8(b0))) = 1) ==> pc:=ee_p) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JP_IY)==(btrue | pc,r_:=bv16_ushort(iy),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JP_IX)==(btrue | pc,r_:=bv16_ushort(ix),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JP_HL)==(btrue | pc,r_:=bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JR_NZ_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | bv8get(rgs8(f0),6) = 1 ==> pc:=instruction_next(pc) [] not(bv8get(rgs8(f0),6) = 1) ==> pc:=ee_p || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JR_Z_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | bv8get(rgs8(f0),6) = 0 ==> pc:=instruction_next(pc) [] not(bv8get(rgs8(f0),6) = 0) ==> pc:=ee_p || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JR_NC_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | bv8get(rgs8(f0),0) = 1 ==> pc:=instruction_next(pc) [] not(bv8get(rgs8(f0),0) = 1) ==> pc:=ee_p || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JR_C_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | bv8get(rgs8(f0),0) = 0 ==> pc:=instruction_next(pc) [] not(bv8get(rgs8(f0),0) = 0) ==> pc:=ee_p || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JR_e)==(ee_p: USHORT & ee_p-pc<=129 & ee_p-pc>= -126 | pc,r_:=ee_p,update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JP_cc_nn)==(cc: 0..7 & nn: USHORT | @res.(res: BIT & {0|->bit_not(bv8get(rgs8(f0),6)),1|->bv8get(rgs8(f0),6),2|->bit_not(bv8get(rgs8(f0),0)),3|->bv8get(rgs8(f0),0),4|->bit_not(bv8get(rgs8(f0),2)),5|->bv8get(rgs8(f0),2),6|->bit_not(bv8get(rgs8(f0),7)),7|->bv8get(rgs8(f0),7)}(cc) = res ==> (res = 1 ==> pc:=nn [] not(res = 1) ==> pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),JP_nn)==(nn: USHORT | pc,r_:=nn,update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR & ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & bitclear(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb): BYTE | mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->bitclear(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR & ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & bitclear(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb): BYTE | mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->bitclear(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RES_b_9HL0)==(bb: 0..7 & bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR & byte_bv16(rgs8(h0),rgs8(l0)): BV16 & bitclear(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb): BYTE | mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->bitclear(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RES_b_r)==(bb: 0..7 & rr: id_reg_8 & rr/=f0 | rgs8,pc,r_:=rgs8<+{rr|->bitclear(rgs8(rr),bb)},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR & ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & bitset(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb): BYTE | mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->bitset(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR & ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & bitset(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb): BYTE | mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->bitset(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SET_b_9HL0)==(bb: 0..7 & bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR & byte_bv16(rgs8(h0),rgs8(l0)): BV16 & bitset(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb): BYTE | mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->bitset(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SET_b_r)==(bb: 0..7 & rr: id_reg_8 | rgs8,pc,r_:=rgs8<+{rr|->bitset(rgs8(rr),bb)},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(bb: 0..7 & desloc: SCHAR | rgs8,pc,r_:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(bb: 0..7 & desloc: SCHAR | rgs8,pc,r_:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(bb: 0..7 | rgs8,pc,r_:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),BIT_b_rr)==(bb: 0..7 & rr: id_reg_8 & rr/=f0 | rgs8,pc,r_:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(rgs8(rr),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRD)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @(res,acc).(res: BYTE & acc: BYTE & res = {8|->bv8get(rgs8(a0),3),7|->bv8get(rgs8(a0),2),6|->bv8get(rgs8(a0),1),5|->bv8get(rgs8(a0),0),4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),6),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),5),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),4)} & acc = rgs8(a0)<+{4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),3),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),2),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),1),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(acc),is_zero(acc),0,parity_even(acc),0,bv8get(rgs8(f0),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLD)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @(res,acc).(res: BYTE & acc: BYTE & res = {8|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),3),7|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),2),6|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),1),5|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0),4|->bv8get(rgs8(a0),3),3|->bv8get(rgs8(a0),2),2|->bv8get(rgs8(a0),1),1|->bv8get(rgs8(a0),0)} & acc = rgs8(a0)<+{4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),6),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),5),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),4)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(acc),is_zero(acc),0,parity_even(acc),0,bv8get(rgs8(f0),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = bitclear(rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))),7) ==> (ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = bitclear(rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))),7) ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRL_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = bitclear(rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0)))),7) ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRL_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = bitclear(rotateright(rgs8(rr)),7) ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{7|->bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7)} ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{7|->bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7)} ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SRA_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{8|->mem(byte_bv16(rgs8(h0),rgs8(l0)))(7)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SLA_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{1|->bv8get(rgs8(f0),0)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),SLA_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = rotateright(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RR_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} ==> (ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RR_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RR_9HL)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): STACK_R_ADR | @res.(res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{1|->bv8get(rgs8(f0),0)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RR_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = rotateright(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))) ==> (ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))) ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRC_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0)))) ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRC_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = rotateright(rgs8(rr)) ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RL_9IY_d0)==(desloc: SCHAR & (bv16_ushort(iy)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} ==> (ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7))} || mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RL_9IX_d0)==(desloc: SCHAR & (bv16_ushort(ix)+desloc+65536) mod 65536: DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RL_9HL)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{0|->bv8get(rgs8(f0),0)} ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RL_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = rotateleft(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(desloc: SCHAR & bv16_ushort(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)): DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))) ==> (ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7))} || mem:=mem<+{ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(desloc: SCHAR & bv16_ushort(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)): DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))) ==> (ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7))} || mem:=mem<+{ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLC_9HL0)==(bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))): DATA_R_ADR | @res.(res: BYTE & res = rotateleft(mem(byte_bv16(rgs8(h0),rgs8(l0)))) ==> (byte_bv16(rgs8(h0),rgs8(l0)): BV16 & res: BYTE | rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || mem:=mem<+{byte_bv16(rgs8(h0),rgs8(l0))|->res} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_))));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLC_r)==(rr: id_reg_8 & rr/=f0 | @res.(res: BYTE & res = rotateleft(rgs8(rr)) ==> rgs8,pc,r_:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))},instruction_next(pc),update_refresh_reg(r_)));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRA)==(btrue | rgs8,pc,r_:=rgs8<+{a0|->(rotateright(rgs8(a0))<+{8|->bv8get(rgs8(f0),0)}),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RRCA)==(btrue | rgs8,pc,r_:=rgs8<+{a0|->rotateright(rgs8(a0)),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),0))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLA)==(btrue | rgs8,pc,r_:=rgs8<+{a0|->(rotateleft(rgs8(a0))<+{1|->bv8get(rgs8(f0),0)}),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),7))},instruction_next(pc),update_refresh_reg(r_));
  Expanded_List_Substitution(Machine(Z80_Man_bitControl),RLCA)==(btrue | rgs8,pc,r_:=rgs8<+{a0|->rotateleft(rgs8(a0)),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),7))},instruction_next(pc),update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RLCA)==(rgs8:=rgs8<+{a0|->rotateleft(rgs8(a0)),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),7))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RLA)==(rgs8:=rgs8<+{a0|->(rotateleft(rgs8(a0))<+{1|->bv8get(rgs8(f0),0)}),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),7))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RRCA)==(rgs8:=rgs8<+{a0|->rotateright(rgs8(a0)),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RRA)==(rgs8:=rgs8<+{a0|->(rotateright(rgs8(a0))<+{8|->bv8get(rgs8(f0),0)}),update_flag_reg(bv8get(rgs8(f0),7),bv8get(rgs8(f0),6),0,bv8get(rgs8(f0),2),0,bv8get(rgs8(a0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RLC_r)==(ANY res WHERE res: BYTE & res = rotateleft(rgs8(rr)) THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RLC_9HL0)==(ANY res WHERE res: BYTE & res = rotateleft(mem(byte_bv16(rgs8(h0),rgs8(l0)))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(ANY res WHERE res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(ANY res WHERE res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7))} || updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RL_r)==(ANY res WHERE res: BYTE & res = rotateleft(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RL_9HL)==(ANY res WHERE res: BYTE & res = rotateleft(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{0|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RL_9IX_d0)==(ANY res WHERE res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RL_9IY_d0)==(ANY res WHERE res: BYTE & res = rotateleft(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7))} || updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RRC_r)==(ANY res WHERE res: BYTE & res = rotateright(rgs8(rr)) THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RRC_9HL0)==(ANY res WHERE res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0)))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))) THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RR_r)==(ANY res WHERE res: BYTE & res = rotateright(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RR_9HL)==(ANY res WHERE res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RR_9IX_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RR_9IY_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SLA_r)==(ANY res WHERE res: BYTE & res = rotateright(rgs8(rr))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),7))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SLA_9HL0)==(ANY res WHERE res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{1|->bv8get(rgs8(f0),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRA_9HL0)==(ANY res WHERE res: BYTE & res = rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0))))<+{8|->mem(byte_bv16(rgs8(h0),rgs8(l0)))(7)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)))<+{7|->bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),7)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(ANY res WHERE res: BYTE & res = rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)))<+{7|->bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),7)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(res),is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRL_r)==(ANY res WHERE res: BYTE & res = bitclear(rotateright(rgs8(rr)),7) THEN rgs8:=rgs8<+{rr|->res,update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(rgs8(rr),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRL_9HL0)==(ANY res WHERE res: BYTE & res = bitclear(rotateright(mem(byte_bv16(rgs8(h0),rgs8(l0)))),7) THEN rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(ANY res WHERE res: BYTE & res = bitclear(rotateright(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536))),7) THEN rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(ANY res WHERE res: BYTE & res = bitclear(rotateright(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536))),7) THEN rgs8:=rgs8<+{update_flag_reg(0,is_zero(res),0,parity_even(res),0,bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),0))} || updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RLD)==(ANY res,acc WHERE res: BYTE & acc: BYTE & res = {8|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),3),7|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),2),6|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),1),5|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0),4|->bv8get(rgs8(a0),3),3|->bv8get(rgs8(a0),2),2|->bv8get(rgs8(a0),1),1|->bv8get(rgs8(a0),0)} & acc = rgs8(a0)<+{4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),6),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),5),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),4)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(acc),is_zero(acc),0,parity_even(acc),0,bv8get(rgs8(f0),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RRD)==(ANY res,acc WHERE res: BYTE & acc: BYTE & res = {8|->bv8get(rgs8(a0),3),7|->bv8get(rgs8(a0),2),6|->bv8get(rgs8(a0),1),5|->bv8get(rgs8(a0),0),4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),7),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),6),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),5),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),4)} & acc = rgs8(a0)<+{4|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),3),3|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),2),2|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),1),1|->bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),0)} THEN rgs8:=rgs8<+{update_flag_reg(is_negative(acc),is_zero(acc),0,parity_even(acc),0,bv8get(rgs8(f0),0))} || updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),res) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),BIT_b_rr)==(rgs8:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(rgs8(rr),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(rgs8:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(rgs8:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(rgs8:=rgs8<+{update_flag_reg(bv8get(rgs8(f0),7),bit_not(bv8get(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)),1,bv8get(rgs8(f0),2),0,bv8get(rgs8(f0),0))} || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),SET_b_r)==(rgs8(rr):=bitset(rgs8(rr),bb) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),SET_b_9HL0)==(updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),bitset(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),bitset(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),bitset(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RES_b_r)==(rgs8(rr):=bitclear(rgs8(rr),bb) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RES_b_9HL0)==(updateAddressMem(byte_bv16(rgs8(h0),rgs8(l0)),bitclear(mem(byte_bv16(rgs8(h0),rgs8(l0))),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(updateAddressMem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536),bitclear(mem(ushort_bv16((bv16_ushort(ix)+desloc+65536) mod 65536)),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(updateAddressMem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536),bitclear(mem(ushort_bv16((bv16_ushort(iy)+desloc+65536) mod 65536)),bb)) || pc:=instruction_next(pc) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JP_nn)==(pc:=nn || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JP_cc_nn)==(ANY res WHERE res: BIT & {0|->bit_not(bv8get(rgs8(f0),6)),1|->bv8get(rgs8(f0),6),2|->bit_not(bv8get(rgs8(f0),0)),3|->bv8get(rgs8(f0),0),4|->bit_not(bv8get(rgs8(f0),2)),5|->bv8get(rgs8(f0),2),6|->bit_not(bv8get(rgs8(f0),7)),7|->bv8get(rgs8(f0),7)}(cc) = res THEN IF res = 1 THEN pc:=nn ELSE pc:=instruction_next(pc) END || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),JR_e)==(pc:=ee_p || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JR_C_e)==(IF bv8get(rgs8(f0),0) = 0 THEN pc:=instruction_next(pc) ELSE pc:=ee_p END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JR_NC_e)==(IF bv8get(rgs8(f0),0) = 1 THEN pc:=instruction_next(pc) ELSE pc:=ee_p END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JR_Z_e)==(IF bv8get(rgs8(f0),6) = 0 THEN pc:=instruction_next(pc) ELSE pc:=ee_p END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JR_NZ_e)==(IF bv8get(rgs8(f0),6) = 1 THEN pc:=instruction_next(pc) ELSE pc:=ee_p END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JP_HL)==(pc:=bv16_ushort(byte_bv16(rgs8(h0),rgs8(l0))) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JP_IX)==(pc:=bv16_ushort(ix) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),JP_IY)==(pc:=bv16_ushort(iy) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),DJNZ_e)==(rgs8(b0):=dec(rgs8(b0)) || IF is_zero(dec(rgs8(b0))) = 1 THEN pc:=instruction_next(pc) ELSE pc:=ee_p END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),CALL_nn)==(ANY high,low WHERE high: BYTE & low: BYTE & high,low = bv16_byte(ushort_bv16(pc)) & ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))/=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) THEN updateStack({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low}) || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=nn END);
  List_Substitution(Machine(Z80_Man_bitControl),CALL_cc_nn)==(ANY high,low WHERE high: BYTE & low: BYTE & high,low = bv16_byte(ushort_bv16(pc)) THEN IF cc_get(rgs8,cc) = 1 THEN updateStack({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->high,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->low}) || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=nn ELSE pc:=instruction_next(pc) END || r_:=update_refresh_reg(r_) END);
  List_Substitution(Machine(Z80_Man_bitControl),RET)==(pc:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))) || sp:=ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RET_cc)==(IF cc_get(rgs8,cc) = 1 THEN pc:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))) || sp:=ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)) ELSE pc:=instruction_next(pc) END || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RETI)==(pc:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))) || sp:=ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)) || r_:=update_refresh_reg(r_));
  List_Substitution(Machine(Z80_Man_bitControl),RETN)==(pc:=bv16_ushort(byte_bv16(mem(ushort_bv16(add16USHORT(0,bv16_ushort(sp),1))),mem(sp))) || sp:=ushort_bv16(add16USHORT(0,bv16_ushort(sp),2)) || r_:=update_refresh_reg(r_) || iff1:=iff2);
  List_Substitution(Machine(Z80_Man_bitControl),RST_p)==(ANY pc_l,pc_h WHERE pc_l: BYTE & pc_h: BYTE & bv16_byte(ushort_bv16(pc)) = pc_l,pc_h THEN updateStack({ushort_bv16(sub16USHORT(0,bv16_ushort(sp),1))|->pc_h,ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2))|->pc_l}) || sp:=ushort_bv16(sub16USHORT(0,bv16_ushort(sp),2)) || pc:=pp*8 || r_:=update_refresh_reg(r_) END)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Z80_Man_bitControl))==(PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR,get_bv_reg16,REG16_TO_REG8,REG8_TO_REG16,update_flag_reg,cc_get);
  Inherited_List_Constants(Machine(Z80_Man_bitControl))==(PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR);
  List_Constants(Machine(Z80_Man_bitControl))==(get_bv_reg16,REG16_TO_REG8,REG8_TO_REG16,update_flag_reg,cc_get)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Z80_Man_bitControl),id_reg_8)==({a0,f0,f_0,a_0,b0,c0,b_0,c_0,d0,e0,d_0,e_0,h0,l0,h_0,l_0});
  Context_List_Enumerated(Machine(Z80_Man_bitControl))==(?);
  Context_List_Defered(Machine(Z80_Man_bitControl))==(?);
  Context_List_Sets(Machine(Z80_Man_bitControl))==(?);
  List_Valuable_Sets(Machine(Z80_Man_bitControl))==(?);
  Inherited_List_Enumerated(Machine(Z80_Man_bitControl))==(?);
  Inherited_List_Defered(Machine(Z80_Man_bitControl))==(?);
  Inherited_List_Sets(Machine(Z80_Man_bitControl))==(?);
  List_Enumerated(Machine(Z80_Man_bitControl))==(id_reg_8,id_reg_16);
  List_Defered(Machine(Z80_Man_bitControl))==(?);
  List_Sets(Machine(Z80_Man_bitControl))==(id_reg_8,id_reg_16);
  Set_Definition(Machine(Z80_Man_bitControl),id_reg_16)==({BC,DE,HL,SP,AF})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Z80_Man_bitControl))==(?);
  Expanded_List_HiddenConstants(Machine(Z80_Man_bitControl))==(?);
  List_HiddenConstants(Machine(Z80_Man_bitControl))==(?);
  External_List_HiddenConstants(Machine(Z80_Man_bitControl))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Z80_Man_bitControl))==(btrue);
  Context_List_Properties(Machine(Z80_Man_bitControl))==(is_zero16USHORT = %nat1.(nat1: USHORT | bool_bit(bool(nat1 = 0))) & is_negative = %w1.(w1: BYTE | w1(7)) & half8UCHAR = %ww.(ww: UCHAR | ww mod 16) & inc = %w1.(w1: BYTE | uchar_byte((byte_uchar(w1)+1) mod 256)) & dec = %w1.(w1: BYTE | uchar_byte((byte_uchar(w1)+255) mod 256)) & simple_add8UCHAR = %(w1,w2).(w1: UCHAR & w2: UCHAR | (w1+w2) mod 256) & add8UCHAR = %(carry,w1,w2).(carry: BIT & w1: UCHAR & w2: UCHAR | (carry+w1+w2) mod 256,bool_bit(bool(carry+uchar_schar(w1)+uchar_schar(w2)<0)),bool_bit(bool(carry+w1+w2>UCHAR_MAX)),bool_bit(bool(carry+half8UCHAR(w1)+half8UCHAR(w2)>=16)),bool_bit(bool((carry+w1+w2) mod 256 = 0))) & substract8UCHAR = %(carry,w1,w2).(carry: BIT & w1: UCHAR & w2: UCHAR | (carry+w1+(256-w2)) mod 256,bool_bit(bool(carry+uchar_schar(w1)-uchar_schar(w2)<0)),bool_bit(bool(carry+w1-w2>UCHAR_MAX)),bool_bit(bool(carry+half8UCHAR(w1)-half8UCHAR(w2)>=16)),bool_bit(bool((carry+w1+(256-w2)) mod 256 = 0))) & add16USHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | (b1+w1+w2) mod 65536) & add_carryUSHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | bool_bit(bool(b1+w1+w2>=65536))) & add_halfcarryUSHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | bool_bit(bool(b1+w1 mod 4096+w2 mod 4096>4096))) & sub16USHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | (b1+w1+(65536-w2)) mod 65536) & sub_carryUSHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | bool_bit(bool(w1+w2-b1>65536))) & sub_halfcarryUSHORT = %(b1,w1,w2).(b1: BIT & w1: USHORT & w2: USHORT | bool_bit(bool(w1 mod 4096+w2 mod 4096-b1>4096))) & inc_BV16 = %w1.(w1: BV16 | ushort_bv16((bv16_ushort(w1)+1) mod 65536)) & dec_BV16 = %w1.(w1: BV16 | ushort_bv16((bv16_ushort(w1)+65536-1) mod 65536)) & update_refresh_reg = %v0.(v0: BYTE | uchar_byte(128*v0(8)+(64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+v0(1)) mod 128)) & instruction_next = %w1.(w1: USHORT | (w1+1) mod 65536) & instruction_jump = %(p0,e0).(p0: USHORT & e0: -126..129 | (p0+e0+65536) mod 65536) & BIT = {0,1} & bit_not: BIT >->> BIT & bit_not = {0|->1}\/{1|->0} & bit_and: BIT*BIT --> BIT & bit_and = {(0,0)|->0}\/{(0,1)|->0}\/{(1,0)|->0}\/{(1,1)|->1} & bit_or: BIT*BIT --> BIT & bit_or = {(0,0)|->0}\/{(0,1)|->1}\/{(1,0)|->1}\/{(1,1)|->1} & bit_xor: BIT*BIT --> BIT & bit_xor = {(0,0)|->0}\/{(0,1)|->1}\/{(1,0)|->1}\/{(1,1)|->0} & bool_bit = {TRUE|->1,FALSE|->0} & BYTE_INDEX = 1..8 & PHYS_BYTE_INDEX = 0..8-1 & BYTE = BYTE_INDEX --> BIT & !b1.(b1: BYTE => size(b1) = 8 & b1: seq1(BIT)) & is_zero: BYTE --> BIT & is_zero = %w1.(w1: BYTE | bool_bit(bool(w1(1) = w1(2) & w1(2) = w1(3) & w1(3) = w1(4) & w1(4) = w1(5) & w1(5) = w1(6) & w1(6) = w1(7) & w1(7) = w1(8) & w1(8) = 0))) & parity_even: BYTE --> BIT & parity_even = %bv.(bv: BYTE | 1-(bv(1)+bv(2)+bv(3)+bv(4)+bv(5)+bv(6)+bv(7)+bv(8)) mod 2) & bv8_and = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_and(bt1(idx),bt2(idx)))) & bv8_or = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_or(bt1(idx),bt2(idx)))) & bv8_xor = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_xor(bt1(idx),bt2(idx)))) & bv8get: BYTE*PHYS_BYTE_INDEX --> BIT & bv8get = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1(ii+1)) & bitset: BYTE*PHYS_BYTE_INDEX --> BYTE & bitset = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1<+{ii+1|->1}) & bitclear: BYTE*PHYS_BYTE_INDEX --> BYTE & bitclear = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1<+{ii+1|->0}) & complement: BYTE --> BYTE & complement = %bt.(bt: BYTE | %idx.(idx: 1..8 | bit_not(bt(idx)))) & swap: BYTE --> BYTE & swap = %bt.(bt: BYTE | {1|->bt(5),2|->bt(6),3|->bt(7),4|->bt(8),5|->bt(1),6|->bt(2),7|->bt(3),8|->bt(4)}) & rotateleft: BYTE --> BYTE & rotateleft = %bv.(bv: BYTE | {1|->bv(8),2|->bv(1),3|->bv(2),4|->bv(3),5|->bv(4),6|->bv(5),7|->bv(6),8|->bv(7)}) & rotateright: BYTE --> BYTE & rotateright = %bv.(bv: BYTE | {1|->bv(2),2|->bv(3),3|->bv(4),4|->bv(5),5|->bv(6),6|->bv(7),7|->bv(8),8|->bv(1)}) & get_upper_digit: BYTE --> 0..15 & get_upper_digit = %by.(by: BYTE | 8*by(8)+4*by(7)+2*by(6)+by(5)) & get_lower_digit: BYTE --> 0..15 & get_lower_digit = %by.(by: BYTE | 8*by(4)+4*by(3)+2*by(2)+by(1)) & BV16_INDX = 1..16 & PHYS_BV16_INDEX = 0..16-1 & BV16 = BV16_INDX --> BIT & !b1.(b1: BV16 => size(b1) = 16 & b1: seq1(BIT)) & complement16 = %bt.(bt: BV16 | %idx.(idx: 1..16 | bit_not(bt(idx)))) & bv16_byte = %bv.(bv: BV16 | {8|->bv(16),7|->bv(15),6|->bv(14),5|->bv(13),4|->bv(12),3|->bv(11),2|->bv(10),1|->bv(9)},{8|->bv(8),7|->bv(7),6|->bv(6),5|->bv(5),4|->bv(4),3|->bv(3),2|->bv(2),1|->bv(1)}) & byte_bv16 = %(bv1,bv2).(bv1: BYTE & bv2: BYTE | {16|->bv1(8),15|->bv1(7),14|->bv1(6),13|->bv1(5),12|->bv1(4),11|->bv1(3),10|->bv1(2),9|->bv1(1),8|->bv2(8),7|->bv2(7),6|->bv2(6),5|->bv2(5),4|->bv2(4),3|->bv2(3),2|->bv2(2),1|->bv2(1)}) & UCHAR_MAX = 256-1 & UCHAR_MIN = 0 & UCHAR = UCHAR_MIN..UCHAR_MAX & byte_uchar = %v0.(v0: BYTE | 128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+1*v0(1)) & uchar_byte = %v0.(v0: UCHAR | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128]) & SCHAR_MAX = 128-1 & SCHAR_MIN = -128 & SCHAR = SCHAR_MIN..SCHAR_MAX & byte_schar = %v0.(v0: BYTE | (-128)*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+v0(1)) & schar_byte = %v0.(v0: SCHAR & v0>=0 | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128])\/%v0.(v0: SCHAR & not(v0>=0) | [(v0+256) mod 2/1,(v0+256) mod 4/2,(v0+256) mod 8/4,(v0+256) mod 16/8,(v0+256) mod 32/16,(v0+256) mod 64/32,(v0+256) mod 128/64,(v0+256) mod 256/128]) & uchar_schar = %v1.(v1: UCHAR & v1<=SCHAR_MAX | v1)\/%v1.(v1: UCHAR & not(v1<=SCHAR_MAX) | v1-256) & schar_uchar = %v1.(v1: 0..127 | v1)\/%v1.(v1: -128.. -1 | v1+256) & SSHORT_MIN = -32768 & SSHORT_MAX = 32768-1 & SSHORT = SSHORT_MIN..SSHORT_MAX & bv16_sshort = %v0.(v0: BV16 | (-32768)*v0(16)+16384*v0(15)+8192*v0(14)+4096*v0(13)+2048*v0(12)+1024*v0(11)+512*v0(10)+256*v0(9)+128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+v0(1)) & sshort_bv16 = %v0.(v0: SSHORT & v0>=0 | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128,v0 mod 512/256,v0 mod 1024/512,v0 mod 2048/1024,v0 mod 4096/2048,v0 mod 8192/4096,v0 mod 16384/8192,v0 mod 32768/16384,v0 mod 65536/32768])\/%v0.(v0: SSHORT & not(v0>=0) | [(v0+USHORT_MAX+1) mod 2/1,(v0+USHORT_MAX+1) mod 4/2,(v0+USHORT_MAX+1) mod 8/4,(v0+USHORT_MAX+1) mod 16/8,(v0+USHORT_MAX+1) mod 32/16,(v0+USHORT_MAX+1) mod 64/32,(v0+USHORT_MAX+1) mod 128/64,(v0+USHORT_MAX+1) mod 256/128,(v0+USHORT_MAX+1) mod 512/256,(v0+USHORT_MAX+1) mod 1024/512,(v0+USHORT_MAX+1) mod 2048/1024,(v0+USHORT_MAX+1) mod 4096/2048,(v0+USHORT_MAX+1) mod 8192/4096,(v0+USHORT_MAX+1) mod 16384/8192,(v0+USHORT_MAX+1) mod 32768/16384,(v0+USHORT_MAX+1) mod 65536/32768]) & ushort_sshort = %v1.(v1: USHORT & v1<=SSHORT_MAX | v1)\/%v1.(v1: USHORT & not(v1<=SSHORT_MAX) | v1-USHORT_MAX-1) & sshort_ushort = %v1.(v1: SSHORT & v1>=0 | v1)\/%v1.(v1: SSHORT & not(v1>=0) | v1+USHORT_MAX+1) & schar_sshort = %(w1,w2).(w1: SCHAR & w2: SCHAR | bv16_sshort(byte_bv16(schar_byte(w1),schar_byte(w2)))) & USHORT_MAX = 65536-1 & USHORT_MIN = 0 & USHORT = USHORT_MIN..USHORT_MAX & bv16_ushort = %v0.(v0: BV16 | 32768*v0(16)+16384*v0(15)+8192*v0(14)+4096*v0(13)+2048*v0(12)+1024*v0(11)+512*v0(10)+256*v0(9)+128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+1*v0(1)) & ushort_bv16 = %v0.(v0: USHORT | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128,v0 mod 512/256,v0 mod 1024/512,v0 mod 2048/1024,v0 mod 4096/2048,v0 mod 8192/4096,v0 mod 16384/8192,v0 mod 32768/16384,v0 mod 65536/32768]) & uchar_ushort = %(w1,w2).(w1: UCHAR & w2: UCHAR | bv16_ushort(byte_bv16(uchar_byte(w1),uchar_byte(w2)))));
  Inherited_List_Properties(Machine(Z80_Man_bitControl))==(PROGRAM_R_ADR = USHORT & DATA_R_ADR = USHORT & STACK_R_ADR = USHORT);
  List_Properties(Machine(Z80_Man_bitControl))==(REG16_TO_REG8: id_reg_16 +-> id_reg_8*id_reg_8 & REG16_TO_REG8 = %idf.(idf: id_reg_16 & idf = BC | b0,c0)\/%idf.(idf: id_reg_16 & idf = DE | d0,e0)\/%idf.(idf: id_reg_16 & idf = HL | h0,l0)\/%idf.(idf: id_reg_16 & idf = AF | a0,f0) & REG8_TO_REG16: id_reg_8*id_reg_8 +-> id_reg_16 & REG8_TO_REG16 = %(idf1,idf2).(idf1: id_reg_8 & idf2: id_reg_8 & idf1 = b0 & idf2 = c0 | BC)\/%(idf1,idf2).(idf1: id_reg_8 & idf2: id_reg_8 & idf1 = d0 & idf2 = e0 | DE)\/%(idf1,idf2).(idf1: id_reg_8 & idf2: id_reg_8 & idf1 = h0 & idf2 = l0 | HL)\/%(idf1,idf2).(idf1: id_reg_8 & idf2: id_reg_8 & idf1 = a0 & idf2 = f0 | AF) & update_flag_reg = %(s7,z6,h4,pv2,n_add_sub,c0).(s7: BIT & z6: BIT & h4: BIT & pv2: BIT & n_add_sub: BIT & c0: BIT | f0|->[c0,n_add_sub,pv2,1,h4,1,z6,s7]) & cc_get = %(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 0 | 1-bv8get(rgs8_(f0),6))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 1 | bv8get(rgs8_(f0),6))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 2 | 1-bv8get(rgs8_(f0),0))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 3 | bv8get(rgs8_(f0),0))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 4 | 1-bv8get(rgs8_(f0),2))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 5 | bv8get(rgs8_(f0),2))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 6 | 1-bv8get(rgs8_(f0),7))\/%(rgs8_,ind).(rgs8_: id_reg_8 --> BYTE & ind = 7 | bv8get(rgs8_(f0),7)) & get_bv_reg16 = %(sp_,rgs8_,r1).(sp_: BV16 & rgs8_: id_reg_8 --> BYTE & r1 = BC | byte_bv16(rgs8_(b0),rgs8_(c0)))\/%(sp_,rgs8_,r1).(sp_: BV16 & rgs8_: id_reg_8 --> BYTE & r1 = DE | byte_bv16(rgs8_(d0),rgs8_(e0)))\/%(sp_,rgs8_,r1).(sp_: BV16 & rgs8_: id_reg_8 --> BYTE & r1 = HL | byte_bv16(rgs8_(h0),rgs8_(l0)))\/%(sp_,rgs8_,r1).(sp_: BV16 & rgs8_: id_reg_8 --> BYTE & r1 = SP | sp_)\/%(sp_,rgs8_,r1).(sp_: BV16 & rgs8_: id_reg_8 --> BYTE & r1 = AF | byte_bv16(rgs8_(a0),rgs8_(f0))) & id_reg_8: FIN(INTEGER) & not(id_reg_8 = {}) & id_reg_16: FIN(INTEGER) & not(id_reg_16 = {}))
END
&
THEORY ListSeenInfoX IS
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(POWER2))==(?);
  Seen_Context_List_Enumerated(Machine(Z80_Man_bitControl))==(?);
  Seen_Context_List_Invariant(Machine(Z80_Man_bitControl))==(btrue);
  Seen_Context_List_Assertions(Machine(Z80_Man_bitControl))==(byte_uchar: BYTE >->> UCHAR & uchar_byte: UCHAR >->> BYTE & byte_uchar = uchar_byte~ & schar_uchar: SCHAR >->> UCHAR & uchar_schar: UCHAR >->> SCHAR & schar_uchar = uchar_schar~ & byte_schar: BYTE >->> SCHAR & schar_byte: SCHAR >->> BYTE & byte_schar = schar_byte~ & bv16_byte: BV16 >->> BYTE*BYTE & byte_bv16: BYTE*BYTE >->> BV16 & bv16_byte = byte_bv16~ & bv16_ushort: BV16 >->> USHORT & ushort_bv16: USHORT >->> BV16 & bv16_ushort = ushort_bv16~ & uchar_ushort: UCHAR*UCHAR >->> USHORT & bv16_sshort: BV16 >->> SSHORT & sshort_bv16: SSHORT >->> BV16 & bv16_sshort = sshort_bv16~ & schar_sshort: SCHAR*SCHAR >->> SSHORT & sshort_ushort: SSHORT >->> USHORT & ushort_sshort: USHORT >->> SSHORT & sshort_ushort = ushort_sshort~ & !bb.(bb: BIT => bit_not(bb) = 1-bb) & dom(bit_and) = BIT*BIT & ran(bit_not) = BIT & bit_not(0) = 1 & bit_not(1) = 0 & !bb.(bb: BIT => bit_not(bit_not(bb)) = bb) & dom(bit_and) = BIT*BIT & ran(bit_and) = BIT & bit_and(0,0) = 0 & bit_and(0,1) = 0 & bit_and(1,0) = 0 & bit_and(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_and(b1,b2) = bit_and(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 1 => bit_and(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_and(b1,b2) = 0 => bit_and(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_and(b1,bit_and(b2,b3)) = bit_and(bit_and(b1,b2),b3)) & !b1.(b1: BIT => bit_and(b1,1) = b1) & !b1.(b1: BIT => bit_and(b1,0) = 0) & dom(bit_or) = BIT*BIT & ran(bit_or) = BIT & bit_or(0,0) = 0 & bit_or(0,1) = 1 & bit_or(1,0) = 1 & bit_or(1,1) = 1 & !(b1,b2).(b1: BIT & b2: BIT => bit_or(b1,b2) = bit_or(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 1 => bit_or(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,b2) = 0 => bit_or(b2,b1) = 0) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 1 => b1 = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_or(b1,0) = 0 => b1 = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_or(b1,bit_or(b2,b3)) = bit_or(bit_or(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = 1) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_or(b1,b2) = 1 => bit_or(b1,bit_or(b2,b3)) = bit_or(1,b3)) & !b1.(b1: BIT => bit_or(b1,1) = 1) & !b1.(b1: BIT => bit_or(b1,0) = b1) & !b1.(b1: BIT => bit_or(1,b1) = 1) & !b1.(b1: BIT => bit_or(0,b1) = b1) & dom(bit_xor) = BIT*BIT & ran(bit_xor) = BIT & bit_xor(0,0) = 0 & bit_xor(0,1) = 1 & bit_xor(1,0) = 1 & bit_xor(1,1) = 0 & !(b1,b2).(b1: BIT & b2: BIT => bit_xor(b1,b2) = bit_xor(b2,b1)) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 1 => bit_xor(b2,b1) = 1) & !(b1,b2).(b1: BIT & b2: BIT & bit_xor(b1,b2) = 0 => bit_xor(b2,b1) = 0) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(bit_xor(b1,b2),b3)) & !(b1,b2,b3).(b1: BIT & b2: BIT & b3: BIT & bit_xor(b1,b2) = 1 => bit_xor(b1,bit_xor(b2,b3)) = bit_xor(1,b3)) & !bb.(bb: BIT => bit_xor(bb,bb) = 0) & dom(bool_bit) = BOOL & ran(bit_xor) = BIT & bool_bit(TRUE) = 1 & bool_bit(FALSE) = 0 & !bb.(bb: BIT => bb = 0 or bb = 1) & !bb.(bb: BIT & not(bb = 0) => bb = 1) & !bb.(bb: BIT & not(bb = 1) => bb = 0) & (card(BYTE) = 256 & is_zero: BYTE --> BIT;parity_even: BYTE --> BIT;bv8_and: BYTE*BYTE --> BYTE;bv8_or: BYTE*BYTE --> BYTE;bv8_xor: BYTE*BYTE --> BYTE;complement: BYTE --> BYTE;swap: BYTE --> BYTE;rotateleft: BYTE --> BYTE;rotateright: BYTE --> BYTE;!bt.(bt: BYTE => size(bt) = 8);8: NATURAL;dom(is_zero) = BYTE;ran(is_zero) <: BIT;dom(parity_even) = BYTE;ran(parity_even) <: BIT;bv8_and: BYTE*BYTE --> BYTE;dom(complement) = BYTE;ran(complement) <: BYTE;dom(swap) = BYTE;ran(swap) <: BYTE;dom(rotateleft) = BYTE;ran(rotateleft) <: BYTE;dom(rotateright) = BYTE;ran(rotateright) <: BYTE;dom(get_upper_digit) = BYTE;ran(get_upper_digit) <: 0..16-1;dom(get_lower_digit) = BYTE;ran(get_lower_digit) <: 0..16-1;[1,1,1,1,1,1,1,1]: BYTE & [0,0,0,0,0,0,0,0]: BYTE & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16) & card(BV16) = 65536 & complement16: BV16 --> BV16 & byte_bv16 = bv16_byte~ & [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]: BV16 & [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]: BV16 & card(byte_uchar) = 256 & card(uchar_byte) = 256 & UCHAR_MAX: INTEGER & UCHAR_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & card(byte_schar) = 256 & card(schar_byte) = 256 & SCHAR_MAX: INTEGER & SCHAR_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & card(bv16_sshort) = 65536 & card(sshort_bv16) = 65536 & SSHORT_MIN: SSHORT & SSHORT_MAX: SSHORT & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16 & card(bv16_ushort) = 65536 & card(ushort_bv16) = 65536 & USHORT_MAX: INTEGER & USHORT_MIN: INTEGER & 1 = 2**0 & 2 = 2**1 & 4 = 2**2 & 8 = 2**3 & 16 = 2**4 & 32 = 2**5 & 64 = 2**6 & 128 = 2**7 & 256 = 2**8 & 512 = 2**9 & 1024 = 2**10 & 2048 = 2**11 & 4096 = 2**12 & 8192 = 2**13 & 16384 = 2**14 & 32768 = 2**15 & 65536 = 2**16 & (2**0 = 1;2**1 = 2;2**2 = 4;2**3 = 8;2**4 = 16;2**5 = 32;2**6 = 64;2**7 = 128;(-2)**7 = -128;2**8 = 256;2**9 = 512;2**10 = 1024;2**11 = 2048;2**12 = 4096;2**13 = 8192;2**14 = 16384;2**15 = 32768;2**16 = 65536) & !(nn,pp).(nn: NATURAL1 & pp: NAT => (pp = 0 => nn**pp = 1) & (pp = 1 => nn**pp = nn) & (pp>1 => nn**pp = nn*nn**(pp-1))));
  Seen_Context_List_Properties(Machine(Z80_Man_bitControl))==(BIT = {0,1} & bit_not: BIT >->> BIT & bit_not = {0|->1}\/{1|->0} & bit_and: BIT*BIT --> BIT & bit_and = {(0,0)|->0}\/{(0,1)|->0}\/{(1,0)|->0}\/{(1,1)|->1} & bit_or: BIT*BIT --> BIT & bit_or = {(0,0)|->0}\/{(0,1)|->1}\/{(1,0)|->1}\/{(1,1)|->1} & bit_xor: BIT*BIT --> BIT & bit_xor = {(0,0)|->0}\/{(0,1)|->1}\/{(1,0)|->1}\/{(1,1)|->0} & bool_bit = {TRUE|->1,FALSE|->0} & BYTE_INDEX = 1..8 & PHYS_BYTE_INDEX = 0..8-1 & BYTE = BYTE_INDEX --> BIT & !b1.(b1: BYTE => size(b1) = 8 & b1: seq1(BIT)) & is_zero: BYTE --> BIT & is_zero = %w1.(w1: BYTE | bool_bit(bool(w1(1) = w1(2) & w1(2) = w1(3) & w1(3) = w1(4) & w1(4) = w1(5) & w1(5) = w1(6) & w1(6) = w1(7) & w1(7) = w1(8) & w1(8) = 0))) & parity_even: BYTE --> BIT & parity_even = %bv.(bv: BYTE | 1-(bv(1)+bv(2)+bv(3)+bv(4)+bv(5)+bv(6)+bv(7)+bv(8)) mod 2) & bv8_and = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_and(bt1(idx),bt2(idx)))) & bv8_or = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_or(bt1(idx),bt2(idx)))) & bv8_xor = %(bt1,bt2).(bt1: BYTE & bt2: BYTE | %idx.(idx: 1..8 | bit_xor(bt1(idx),bt2(idx)))) & bv8get: BYTE*PHYS_BYTE_INDEX --> BIT & bv8get = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1(ii+1)) & bitset: BYTE*PHYS_BYTE_INDEX --> BYTE & bitset = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1<+{ii+1|->1}) & bitclear: BYTE*PHYS_BYTE_INDEX --> BYTE & bitclear = %(bt1,ii).(bt1: BYTE & ii: PHYS_BYTE_INDEX | bt1<+{ii+1|->0}) & complement: BYTE --> BYTE & complement = %bt.(bt: BYTE | %idx.(idx: 1..8 | bit_not(bt(idx)))) & swap: BYTE --> BYTE & swap = %bt.(bt: BYTE | {1|->bt(5),2|->bt(6),3|->bt(7),4|->bt(8),5|->bt(1),6|->bt(2),7|->bt(3),8|->bt(4)}) & rotateleft: BYTE --> BYTE & rotateleft = %bv.(bv: BYTE | {1|->bv(8),2|->bv(1),3|->bv(2),4|->bv(3),5|->bv(4),6|->bv(5),7|->bv(6),8|->bv(7)}) & rotateright: BYTE --> BYTE & rotateright = %bv.(bv: BYTE | {1|->bv(2),2|->bv(3),3|->bv(4),4|->bv(5),5|->bv(6),6|->bv(7),7|->bv(8),8|->bv(1)}) & get_upper_digit: BYTE --> 0..15 & get_upper_digit = %by.(by: BYTE | 8*by(8)+4*by(7)+2*by(6)+by(5)) & get_lower_digit: BYTE --> 0..15 & get_lower_digit = %by.(by: BYTE | 8*by(4)+4*by(3)+2*by(2)+by(1)) & BV16_INDX = 1..16 & PHYS_BV16_INDEX = 0..16-1 & BV16 = BV16_INDX --> BIT & !b1.(b1: BV16 => size(b1) = 16 & b1: seq1(BIT)) & complement16 = %bt.(bt: BV16 | %idx.(idx: 1..16 | bit_not(bt(idx)))) & bv16_byte = %bv.(bv: BV16 | {8|->bv(16),7|->bv(15),6|->bv(14),5|->bv(13),4|->bv(12),3|->bv(11),2|->bv(10),1|->bv(9)},{8|->bv(8),7|->bv(7),6|->bv(6),5|->bv(5),4|->bv(4),3|->bv(3),2|->bv(2),1|->bv(1)}) & byte_bv16 = %(bv1,bv2).(bv1: BYTE & bv2: BYTE | {16|->bv1(8),15|->bv1(7),14|->bv1(6),13|->bv1(5),12|->bv1(4),11|->bv1(3),10|->bv1(2),9|->bv1(1),8|->bv2(8),7|->bv2(7),6|->bv2(6),5|->bv2(5),4|->bv2(4),3|->bv2(3),2|->bv2(2),1|->bv2(1)}) & UCHAR_MAX = 256-1 & UCHAR_MIN = 0 & UCHAR = UCHAR_MIN..UCHAR_MAX & byte_uchar = %v0.(v0: BYTE | 128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+1*v0(1)) & uchar_byte = %v0.(v0: UCHAR | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128]) & SCHAR_MAX = 128-1 & SCHAR_MIN = -128 & SCHAR = SCHAR_MIN..SCHAR_MAX & byte_schar = %v0.(v0: BYTE | (-128)*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+v0(1)) & schar_byte = %v0.(v0: SCHAR & v0>=0 | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128])\/%v0.(v0: SCHAR & not(v0>=0) | [(v0+256) mod 2/1,(v0+256) mod 4/2,(v0+256) mod 8/4,(v0+256) mod 16/8,(v0+256) mod 32/16,(v0+256) mod 64/32,(v0+256) mod 128/64,(v0+256) mod 256/128]) & uchar_schar = %v1.(v1: UCHAR & v1<=SCHAR_MAX | v1)\/%v1.(v1: UCHAR & not(v1<=SCHAR_MAX) | v1-256) & schar_uchar = %v1.(v1: 0..127 | v1)\/%v1.(v1: -128.. -1 | v1+256) & SSHORT_MIN = -32768 & SSHORT_MAX = 32768-1 & SSHORT = SSHORT_MIN..SSHORT_MAX & bv16_sshort = %v0.(v0: BV16 | (-32768)*v0(16)+16384*v0(15)+8192*v0(14)+4096*v0(13)+2048*v0(12)+1024*v0(11)+512*v0(10)+256*v0(9)+128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+v0(1)) & sshort_bv16 = %v0.(v0: SSHORT & v0>=0 | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128,v0 mod 512/256,v0 mod 1024/512,v0 mod 2048/1024,v0 mod 4096/2048,v0 mod 8192/4096,v0 mod 16384/8192,v0 mod 32768/16384,v0 mod 65536/32768])\/%v0.(v0: SSHORT & not(v0>=0) | [(v0+USHORT_MAX+1) mod 2/1,(v0+USHORT_MAX+1) mod 4/2,(v0+USHORT_MAX+1) mod 8/4,(v0+USHORT_MAX+1) mod 16/8,(v0+USHORT_MAX+1) mod 32/16,(v0+USHORT_MAX+1) mod 64/32,(v0+USHORT_MAX+1) mod 128/64,(v0+USHORT_MAX+1) mod 256/128,(v0+USHORT_MAX+1) mod 512/256,(v0+USHORT_MAX+1) mod 1024/512,(v0+USHORT_MAX+1) mod 2048/1024,(v0+USHORT_MAX+1) mod 4096/2048,(v0+USHORT_MAX+1) mod 8192/4096,(v0+USHORT_MAX+1) mod 16384/8192,(v0+USHORT_MAX+1) mod 32768/16384,(v0+USHORT_MAX+1) mod 65536/32768]) & ushort_sshort = %v1.(v1: USHORT & v1<=SSHORT_MAX | v1)\/%v1.(v1: USHORT & not(v1<=SSHORT_MAX) | v1-USHORT_MAX-1) & sshort_ushort = %v1.(v1: SSHORT & v1>=0 | v1)\/%v1.(v1: SSHORT & not(v1>=0) | v1+USHORT_MAX+1) & schar_sshort = %(w1,w2).(w1: SCHAR & w2: SCHAR | bv16_sshort(byte_bv16(schar_byte(w1),schar_byte(w2)))) & USHORT_MAX = 65536-1 & USHORT_MIN = 0 & USHORT = USHORT_MIN..USHORT_MAX & bv16_ushort = %v0.(v0: BV16 | 32768*v0(16)+16384*v0(15)+8192*v0(14)+4096*v0(13)+2048*v0(12)+1024*v0(11)+512*v0(10)+256*v0(9)+128*v0(8)+64*v0(7)+32*v0(6)+16*v0(5)+8*v0(4)+4*v0(3)+2*v0(2)+1*v0(1)) & ushort_bv16 = %v0.(v0: USHORT | [v0 mod 2/1,v0 mod 4/2,v0 mod 8/4,v0 mod 16/8,v0 mod 32/16,v0 mod 64/32,v0 mod 128/64,v0 mod 256/128,v0 mod 512/256,v0 mod 1024/512,v0 mod 2048/1024,v0 mod 4096/2048,v0 mod 8192/4096,v0 mod 16384/8192,v0 mod 32768/16384,v0 mod 65536/32768]) & uchar_ushort = %(w1,w2).(w1: UCHAR & w2: UCHAR | bv16_ushort(byte_bv16(uchar_byte(w1),uchar_byte(w2)))));
  Seen_List_Constraints(Machine(Z80_Man_bitControl))==(btrue);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(POWER2))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(POWER2))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(USHORT_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(USHORT_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(USHORT_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(SSHORT_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(SSHORT_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(SSHORT_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(SCHAR_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(SCHAR_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(SCHAR_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(UCHAR_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(UCHAR_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(UCHAR_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(BV16_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(BV16_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(BV16_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(BYTE_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(BYTE_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(BYTE_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(BIT_DEFINITION))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(BIT_DEFINITION))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(BIT_DEFINITION))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(TYPES))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(TYPES))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(TYPES))==(btrue);
  Seen_Internal_List_Operations(Machine(Z80_Man_bitControl),Machine(ALU))==(?);
  Seen_List_Operations(Machine(Z80_Man_bitControl),Machine(ALU))==(?);
  Seen_Expanded_List_Invariant(Machine(Z80_Man_bitControl),Machine(ALU))==(btrue)
END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Z80_Man_bitControl),RLCA)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RLA)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RRCA)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RRA)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RLC_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RLC_9HL0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RLC_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RLC_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RL_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RL_9HL)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RL_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RL_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RRC_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RRC_9HL0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RRC_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RRC_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RR_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RR_9HL)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RR_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RR_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SLA_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SLA_9HL0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRA_9HL0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRA_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRA_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRL_r)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRL_9HL0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRL_9IX_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),SRL_9IY_d0)==(Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));
  List_ANY_Var(Machine(Z80_Man_bitControl),RLD)==((Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))),(Var(acc) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));
  List_ANY_Var(Machine(Z80_Man_bitControl),RRD)==((Var(res) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))),(Var(acc) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));
  List_ANY_Var(Machine(Z80_Man_bitControl),BIT_b_rr)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),BIT_b_9HL0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),BIT_b_9IX_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),BIT_b_9IY_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),SET_b_r)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),SET_b_9HL0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),SET_b_9IX_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),SET_b_9IY_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RES_b_r)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RES_b_9HL0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RES_b_9IX_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RES_b_9IY_d0)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JP_nn)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JP_cc_nn)==(Var(res) == btype(INTEGER,?,?));
  List_ANY_Var(Machine(Z80_Man_bitControl),JR_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JR_C_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JR_NC_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JR_Z_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JR_NZ_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JP_HL)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JP_IX)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),JP_IY)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),DJNZ_e)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),CALL_nn)==((Var(high) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))),(Var(low) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));
  List_ANY_Var(Machine(Z80_Man_bitControl),CALL_cc_nn)==((Var(high) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))),(Var(low) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));
  List_ANY_Var(Machine(Z80_Man_bitControl),RET)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RET_cc)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RETI)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RETN)==(?);
  List_ANY_Var(Machine(Z80_Man_bitControl),RST_p)==((Var(pc_l) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))),(Var(pc_h) == SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));
  List_ANY_Var(Machine(Z80_Man_bitControl),?)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Z80_Man_bitControl)) == (get_bv_reg16,REG16_TO_REG8,REG8_TO_REG16,update_flag_reg,cc_get,id_reg_8,id_reg_16,a0,f0,f_0,a_0,b0,c0,b_0,c_0,d0,e0,d_0,e_0,h0,l0,h_0,l_0,BC,DE,HL,SP,AF | PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR | io_ports,im,iff2,iff1,r_,i_,iy,ix,sp,pc,rgs8 | mem | RLCA,RLA,RRCA,RRA,RLC_r,RLC_9HL0,RLC_9IX_d0,RLC_9IY_d0,RL_r,RL_9HL,RL_9IX_d0,RL_9IY_d0,RRC_r,RRC_9HL0,RRC_9IX_d0,RRC_9IY_d0,RR_r,RR_9HL,RR_9IX_d0,RR_9IY_d0,SLA_r,SLA_9HL0,SRA_9HL0,SRA_9IX_d0,SRA_9IY_d0,SRL_r,SRL_9HL0,SRL_9IX_d0,SRL_9IY_d0,RLD,RRD,BIT_b_rr,BIT_b_9HL0,BIT_b_9IX_d0,BIT_b_9IY_d0,SET_b_r,SET_b_9HL0,SET_b_9IX_d0,SET_b_9IY_d0,RES_b_r,RES_b_9HL0,RES_b_9IX_d0,RES_b_9IY_d0,JP_nn,JP_cc_nn,JR_e,JR_C_e,JR_NC_e,JR_Z_e,JR_NZ_e,JP_HL,JP_IX,JP_IY,DJNZ_e,CALL_nn,CALL_cc_nn,RET,RET_cc,RETI,RETN,RST_p | ? | seen(Machine(ALU)),seen(Machine(TYPES)),seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(UCHAR_DEFINITION)),seen(Machine(SCHAR_DEFINITION)),seen(Machine(SSHORT_DEFINITION)),seen(Machine(USHORT_DEFINITION)),seen(Machine(POWER2)),included(Machine(MEMORY)) | ? | Z80_Man_bitControl);
  List_Of_HiddenCst_Ids(Machine(Z80_Man_bitControl)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Z80_Man_bitControl)) == (get_bv_reg16,REG16_TO_REG8,REG8_TO_REG16,update_flag_reg,cc_get,PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR);
  List_Of_VisibleVar_Ids(Machine(Z80_Man_bitControl)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Z80_Man_bitControl)) == (seen(Machine(ALU)): (is_zero16USHORT,is_negative,half8UCHAR,inc,dec,simple_add8UCHAR,add8UCHAR,substract8UCHAR,add16USHORT,add_carryUSHORT,add_halfcarryUSHORT,sub16USHORT,sub_carryUSHORT,sub_halfcarryUSHORT,inc_BV16,dec_BV16,update_refresh_reg,instruction_next,instruction_jump | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(BIT_DEFINITION)): (BIT,bit_not,bit_and,bit_or,bit_xor,bool_bit | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(BYTE_DEFINITION)): (BYTE,BYTE_INDEX,PHYS_BYTE_INDEX,is_zero,parity_even,bv8_and,bv8_or,bv8_xor,bitclear,bitset,bv8get,complement,swap,rotateleft,rotateright,get_upper_digit,get_lower_digit | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(BV16_DEFINITION)): (BV16_INDX,PHYS_BV16_INDEX,BV16,bv16_byte,byte_bv16,complement16 | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(UCHAR_DEFINITION)): (UCHAR_MAX,UCHAR_MIN,UCHAR,uchar_byte,byte_uchar | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(SCHAR_DEFINITION)): (SCHAR_MAX,SCHAR_MIN,SCHAR,byte_schar,schar_byte,uchar_schar,schar_uchar | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(SSHORT_DEFINITION)): (SSHORT_MIN,SSHORT_MAX,SSHORT,bv16_sshort,sshort_bv16,schar_sshort,ushort_sshort,sshort_ushort | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(USHORT_DEFINITION)): (USHORT_MAX,USHORT_MIN,USHORT,bv16_ushort,ushort_bv16,uchar_ushort | ? | ? | ? | ? | ? | ? | ? | ?) | seen(Machine(POWER2)): (? | ? | ? | ? | ? | ? | ? | ? | ?));
  List_Of_Ids(Machine(MEMORY)) == (PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR | ? | mem | ? | updateMem,updateAddressMem,updateStack,updateAddressStack | ? | seen(Machine(ALU)),seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(UCHAR_DEFINITION)),seen(Machine(SCHAR_DEFINITION)),seen(Machine(SSHORT_DEFINITION)),seen(Machine(USHORT_DEFINITION)),seen(Machine(POWER2)) | ? | MEMORY);
  List_Of_HiddenCst_Ids(Machine(MEMORY)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(MEMORY)) == (PROGRAM_R_ADR,DATA_R_ADR,STACK_R_ADR);
  List_Of_VisibleVar_Ids(Machine(MEMORY)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(MEMORY)) == (?: ?);
  List_Of_Ids(Machine(POWER2)) == (? | ? | ? | ? | ? | ? | seen(Machine(POWER)) | ? | POWER2);
  List_Of_HiddenCst_Ids(Machine(POWER2)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(POWER2)) == (?);
  List_Of_VisibleVar_Ids(Machine(POWER2)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(POWER2)) == (?: ?);
  List_Of_Ids(Machine(POWER)) == (? | ? | ? | ? | ? | ? | ? | ? | POWER);
  List_Of_HiddenCst_Ids(Machine(POWER)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(POWER)) == (?);
  List_Of_VisibleVar_Ids(Machine(POWER)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(POWER)) == (?: ?);
  List_Of_Ids(Machine(USHORT_DEFINITION)) == (USHORT_MAX,USHORT_MIN,USHORT,bv16_ushort,ushort_bv16,uchar_ushort | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(UCHAR_DEFINITION)),seen(Machine(POWER2)) | ? | USHORT_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(USHORT_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(USHORT_DEFINITION)) == (USHORT_MAX,USHORT_MIN,USHORT,bv16_ushort,ushort_bv16,uchar_ushort);
  List_Of_VisibleVar_Ids(Machine(USHORT_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(USHORT_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(UCHAR_DEFINITION)) == (UCHAR_MAX,UCHAR_MIN,UCHAR,uchar_byte,byte_uchar | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(POWER2)) | ? | UCHAR_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(UCHAR_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(UCHAR_DEFINITION)) == (UCHAR_MAX,UCHAR_MIN,UCHAR,uchar_byte,byte_uchar);
  List_Of_VisibleVar_Ids(Machine(UCHAR_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(UCHAR_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BYTE_DEFINITION)) == (BYTE,BYTE_INDEX,PHYS_BYTE_INDEX,is_zero,parity_even,bv8_and,bv8_or,bv8_xor,bitclear,bitset,bv8get,complement,swap,rotateleft,rotateright,get_upper_digit,get_lower_digit | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(POWER2)) | ? | BYTE_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BYTE_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BYTE_DEFINITION)) == (BYTE,BYTE_INDEX,PHYS_BYTE_INDEX,is_zero,parity_even,bv8_and,bv8_or,bv8_xor,bitclear,bitset,bv8get,complement,swap,rotateleft,rotateright,get_upper_digit,get_lower_digit);
  List_Of_VisibleVar_Ids(Machine(BYTE_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BYTE_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BIT_DEFINITION)) == (BIT,bit_not,bit_and,bit_or,bit_xor,bool_bit | ? | ? | ? | ? | ? | ? | ? | BIT_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BIT_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BIT_DEFINITION)) == (BIT,bit_not,bit_and,bit_or,bit_xor,bool_bit);
  List_Of_VisibleVar_Ids(Machine(BIT_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BIT_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(BV16_DEFINITION)) == (BV16_INDX,PHYS_BV16_INDEX,BV16,bv16_byte,byte_bv16,complement16 | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)) | ? | BV16_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(BV16_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(BV16_DEFINITION)) == (BV16_INDX,PHYS_BV16_INDEX,BV16,bv16_byte,byte_bv16,complement16);
  List_Of_VisibleVar_Ids(Machine(BV16_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(BV16_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(SSHORT_DEFINITION)) == (SSHORT_MIN,SSHORT_MAX,SSHORT,bv16_sshort,sshort_bv16,schar_sshort,ushort_sshort,sshort_ushort | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(SCHAR_DEFINITION)),seen(Machine(USHORT_DEFINITION)),seen(Machine(POWER2)) | ? | SSHORT_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(SSHORT_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(SSHORT_DEFINITION)) == (SSHORT_MIN,SSHORT_MAX,SSHORT,bv16_sshort,sshort_bv16,schar_sshort,ushort_sshort,sshort_ushort);
  List_Of_VisibleVar_Ids(Machine(SSHORT_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(SSHORT_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(SCHAR_DEFINITION)) == (SCHAR_MAX,SCHAR_MIN,SCHAR,byte_schar,schar_byte,uchar_schar,schar_uchar | ? | ? | ? | ? | ? | seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(UCHAR_DEFINITION)),seen(Machine(POWER2)) | ? | SCHAR_DEFINITION);
  List_Of_HiddenCst_Ids(Machine(SCHAR_DEFINITION)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(SCHAR_DEFINITION)) == (SCHAR_MAX,SCHAR_MIN,SCHAR,byte_schar,schar_byte,uchar_schar,schar_uchar);
  List_Of_VisibleVar_Ids(Machine(SCHAR_DEFINITION)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(SCHAR_DEFINITION)) == (?: ?);
  List_Of_Ids(Machine(ALU)) == (is_zero16USHORT,is_negative,half8UCHAR,inc,dec,simple_add8UCHAR,add8UCHAR,substract8UCHAR,add16USHORT,add_carryUSHORT,add_halfcarryUSHORT,sub16USHORT,sub_carryUSHORT,sub_halfcarryUSHORT,inc_BV16,dec_BV16,update_refresh_reg,instruction_next,instruction_jump | ? | ? | ? | ? | ? | seen(Machine(TYPES)),seen(Machine(BIT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(UCHAR_DEFINITION)),seen(Machine(SCHAR_DEFINITION)),seen(Machine(SSHORT_DEFINITION)),seen(Machine(USHORT_DEFINITION)),seen(Machine(POWER2)) | ? | ALU);
  List_Of_HiddenCst_Ids(Machine(ALU)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(ALU)) == (is_zero16USHORT,is_negative,half8UCHAR,inc,dec,simple_add8UCHAR,add8UCHAR,substract8UCHAR,add16USHORT,add_carryUSHORT,add_halfcarryUSHORT,sub16USHORT,sub_carryUSHORT,sub_halfcarryUSHORT,inc_BV16,dec_BV16,update_refresh_reg,instruction_next,instruction_jump);
  List_Of_VisibleVar_Ids(Machine(ALU)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(ALU)) == (?: ?);
  List_Of_Ids(Machine(TYPES)) == (? | ? | ? | ? | ? | ? | seen(Machine(UCHAR_DEFINITION)),seen(Machine(SCHAR_DEFINITION)),seen(Machine(USHORT_DEFINITION)),seen(Machine(SSHORT_DEFINITION)),seen(Machine(BYTE_DEFINITION)),seen(Machine(BV16_DEFINITION)),seen(Machine(BIT_DEFINITION)) | ? | TYPES);
  List_Of_HiddenCst_Ids(Machine(TYPES)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(TYPES)) == (?);
  List_Of_VisibleVar_Ids(Machine(TYPES)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(TYPES)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Z80_Man_bitControl)) == (Type(id_reg_8) == Cst(SetOf(etype(id_reg_8,0,15)));Type(id_reg_16) == Cst(SetOf(etype(id_reg_16,0,4))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Z80_Man_bitControl)) == (Type(STACK_R_ADR) == Cst(SetOf(btype(INTEGER,"[STACK_R_ADR","]STACK_R_ADR")));Type(DATA_R_ADR) == Cst(SetOf(btype(INTEGER,"[DATA_R_ADR","]DATA_R_ADR")));Type(PROGRAM_R_ADR) == Cst(SetOf(btype(INTEGER,"[PROGRAM_R_ADR","]PROGRAM_R_ADR")));Type(a0) == Cst(etype(id_reg_8,0,15));Type(f0) == Cst(etype(id_reg_8,0,15));Type(f_0) == Cst(etype(id_reg_8,0,15));Type(a_0) == Cst(etype(id_reg_8,0,15));Type(b0) == Cst(etype(id_reg_8,0,15));Type(c0) == Cst(etype(id_reg_8,0,15));Type(b_0) == Cst(etype(id_reg_8,0,15));Type(c_0) == Cst(etype(id_reg_8,0,15));Type(d0) == Cst(etype(id_reg_8,0,15));Type(e0) == Cst(etype(id_reg_8,0,15));Type(d_0) == Cst(etype(id_reg_8,0,15));Type(e_0) == Cst(etype(id_reg_8,0,15));Type(h0) == Cst(etype(id_reg_8,0,15));Type(l0) == Cst(etype(id_reg_8,0,15));Type(h_0) == Cst(etype(id_reg_8,0,15));Type(l_0) == Cst(etype(id_reg_8,0,15));Type(BC) == Cst(etype(id_reg_16,0,4));Type(DE) == Cst(etype(id_reg_16,0,4));Type(HL) == Cst(etype(id_reg_16,0,4));Type(SP) == Cst(etype(id_reg_16,0,4));Type(AF) == Cst(etype(id_reg_16,0,4));Type(get_bv_reg16) == Cst(SetOf(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))*SetOf(etype(id_reg_8,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)))*etype(id_reg_16,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))));Type(REG16_TO_REG8) == Cst(SetOf(etype(id_reg_16,?,?)*(etype(id_reg_8,?,?)*etype(id_reg_8,?,?))));Type(REG8_TO_REG16) == Cst(SetOf(etype(id_reg_8,?,?)*etype(id_reg_8,?,?)*etype(id_reg_16,?,?)));Type(update_flag_reg) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*btype(INTEGER,?,?)*(etype(id_reg_8,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)))));Type(cc_get) == Cst(SetOf(SetOf(etype(id_reg_8,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)))*btype(INTEGER,?,?)*btype(INTEGER,?,?))))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Z80_Man_bitControl)) == (Type(mem) == Mvl(SetOf(SetOf(btype(INTEGER,"[BV16_INDX","]BV16_INDX")*btype(INTEGER,"[BIT","]BIT"))*SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));Type(io_ports) == Mvl(SetOf(SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))*SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT"))));Type(im) == Mvl(btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(iff2) == Mvl(btype(INTEGER,?,?));Type(iff1) == Mvl(btype(INTEGER,?,?));Type(r_) == Mvl(SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));Type(i_) == Mvl(SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")));Type(iy) == Mvl(SetOf(btype(INTEGER,"[BV16_INDX","]BV16_INDX")*btype(INTEGER,"[BIT","]BIT")));Type(ix) == Mvl(SetOf(btype(INTEGER,"[BV16_INDX","]BV16_INDX")*btype(INTEGER,"[BIT","]BIT")));Type(sp) == Mvl(SetOf(btype(INTEGER,"[BV16_INDX","]BV16_INDX")*btype(INTEGER,"[BIT","]BIT")));Type(pc) == Mvl(btype(INTEGER,?,?));Type(rgs8) == Mvl(SetOf(etype(id_reg_8,0,15)*SetOf(btype(INTEGER,"[BYTE_INDEX","]BYTE_INDEX")*btype(INTEGER,"[BIT","]BIT")))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Z80_Man_bitControl)) == (Type(RST_p) == Cst(No_type,btype(INTEGER,?,?));Type(RETN) == Cst(No_type,No_type);Type(RETI) == Cst(No_type,No_type);Type(RET_cc) == Cst(No_type,btype(INTEGER,?,?));Type(RET) == Cst(No_type,No_type);Type(CALL_cc_nn) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(CALL_nn) == Cst(No_type,btype(INTEGER,?,?));Type(DJNZ_e) == Cst(No_type,btype(INTEGER,?,?));Type(JP_IY) == Cst(No_type,No_type);Type(JP_IX) == Cst(No_type,No_type);Type(JP_HL) == Cst(No_type,No_type);Type(JR_NZ_e) == Cst(No_type,btype(INTEGER,?,?));Type(JR_Z_e) == Cst(No_type,btype(INTEGER,?,?));Type(JR_NC_e) == Cst(No_type,btype(INTEGER,?,?));Type(JR_C_e) == Cst(No_type,btype(INTEGER,?,?));Type(JR_e) == Cst(No_type,btype(INTEGER,?,?));Type(JP_cc_nn) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(JP_nn) == Cst(No_type,btype(INTEGER,?,?));Type(RES_b_9IY_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(RES_b_9IX_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(RES_b_9HL0) == Cst(No_type,btype(INTEGER,?,?));Type(RES_b_r) == Cst(No_type,btype(INTEGER,?,?)*etype(id_reg_8,?,?));Type(SET_b_9IY_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(SET_b_9IX_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(SET_b_9HL0) == Cst(No_type,btype(INTEGER,?,?));Type(SET_b_r) == Cst(No_type,btype(INTEGER,?,?)*etype(id_reg_8,?,?));Type(BIT_b_9IY_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(BIT_b_9IX_d0) == Cst(No_type,btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(BIT_b_9HL0) == Cst(No_type,btype(INTEGER,?,?));Type(BIT_b_rr) == Cst(No_type,btype(INTEGER,?,?)*etype(id_reg_8,?,?));Type(RRD) == Cst(No_type,No_type);Type(RLD) == Cst(No_type,No_type);Type(SRL_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(SRL_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(SRL_9HL0) == Cst(No_type,No_type);Type(SRL_r) == Cst(No_type,etype(id_reg_8,?,?));Type(SRA_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(SRA_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(SRA_9HL0) == Cst(No_type,No_type);Type(SLA_9HL0) == Cst(No_type,No_type);Type(SLA_r) == Cst(No_type,etype(id_reg_8,?,?));Type(RR_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RR_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RR_9HL) == Cst(No_type,No_type);Type(RR_r) == Cst(No_type,etype(id_reg_8,?,?));Type(RRC_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RRC_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RRC_9HL0) == Cst(No_type,No_type);Type(RRC_r) == Cst(No_type,etype(id_reg_8,?,?));Type(RL_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RL_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RL_9HL) == Cst(No_type,No_type);Type(RL_r) == Cst(No_type,etype(id_reg_8,?,?));Type(RLC_9IY_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RLC_9IX_d0) == Cst(No_type,btype(INTEGER,?,?));Type(RLC_9HL0) == Cst(No_type,No_type);Type(RLC_r) == Cst(No_type,etype(id_reg_8,?,?));Type(RRA) == Cst(No_type,No_type);Type(RRCA) == Cst(No_type,No_type);Type(RLA) == Cst(No_type,No_type);Type(RLCA) == Cst(No_type,No_type))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  event_b_project == KO;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO
END
)
