/* Z80_general
 * Author: valerio
 * Creation date: sáb abr 28 2012
 */
MACHINE
    Z80_general
    
INCLUDES
    MEMORY
SEES 
    ALU ,
    TYPES,
    BIT_DEFINITION,
    BYTE_DEFINITION,
    BV16_DEFINITION,
    
    UCHAR_DEFINITION,
    SCHAR_DEFINITION,
    SSHORT_DEFINITION,
    USHORT_DEFINITION,
    POWER2 
   
SETS
    id_reg_8 = { a0 , f0 , f_0 , a_0 ,
        b0 , c0 , b_0 , c_0 ,
        d0 , e0 , d_0 , e_0 ,
        h0 , l0 , h_0 , l_0 } ;
    id_reg_16 = { BC , DE , HL , SP , AF }        
ABSTRACT_VARIABLES
    rgs8,
    pc , sp , ix , iy ,
    i_,r_ , 
    iff1 , iff2,
    im ,
    io_ports   
INVARIANT
    rgs8 : id_reg_8 --> BYTE &
    pc : USHORT & sp : BV16 & ix : BV16 & iy : BV16 &
    i_ : BYTE & r_  : BYTE & 
    iff1 : BIT &  iff2 : BIT &
    im : (BIT*BIT) &
    io_ports  : BYTE --> BYTE

DEFINITIONS
    SET_PREF_SYMBOLIC == TRUE;
    SET_PREF_EXPAND_CLOSURES_FOR_STATE == FALSE;
    /*To make sure that CLPFD is turned on in the DEFINITIONS:*/
    SET_PREF_CLPFD == TRUE;    


    pow2_0 == 1;
    pow2_1 == 2;
    pow2_2 == 4;
    pow2_3 == 8;
    pow2_4 == 16;
    pow2_5 == 32;
    pow2_6 == 64;
    pow2_7 == 128;
    pow2_8 == 256;
    pow2_9 == 512;
    pow2_10 == 1024;    
    pow2_11 == 2048;  
    pow2_12 == 4096;   
    pow2_13 == 8192;
    pow2_14 == 16384;   
    pow2_15 == 32768; 
    pow2_16 == 65536;


    bv_BC == byte_bv16 ( rgs8 ( b0 ) , rgs8 ( c0 ) ) ;
    bv_HL == byte_bv16 ( rgs8 ( h0 ) , rgs8 ( l0 ) ) ;
    bv_DE == byte_bv16 ( rgs8 ( d0 ) , rgs8 ( e0 ) ) ;
    bv_AF == byte_bv16 ( rgs8 ( a0 ) , rgs8 ( f0 ) ) ;
    
    bv_9BC0 == mem ( byte_bv16 ( rgs8 ( b0 ) , rgs8 ( c0 ) ) );
    bv_9DE0 == mem ( byte_bv16 ( rgs8 ( d0 ) , rgs8 ( e0 ) ) );
    bv_9HL0 == mem ( byte_bv16 ( rgs8 ( h0 ) , rgs8 ( l0 ) ) );
    bv_9AF0 == mem ( byte_bv16 ( rgs8 ( a0 ) , rgs8 ( f0 ) ) );
    
    bv_9SP0 == mem ( sp );
    bv_9IX0 == mem ( ix );
    bv_9IY0 == mem ( iy );
    
    sp_plus_one == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , 1 ) );
    sp_plus_two == ushort_bv16 ( add16USHORT ( 0 , bv16_ushort ( sp ) , 2 ) );
    sp_minus_one == ushort_bv16 ( sub16USHORT ( 0 , bv16_ushort ( sp ) , 1 ) );
    sp_minus_two == ushort_bv16 ( sub16USHORT ( 0 , bv16_ushort ( sp ) , 2 ) );
    
    z_s  == bv8get ( rgs8 ( f0 ) , 7 ) ;
    z_z  == bv8get ( rgs8 ( f0 ) , 6 ) ;
    z_00 == bv8get ( rgs8 ( f0 ) , 5 ) ;
    z_h  == bv8get ( rgs8 ( f0 ) , 4 ) ;
    z_01 == bv8get ( rgs8 ( f0 ) , 3 ) ;
    z_p  == bv8get ( rgs8 ( f0 ) , 2 ) ;
    z_n  == bv8get ( rgs8 ( f0 ) , 1 ) ;
    z_c  == bv8get ( rgs8 ( f0 ) , 0 )    
    
    
CONCRETE_CONSTANTS
    get_bv_reg16,
    REG16_TO_REG8 ,
    REG8_TO_REG16 ,
    update_flag_reg	,
    cc_get
PROPERTIES
    

    
  
    REG16_TO_REG8 : id_reg_16 +-> ( id_reg_8 * id_reg_8 ) & /* SP is not used in this function */
    REG16_TO_REG8 = %(idf).( idf :  id_reg_16 & idf = BC |( b0 , c0 ))\/
				    %(idf).( idf :  id_reg_16 & idf = DE |( d0 , e0 ))\/
				    %(idf).( idf :  id_reg_16 & idf = HL |( h0 , l0 ))\/
				    %(idf).( idf :  id_reg_16 & idf = AF |( a0 , f0 ))


    &
    
    REG8_TO_REG16 : ( id_reg_8 * id_reg_8 ) +-> id_reg_16 &
    REG8_TO_REG16 = %(idf1,idf2).( idf1 : id_reg_8  & idf2 : id_reg_8 & idf1 = b0 &  idf2 = c0 | BC)\/
   				    %(idf1,idf2).( idf1 : id_reg_8  & idf2 : id_reg_8 & idf1 = d0 &  idf2 = e0 | DE)\/
   				    %(idf1,idf2).( idf1 : id_reg_8  & idf2 : id_reg_8 & idf1 = h0 &  idf2 = l0 | HL)\/
   				    %(idf1,idf2).( idf1 : id_reg_8  & idf2 : id_reg_8 & idf1 = a0 &  idf2 = f0 | AF) &
    
    
    
    /* update_flag_reg : ( BIT * BIT * BIT * BIT * BIT * BIT +-> ({f0} * BYTE) )&   ProB simplification  */
    update_flag_reg = % ( s7 , z6 , h4 , pv2 , n_add_sub , c0 ) .
    ( s7 : BIT & z6  : BIT &   h4 : BIT  & pv2 : BIT & n_add_sub : BIT & c0 : BIT |
        ( f0 |-> [c0, n_add_sub, pv2, 1, h4, 1, z6, s7]) ) &
    
   
   
   
   
    /* cc_get : ( (id_reg_8 --> BYTE) * (0..8) ) +-> BIT &*/
     cc_get = %(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 0 |1 - bv8get ( rgs8_ ( f0 ) , 6 ) )\/
			%(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 1 |    bv8get ( rgs8_ ( f0 ) , 6 ) )\/
		    %(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 2 |1 - bv8get ( rgs8_ ( f0 ) , 0 ) )\/     
			%(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 3 |    bv8get ( rgs8_ ( f0 ) , 0 ) )\/     
			%(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 4 |1 - bv8get ( rgs8_ ( f0 ) , 2 ) )\/ 
		    %(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 5 |    bv8get ( rgs8_ ( f0 ) , 2 ) )\/ 
			%(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 6 |1 - bv8get ( rgs8_ ( f0 ) , 7 ) )\/ 
     		%(rgs8_,ind).( rgs8_ : (id_reg_8 --> BYTE) & ind = 7 |    bv8get ( rgs8_ ( f0 ) , 7 ) ) &
														
														
														
														
		/*get_bv_reg16 : ( BV16 * ( id_reg_8 --> BYTE ) * id_reg_16 ) +-> ( BV16 )	&			*/
		get_bv_reg16 = %(sp_,rgs8_,r1).( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 = BC| byte_bv16 ( rgs8_ ( b0 ) , rgs8_ ( c0 ) ) )\/
		%(sp_,rgs8_,r1).( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 = DE| byte_bv16 ( rgs8_ ( d0 ) , rgs8_ ( e0 ) ))\/
		%(sp_,rgs8_,r1).( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 = HL| byte_bv16 ( rgs8_ ( h0 ) , rgs8_ ( l0 ) ))\/
		%(sp_,rgs8_,r1).( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 = SP| sp_ )\/
		%(sp_,rgs8_,r1).( sp_ :  BV16 & rgs8_ : ( id_reg_8 --> BYTE ) & r1 = AF| byte_bv16 ( rgs8_ ( a0 ) , rgs8_ ( f0 ) ))
																
    
ASSERTIONS

   /* ProB Assertions */
   card(REG16_TO_REG8 ) = 5 &
   card(update_flag_reg ) = 64 &
   
   /* ProB Assertions */
    get_bv_reg16 : ( BV16 * ( id_reg_8 --> BYTE ) * id_reg_16 ) +-> ( BV16 )	&	
    cc_get : ( (id_reg_8 --> BYTE) * (0..8) ) +-> BIT &
    
   /* card ( ushort_uchar ) = 65536 & Prob simplification */
    ran ( mem ) <: BYTE &
    dom ( mem ) = BV16 &
    ran ( rgs8 ) <: BYTE &
    dom ( rgs8 ) = id_reg_8 &
    
    
    instruction_next(pc) : USHORT & 
    
    
    bv_9BC0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9BC0 ) ) : BYTE &
    bv_9DE0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9DE0 ) ) : BYTE &
    bv_9HL0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9HL0 ) ) : BYTE &
    bv_9AF0 : BYTE  & mem ( byte_bv16 ( schar_byte ( 0 ) , bv_9AF0 ) ) : BYTE &
    
    
    bv_9SP0 : BYTE  &
    bv_9IX0 : BYTE  &
    bv_9IY0 : BYTE &
    
    
    update_refresh_reg(r_): BYTE &
    
    
    dom(update_flag_reg) = ( BIT * BIT * BIT  * BIT * BIT * BIT ) &
    ran(update_flag_reg) : POW({f0} * BYTE) &
    
    !(b1,b2,b3,b4,b5,b6).(  b1: BIT & b2: BIT & b3: BIT & b4: BIT & b5: BIT & b6 : BIT   =>
		 update_flag_reg(b1,b2,b3,b4,b5,b6) : {f0} * BYTE ) &
    
    !(xx).(xx: id_reg_8 -->BYTE =>  (rgs8 <+ xx) : id_reg_8 --> BYTE) &
    
    !(xx,xxr).(xx: id_reg_8 & xxr : BYTE =>  rgs8 <+ { xx|->xxr } : id_reg_8 --> BYTE) &
    
    !(xx,xxr,yy,yyr).(xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  not(xx=yy) 
        =>  rgs8 <+ { xx|->xxr,yy|->yyr } : id_reg_8 --> BYTE) &
    
    !(xx,xxr,yy,yyr,zz,zzr).(xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  zz: id_reg_8 & zzr : BYTE &
        not(xx=yy) & not(xx=zz) & not(yy=zz) 
        =>  rgs8 <+ { xx|->xxr,yy|->yyr , zz|->zzr } : id_reg_8 --> BYTE) &
    
    !(xx,xxr,yy,yyr,zz,zzr,vv,vvr).(xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  zz: id_reg_8 & zzr : BYTE &
        vv : id_reg_8 & vvr: BYTE &
        not(xx=yy) & not(xx=zz) & not(xx=vv) &  not(yy=zz) & not(yy=vv) & not(zz=vv) 
        =>  rgs8 <+ { xx|->xxr,yy|->yyr , zz|->zzr ,  vv|->vvr } : id_reg_8 --> BYTE) &
    
    
    !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr).
    (xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  zz: id_reg_8 & zzr : BYTE &
        vv : id_reg_8 & vvr: BYTE & ww : id_reg_8 &  wwr : BYTE & not(xx=yy) & not(xx=zz) &
        not(xx=vv) & not(xx=ww) & not(yy=zz) & not(yy=vv) & not(yy=ww) & not(zz=vv) & not(zz=ww) & not(vv=ww)
        =>  rgs8 <+ { xx|->xxr,yy|->yyr , zz|->zzr ,  vv|->vvr,  ww |-> wwr } : id_reg_8 --> BYTE) &
    
    !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr,aa,aar).
    (xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  zz: id_reg_8 & zzr : BYTE &
        vv : id_reg_8 & vvr: BYTE & ww : id_reg_8 &  wwr : BYTE &  aa : id_reg_8 & aar : BYTE &
        not(xx=yy) & not(xx=zz) & not(xx=vv) & not(xx=ww) & not(xx=aa) & not(yy=zz) & not(yy=vv) & not(yy=ww)
        & not(yy=aa) & not(zz=vv) & not(zz=ww) & not(zz=aa) & not(vv=ww) & not(vv=aa) & not(ww=aa)
        =>  rgs8 <+ { xx|->xxr,yy|->yyr , zz|->zzr ,  vv|->vvr,  ww |-> wwr, aa |-> aar } : id_reg_8 --> BYTE) &
    
    !(xx,xxr,yy,yyr,zz,zzr,vv,vvr,ww,wwr,aa,aar,bb,bbr).
    (xx: id_reg_8 & xxr : BYTE & yy: id_reg_8 & yyr : BYTE &  zz: id_reg_8 & zzr : BYTE &
        vv : id_reg_8 & vvr: BYTE & ww : id_reg_8 &  wwr : BYTE &  aa : id_reg_8 & aar : BYTE & 
        bb: id_reg_8 & bbr : BYTE & not(xx=yy) & not(xx=zz) & not(xx=vv) & not(xx=ww) &
        not(xx=aa) & not(xx=bb) & not(yy=zz)
        & not(yy=vv) & not(yy=ww)  & not(yy=aa) & not(yy=bb) & not(zz=vv) & not(zz=ww) & not(zz=aa) &
        not(zz=bb) & not(vv=ww) & not(vv=aa)& not(vv=bb) & not(ww=aa) & not(ww=bb) & not(aa=bb)
        =>  rgs8 <+ { xx|->xxr,yy|->yyr , zz|->zzr ,  vv|->vvr,  ww |-> wwr, aa |-> aar, bb |-> bbr }
        : id_reg_8 --> BYTE) &  
    
    
    

    
    /**** Define types of contants ussualy used ****/
    
    bv_BC  : BV16 &
    bv_HL : BV16 &
    bv_DE : BV16 &
    bv_AF : BV16 &
    
    bv_9BC0 : BYTE &
    bv_9DE0 : BYTE &
    bv_9HL0 : BYTE &
    bv_9AF0 : BYTE &
    
    bv_9SP0 : BYTE &
    bv_9IX0 : BYTE &
    bv_9IY0 : BYTE &
    
    
    dec_BV16(bv_BC)  : BV16 &
    inc_BV16(bv_BC)  : BV16 &
    
    dec_BV16(bv_DE)  : BV16 &
    inc_BV16(bv_DE)  : BV16 &
    
    inc_BV16(bv_HL)  : BV16 &
    dec_BV16(bv_HL)  : BV16 &
    
    sp_plus_one : BV16 &
    sp_plus_two : BV16 &
    sp_minus_one : BV16 &
    sp_minus_two : BV16 &
    
    z_s  : BIT &
    z_z  : BIT &
    z_00 : BIT &
    z_h  : BIT &
    z_01 : BIT &
    z_p  : BIT &
    z_n  : BIT &
    z_c  : BIT &
    
    
    /**** Define types of contants ussualy often ****/
    
    
    io_ports(rgs8(c0)): BYTE &
    
    dec(rgs8(b0)) : BYTE 
    
    
    
INITIALISATION
    
    rgs8 := { (a0 |-> [1,1,1,1,1,1,1,1]) , (f0 |-> [1,1,1,1,1,1,1,1]) , (f_0 |-> [1,1,1,1,1,1,1,1]) , (a_0 |-> [1,1,1,1,1,1,1,1]) ,
        (b0 |-> [1,1,1,1,1,1,1,1]) , (c0 |-> [1,1,1,1,1,1,1,1]) , (b_0 |-> [1,1,1,1,1,1,1,1]) , (c_0 |-> [1,1,1,1,1,1,1,1]) ,
        (d0 |-> [1,1,1,1,1,1,1,1]) , (e0 |-> [1,1,1,1,1,1,1,1]) , (d_0 |-> [1,1,1,1,1,1,1,1]) , (e_0 |-> [1,1,1,1,1,1,1,1]) ,
        (h0 |-> [1,1,1,1,1,1,1,1]) , (l0 |-> [1,1,1,1,1,1,1,1]) , (h_0 |-> [1,1,1,1,1,1,1,1]) , (l_0 |-> [1,1,1,1,1,1,1,1]) } ||
    
    pc := 0 || sp := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] || ix := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] || iy := [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1] ||
    i_ :=[0,0,0,0,0,0,0,0] || r_  :=[0,0,0,0,0,0,0,0] || 
    io_ports  :: (BYTE --> {[0,0,0,0,0,0,0,0]}) ||
    iff1 :=0  ||  iff2 :=0 ||
    im := (0|->0)
    
OPERATIONS
    
    
    set_pc(value)=
    PRE value : USHORT THEN
        pc:=0
    END;
    
    result <-- get_pc =
    BEGIN
        result := pc
    END;


    /************************************************************************************** 
    ***  			Load 16 bits Group 
    **************************************************************************************/
    
    LD_r_r_ ( rr , rr_ ) =
    PRE rr : id_reg_8 & rr_ : id_reg_8  THEN
        rgs8 ( rr ) := rgs8 ( rr_ ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_r_n_ ( rr , n0 ) =
    PRE rr : id_reg_8 & n0 : SCHAR  THEN
        rgs8 ( rr ) := schar_byte ( n0 ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_r_9HL0 ( rr ) =
    PRE rr : id_reg_8 THEN
        ANY address WHERE address : BV16 &
            address =  byte_bv16 ( rgs8 ( h0 ) , rgs8 ( l0 ) )
        THEN
            rgs8 ( rr ) := mem ( address ) ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    /* Prob Simplification*/
    LD_r_9IX_d0 ( rr , desloc ) =
    PRE rr : id_reg_8 & desloc : SCHAR
    THEN
    rgs8 ( rr ) := mem(ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 )) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_r_9IY_d0 ( rr , desloc ) =
    PRE rr : id_reg_8 & desloc : SCHAR
    THEN
        rgs8 ( rr ) := mem(ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 )) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_9HL0_r ( rr ) =
    PRE rr : id_reg_8 & bv16_ushort( bv_HL) : DATA_R_ADR  THEN
        updateAddressMem ( bv_HL , rgs8 ( rr ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    LD_9IX_d0_r ( desloc , rr ) =
    PRE  desloc : SCHAR & rr : id_reg_8 & (( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) ) : DATA_R_ADR THEN
        updateAddressMem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) , rgs8 ( rr ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9IY_d0_r ( desloc , rr ) =
    PRE  desloc : SCHAR & rr : id_reg_8 & (( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) ) : DATA_R_ADR THEN
        updateAddressMem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) , rgs8 ( rr ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9HL0_n ( n0 ) =
    PRE n0 : SCHAR & bv16_ushort( bv_HL ) : DATA_R_ADR     THEN
        updateAddressMem ( bv_HL , schar_byte ( n0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    /* Prob Simplification*/
    LD_9IX_d0_n ( desloc , n0 ) =
    PRE  desloc : SCHAR & n0 : SCHAR &  (( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) ): DATA_R_ADR THEN
        updateAddressMem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) , schar_byte ( n0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9IY_d0_n ( desloc , n0 ) =
    PRE  desloc : SCHAR & n0 : SCHAR & (( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 )) : DATA_R_ADR THEN
        updateAddressMem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) , schar_byte ( n0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_A_9BC0  =
    BEGIN
        rgs8 ( a0 ) :=  bv_9BC0  ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_A_9DE0  =
    BEGIN
        rgs8 ( a0 ) := bv_9DE0 ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_A_9nn0 ( nn ) =
    PRE nn :  USHORT
    THEN
        rgs8 ( a0 ) := mem ( ushort_bv16 ( nn ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9BC0_A  =
    PRE           bv16_ushort(bv_BC) : DATA_R_ADR
    THEN
        updateAddressMem ( bv_BC , rgs8 ( a0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    LD_9DE0_A  =
    PRE bv16_ushort(bv_DE) : DATA_R_ADR
    THEN
        updateAddressMem ( ( bv_DE ) , rgs8 ( a0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9nn0_A ( nn ) =
    PRE nn : USHORT   &  nn  : DATA_R_ADR
    THEN
        updateAddressMem ( ushort_bv16 ( nn ) , rgs8 ( a0 ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    /************************************************************************************** 
    ***  			Interruption Group 
    **************************************************************************************/
    LD_A_I=
	BEGIN
        rgs8 := rgs8  <+ { a0 |-> i_ ,  update_flag_reg( is_negative(i_ ), is_zero( i_  ), 0 , iff2 , 0, z_c )} ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_A_R=
    BEGIN
        rgs8 := rgs8  <+ { a0 |->r_ ,   update_flag_reg( is_negative( r_ ), is_zero( r_  ), 0 , iff2 , 0, z_c )  } ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_I_A=
    BEGIN
        i_ := rgs8(a0)  ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_R_A=
    BEGIN
        r_ := rgs8(a0)  ||
        pc := instruction_next ( pc ) 
    END;
    
    /************************************************************************************** 
    ***  			Load 16 bits Group 
    **************************************************************************************/
    
    LD_dd_nn ( dd , nn ) =
    PRE dd : id_reg_16 & nn : USHORT  & dd /= AF
    THEN
        IF dd = SP THEN  sp := ushort_bv16 ( nn )
        ELSE
            ANY rh , rl , w1 , w2 WHERE
                rh : id_reg_8 &  rl : id_reg_8 &
                w1 : BYTE & w2 : BYTE &
                (rh , rl) = REG16_TO_REG8 ( dd ) & not(rh = rl) &
                bv16_byte ( ushort_bv16 ( nn ) ) = (w1 , w2)
            THEN
                rgs8 := rgs8 <+ { rh |-> w1 , rl |-> w2 } ||
                pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
            END
        END
    END;
    
    
    LD_IX_nn ( nn ) =
    PRE   nn : USHORT
    THEN
        ix := ushort_bv16 ( nn ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    LD_IY_nn ( nn ) =
    PRE   nn : USHORT
    THEN
        iy := ushort_bv16 ( nn ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_HL_9nn0 ( nn ) =
    PRE   nn : USHORT
    THEN
        rgs8 := rgs8 <+ { h0 |-> mem ( ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) ) , l0 |-> mem ( ushort_bv16 ( nn ) ) } ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_dd_9nn0 ( dd , nn ) =
    PRE dd : id_reg_16 & nn : USHORT  & dd /= AF
    THEN
        r_ := update_refresh_reg(r_) ||
        IF dd = SP THEN
            sp := byte_bv16 ( mem ( ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) ) , mem ( ushort_bv16 ( nn ) ) )
        ELSE
            ANY rh , rl , w1 , w2 WHERE
                rh : id_reg_8 &  rl : id_reg_8 &
                w1 : BYTE & w2 : BYTE &
                (rh , rl) = REG16_TO_REG8 ( dd ) &  not(rh = rl) &
                w1 = mem ( ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) ) &
                w2 = mem ( ushort_bv16 ( nn ) )
            THEN
                rgs8 := rgs8 <+ { rh |-> w1 , rl |-> w2 } ||
                pc := instruction_next ( pc ) 
            END
        END
    END;
    
    
    
    
    LD_IX_9nn0 ( nn ) =
    PRE   nn : USHORT
    THEN
        ix := byte_bv16 ( mem ( ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) ) , mem ( ushort_bv16 ( nn ) ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_IY_9nn0 ( nn ) =
    PRE   nn : USHORT
    THEN
        iy := byte_bv16 ( mem ( ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) ) , mem ( ushort_bv16 ( nn ) ) ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    LD_9nn0_HL ( nn ) =
    PRE   nn : USHORT &
        nn  : DATA_R_ADR &  add16USHORT ( 0 , nn , 1 )  : DATA_R_ADR
    THEN
        updateMem ( { ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) |-> rgs8 ( h0 ) , ushort_bv16 ( nn ) |-> rgs8 ( l0 ) } ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    
    LD_9nn0_dd ( nn , dd ) =
    PRE dd : id_reg_16 &  dd /= AF & nn : USHORT  & 
        nn  : DATA_R_ADR & add16USHORT( 0 , nn , 1 ) : DATA_R_ADR
    THEN
        IF dd = SP
        THEN
            ANY vh , vl WHERE
                vh : BYTE & vl : BYTE &
                bv16_byte ( sp ) = (vh , vl) &
                not(ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) = ushort_bv16 ( nn ))
            THEN
                updateMem ( { ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) |-> vh , ushort_bv16 ( nn ) |-> vl } )
                || r_ := update_refresh_reg(r_)
            END
        ELSE
            ANY rh , rl , w1 , w2 WHERE
                rh : id_reg_8 &  rl : id_reg_8 &
                w1 : SCHAR & w2 : BYTE &
                (rh , rl) = REG16_TO_REG8 ( dd ) &  not(rh = rl) 
            THEN
                updateMem ( { ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) |-> rgs8 ( rh ) , ushort_bv16 ( nn ) |-> rgs8 ( rl ) } ) ||
                pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
            END
        END
    END;
    
    
    
    LD_9nn0_IX ( nn ) =
    PRE   nn : USHORT &  nn  : DATA_R_ADR & add16USHORT ( 0 , nn , 1 )  : DATA_R_ADR THEN
        ANY h_ix , l_ix WHERE
            h_ix : BYTE & l_ix : BYTE &
            (h_ix , l_ix) = bv16_byte ( ix )
        THEN
            updateMem ( { ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) |-> h_ix , ushort_bv16 ( nn ) |-> l_ix } ) ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    LD_9nn0_IY ( nn ) =
    PRE   nn : USHORT &  nn : DATA_R_ADR &  add16USHORT ( 0 , nn , 1 )  : DATA_R_ADR  THEN
        ANY h_iy , l_iy WHERE
            h_iy : BYTE & l_iy : BYTE &
            (h_iy , l_iy) = bv16_byte ( iy ) 
        THEN
            updateMem ( { ushort_bv16 ( add16USHORT ( 0 , nn , 1 ) ) |-> h_iy , ushort_bv16 ( nn ) |-> l_iy } ) ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    LD_SP_HL  =
    BEGIN
        sp := bv_HL ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    LD_SP_IX  =
    BEGIN
        sp := ix ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    LD_SP_IY  =
    BEGIN
        sp := iy ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    
    PUSH_qq ( qq ) =
    PRE  qq : id_reg_16 & qq /= SP 
    THEN
        ANY
            qqh , qql
        WHERE qqh : id_reg_8 & qql : id_reg_8 &
            REG16_TO_REG8 ( qq ) = (qqh , qql) &  not( qqh = qql) &
            { sp_minus_two |-> rgs8 ( qql ) ,
                sp_minus_one |-> rgs8 ( qqh ) } : BV16 --> BYTE
        THEN
            updateStack ( { sp_minus_two |-> rgs8 ( qql ) ,
                    sp_minus_one |-> rgs8 ( qqh ) } ) ||
            sp := sp_minus_two ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    PUSH_IX  =   
    ANY
        wh , wl
    WHERE wh : BYTE & wl : BYTE &
        bv16_byte ( ix ) = (wh , wl) &
        { sp_minus_two |-> wl , sp_minus_one |-> wh } : BV16 +-> BYTE
    THEN
        updateStack ( { sp_minus_two |-> wl ,
                sp_minus_one |-> wh } ) ||
        sp := sp_minus_two ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    PUSH_IY  =
    ANY
        wh , wl
    WHERE wh : BYTE & wl : BYTE &
        bv16_byte ( iy ) = (wh , wl) &
        { sp_minus_two |-> wl , sp_minus_one |-> wh } : BV16 +-> BYTE
    THEN
        updateStack ( { sp_minus_two |-> wl ,
                sp_minus_one |-> wh } ) ||
        sp := sp_minus_two ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    POP_qq ( qq ) =
    PRE  qq : id_reg_16 & qq /= SP
    THEN
        ANY
            qqh , qql
        WHERE qqh : id_reg_8 & qql : id_reg_8 &
            REG16_TO_REG8 ( qq ) = (qqh , qql) &  not( qqh = qql) &
            { qql |-> mem ( sp_plus_two ) , qqh |-> mem ( sp_plus_one ) } : id_reg_8 --> BYTE
        THEN
            rgs8 := rgs8 <+ { qql |-> mem ( sp_plus_two ) , qqh |-> mem ( sp_plus_one ) } ||
            sp := sp_plus_two ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    POP_IX  =
    PRE   sp : BV16 
    THEN
        ANY
            bv16
        WHERE bv16 : BV16  &
            byte_bv16 ( mem ( sp_plus_one ) , mem ( sp_plus_two ) ) = bv16
        THEN
            ix := bv16 ||
            sp := sp_plus_two ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    
    POP_IY  =
    PRE   sp : BV16
    THEN
        ANY
            bv16
        WHERE bv16 : BV16  &
            byte_bv16 ( mem ( sp_plus_one ) , mem ( sp_plus_two ) ) = bv16
        THEN
            iy := bv16 ||
            sp := sp_plus_two ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    EX_DE_HL =
    BEGIN
        rgs8 := rgs8 <+ { d0 |-> rgs8 ( h0 ) , e0 |-> rgs8 ( l0 ) , h0 |-> rgs8 ( d0 ) , l0 |-> rgs8 ( e0 ) } ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    EX_AF_AF_ =
    BEGIN
        rgs8 := rgs8 <+ { a0 |-> rgs8 ( a_0 ) , f0 |-> rgs8 ( f_0 ) , a_0 |-> rgs8 ( a0 ) , f_0 |-> rgs8 ( f0 ) } ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    
    EXX =
    BEGIN
        rgs8 := rgs8 <+ { b0 |-> rgs8 ( b_0 ) , c0 |-> rgs8 ( c_0 ) , d0 |-> rgs8 ( d_0 ) , e0 |-> rgs8 ( e_0 ) , h0 |-> rgs8 ( h_0 ) , l0 |-> rgs8 ( l_0 ) ,
            b_0 |-> rgs8 ( b0 ) , c_0 |-> rgs8 ( c0 ) , d_0 |-> rgs8 ( d0 ) , e_0 |-> rgs8 ( e0 ) , h_0 |-> rgs8 ( h0 ) , l_0 |-> rgs8 ( l0 ) } ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    EX_9SP0_HL =
    PRE
        bv16_ushort( sp_plus_one) : STACK_R_ADR &  bv16_ushort( sp ) : STACK_R_ADR
    THEN
        rgs8 := rgs8 <+ { h0 |-> mem ( sp_plus_one ) , l0 |-> mem ( sp ) } ||
        updateStack ( { sp_plus_one |-> rgs8 ( h0 ) , sp |-> rgs8 ( l0 ) } ) ||
        pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
    END;
    
    
    EX_9SP0_IX =
    PRE 	   bv16_ushort( sp_plus_one) : STACK_R_ADR &  bv16_ushort( sp ) : STACK_R_ADR 
    THEN
        ANY wh , wl
        WHERE wh : BYTE & wl : BYTE &
            bv16_byte ( ix ) = (wh , wl )
        THEN
            ix := byte_bv16 ( mem ( sp_plus_one ) , mem ( sp ) ) ||
            updateStack ( { sp_plus_one |-> wh , sp |-> wl } ) ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    EX_9SP0_IY =
    PRE 	   bv16_ushort( sp_plus_one) : STACK_R_ADR &  bv16_ushort( sp ) : STACK_R_ADR 
    THEN    
        ANY wh , wl
        WHERE wh : BYTE & wl : BYTE &
            bv16_byte ( iy ) = (wh , wl)
        THEN
            iy := byte_bv16 ( mem ( sp_plus_one ) , mem ( sp ) ) ||
            updateStack ( { sp_plus_one |-> wh , sp |-> wl } ) ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    LDI =
    PRE bv16_ushort(bv_DE) : DATA_R_ADR    THEN
        ANY  hvn , lvn , dvn , evn , bvn , cvn
        WHERE
            hvn : BYTE & lvn : BYTE & dvn : BYTE & evn : BYTE & 
            bvn : BYTE & cvn : BYTE & 
            
            (hvn , lvn) = bv16_byte ( inc_BV16 ( bv_HL ) ) &
            (dvn , evn) = bv16_byte ( inc_BV16 ( bv_DE ) ) &
            (bvn , cvn) = bv16_byte ( dec_BV16 ( bv_BC ) )
        THEN
            updateAddressMem ( bv_DE , bv_9HL0 ) ||
            rgs8 :=  rgs8 <+ { ( h0 |-> hvn ) , ( l0 |-> lvn ) ,
                ( d0 |-> dvn ) , ( e0 |-> evn ) ,
                ( b0 |-> bvn ) , ( c0 |-> cvn ) ,
                update_flag_reg( z_s , z_z , 0 , bit_not ( is_zero16USHORT ( bv16_ushort ( dec_BV16(bv_BC)  )  ) ) , 0 , z_c ) } ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    LDIR =
    PRE bv16_ushort(bv_DE) : DATA_R_ADR    THEN
        ANY  hvn , lvn , dvn , evn , bvn , cvn
        WHERE
            hvn : BYTE & lvn : BYTE & dvn : BYTE & evn : BYTE & 
            bvn : BYTE & cvn : BYTE & 
            (hvn , lvn) = bv16_byte ( inc_BV16 ( bv_HL ) ) &
            (dvn , evn) = bv16_byte ( inc_BV16 ( bv_DE ) ) &
            (bvn , cvn) = bv16_byte ( dec_BV16 ( bv_BC ) )
        THEN
            updateAddressMem ( bv_DE , bv_9HL0 ) ||
            rgs8 :=  rgs8 <+ { ( h0 |-> hvn ) , ( l0 |-> lvn ) ,
                ( d0 |-> dvn ) , ( e0 |-> evn ) ,
                ( b0 |-> bvn ) , ( c0 |-> cvn ) ,
                update_flag_reg( z_s , z_z , 0 , 0 , 0 , z_c ) } 
            || r_ := update_refresh_reg(r_) ||
            IF  is_zero16USHORT ( bv16_ushort ( dec_BV16(bv_BC)  )  ) = 0 THEN pc := instruction_next ( pc )  END
        END
    END;
    
    
    LDD =
    PRE bv16_ushort(bv_DE) : DATA_R_ADR    THEN
        ANY  hvn , lvn , dvn , evn , bvn , cvn
        WHERE
            hvn : BYTE & lvn : BYTE & dvn : BYTE & evn : BYTE & 
            bvn : BYTE & cvn : BYTE & 
            (hvn , lvn) = bv16_byte ( dec_BV16 ( bv_HL ) ) &
            (dvn , evn) = bv16_byte ( dec_BV16 ( bv_DE ) ) &
            (bvn , cvn) = bv16_byte ( dec_BV16 ( bv_BC ) )
        THEN
            updateAddressMem ( bv_DE , bv_9HL0 ) ||
            rgs8 :=  rgs8 <+ { ( h0 |-> hvn ) , ( l0 |-> lvn ) ,
                ( d0 |-> dvn ) , ( e0 |-> evn ) ,
                ( b0 |-> bvn ) , ( c0 |-> cvn ) ,
                update_flag_reg( z_s , z_z , 0 , bit_not ( is_zero16USHORT ( bv16_ushort ( dec_BV16(bv_BC)  )  ) ) , 0 , z_c ) } ||
            pc := instruction_next ( pc ) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    LDDR =
    PRE bv16_ushort(bv_DE) : DATA_R_ADR    THEN
        ANY  hvn , lvn , dvn , evn , bvn , cvn
        WHERE
            hvn : BYTE & lvn : BYTE & dvn : BYTE & evn : BYTE & 
            bvn : BYTE & cvn : BYTE &
            (hvn , lvn) = bv16_byte ( dec_BV16 ( bv_HL ) ) &
            (dvn , evn) = bv16_byte ( dec_BV16 ( bv_DE ) ) &
            (bvn , cvn) = bv16_byte ( dec_BV16 ( bv_BC ) )
            
        THEN
            updateAddressMem ( bv_DE , bv_9HL0 ) ||
            rgs8 :=  rgs8 <+ { ( h0 |-> hvn ) , ( l0 |-> lvn ) ,
                ( d0 |-> dvn ) , ( e0 |-> evn ) ,
                ( b0 |-> bvn ) , ( c0 |-> cvn ) ,
                update_flag_reg( z_s , z_z , 0 , 0 , 0 , z_c ) } 
            || r_ := update_refresh_reg(r_) ||
            IF  is_zero16USHORT ( bv16_ushort ( dec_BV16(bv_BC)  )  ) = 0 THEN pc := instruction_next ( pc )  END
            
        END
    END
    
    
    
    
    
    
  









    
    
END
