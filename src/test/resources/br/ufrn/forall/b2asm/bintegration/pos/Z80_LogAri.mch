/* Z80_LogAri
 * Author: valerio
 * Creation date: sáb abr 28 2012
 */
MACHINE
    Z80_LogAri
    
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
    /************************************************************************************** 
    ***  			Arithmetic and Logic Group 
    **************************************************************************************/
    
    AND_A_r(rr)=   
    PRE rr : id_reg_8  
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT 
            & pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_and(  rgs8(a0),rgs8(rr) ) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0       
        THEN     											
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    AND_A_n(n1)=   
    PRE n1 : SCHAR 
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_and( rgs8(a0), schar_byte( n1 )) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN     									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    AND_A_9HL0=   
    ANY 
        result  , negative , zero , half_carry , pv , add_sub , carry 
    WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
        pv : BIT & add_sub : BIT & carry : BIT &  
        result = bv8_and(  rgs8(a0),  bv_9HL0 ) &
        negative = is_negative(result) &
        zero = is_zero(result)  & 
        half_carry = 0 &         
        pv =   parity_even(result)      &
        add_sub =  0 &
        carry = 0    
    THEN       									
        rgs8:= rgs8 <+ { a0|-> result, 
            update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
    END  ;
    
    /* ProB simplification */
    AND_A_9IX_d0(desloc)=
    PRE desloc : SCHAR THEN   
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &
            result = bv8_and(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    AND_A_9IY_d0(desloc)=   
    PRE desloc : SCHAR THEN   
        
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &
            result = bv8_and(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    
    OR_A_r(rr)=   
    PRE rr : id_reg_8  
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT 
            & pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_or(rgs8(a0),rgs8(rr) ) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0       
            
        THEN     											
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    OR_A_n(n1)=   
    PRE n1 : SCHAR 
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT 
            & pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_or( rgs8(a0), schar_byte( n1 )) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN     									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    OR_A_9HL0=   
    ANY 
        result  , negative , zero , half_carry , pv , add_sub , carry 
    WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
        pv : BIT & add_sub : BIT & carry : BIT &
        result = bv8_or(  rgs8(a0),  bv_9HL0 ) &
        negative = is_negative(result) &
        zero = is_zero(result)  & 
        half_carry = 0 &         
        pv =   parity_even(result)      &
        add_sub =  0 &
        carry = 0    
    THEN       									
        rgs8:= rgs8 <+ { a0|-> result, 
            update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
    END;
    
    /* Prob Simplification */
    OR_A_9IX_d0(desloc)=
    PRE desloc : SCHAR THEN   
        
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
        pv : BIT & add_sub : BIT & carry : BIT &
            result = bv8_or(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    OR_A_9IY_d0(desloc)=   
    PRE desloc : SCHAR THEN   
        
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &
            result = bv8_or(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    XOR_A_r(rr)=   
    PRE rr : id_reg_8  
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_xor(rgs8(a0),rgs8(rr) ) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0       
            
        THEN     											
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    XOR_A_n(n1)=   
    PRE n1 : SCHAR 
    THEN  
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT 
            & pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_xor( rgs8(a0), schar_byte( n1 )) &
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN     									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    XOR_A_9HL0=   
    ANY 
        result  , negative , zero , half_carry , pv , add_sub , carry 
    WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
        pv : BIT & add_sub : BIT & carry : BIT &  
        result = bv8_xor(  rgs8(a0),  bv_9HL0 ) &
        negative = is_negative(result) &
        zero = is_zero(result)  & 
        half_carry = 0 &         
        pv =   parity_even(result)      &
        add_sub =  0 &
        carry = 0    
    THEN       									
        rgs8:= rgs8 <+ { a0|-> result, 
            update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
    END;
    
    /* ProB simplification */
    XOR_A_9IX_d0(desloc)=
    PRE desloc : SCHAR THEN   
        
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_xor(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    XOR_A_9IY_d0(desloc)=   
    PRE desloc : SCHAR THEN   
        
        ANY 
            result  , negative , zero , half_carry , pv , add_sub , carry 
        WHERE  result : BYTE & negative : BIT & zero : BIT & half_carry : BIT &
            pv : BIT & add_sub : BIT & carry : BIT &  
            result = bv8_xor(  rgs8(a0), mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) ) ) &  
            negative = is_negative(result) &
            zero = is_zero(result)  & 
            half_carry = 0 &         
            pv =   parity_even(result)      &
            add_sub =  0 &
            carry = 0    
        THEN       									
            rgs8:= rgs8 <+ { a0|-> result, 
                update_flag_reg( negative,zero, half_carry,pv,add_sub, carry)   } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END 
    END;
    
    
    CP_A_r(rr)=   
    PRE rr : id_reg_8  
    THEN  
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &(sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(rgs8(a0)),byte_uchar(rgs8(rr)))
        THEN  
            rgs8:= rgs8 <+ { update_flag_reg( negative,zero, half_carry,carry,1, carry)  } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    CP_A_n(n1)=   
    PRE n1 : SCHAR  
    THEN  
        ANY 
            sum, negative, carry, half_carry, zero
            
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &(sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(rgs8(a0)), schar_uchar( n1) )
        THEN  
            rgs8:= rgs8 <+ {  update_flag_reg( negative,zero, half_carry,carry,1, carry)  } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    CP_A_9HL0=   
    ANY 
        sum, negative, carry, half_carry, zero
    WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &(sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(rgs8(a0)),byte_uchar(bv_9HL0))
    THEN  
        rgs8:= rgs8 <+ {  update_flag_reg( negative,zero, half_carry,carry,1, carry)  } || 
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
    END;
    /* Prob simplification */
    CP_A_9IX_d0(desloc)=   
    PRE desloc : SCHAR THEN
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(rgs8(a0)),byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) )))
        THEN  
            rgs8:= rgs8 <+ {  update_flag_reg( negative,zero, half_carry,carry,1, carry)  } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    CP_A_9IY_d0(desloc)=  
    PRE desloc : SCHAR THEN
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(rgs8(a0)),byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) )))
        THEN  
            rgs8:= rgs8 <+ {  update_flag_reg( negative,zero, half_carry,carry,1, carry)  } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_) 
        END  
    END;
    
    
    INC_r(rr) =
    PRE 
        rr : id_reg_8 & rr /= f0
    THEN
        ANY 
            sum, negative, carry, half_carry, zero
            
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            
            (sum, negative, carry, half_carry, zero) = add8UCHAR(0,byte_uchar( rgs8(rr)), 1)
        THEN 
            rgs8 := rgs8 <+ {(rr |-> uchar_byte(sum) ),
                update_flag_reg( negative,zero, half_carry,carry,0, carry) } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    INC_9HL0 =
    PRE bv16_ushort(bv_HL) : DATA_R_ADR    THEN
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &          
            (sum, negative, carry, half_carry, zero) = add8UCHAR(0,byte_uchar(bv_9HL0),1)
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,0, carry) } ||
            updateAddressMem( bv_HL , uchar_byte(sum) )||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    /* Prob simplification */
    INC_9IX_d0(desloc) =
    PRE desloc : SCHAR  & (( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 )) : DATA_R_ADR THEN
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &            
            (sum, negative, carry, half_carry, zero) = add8UCHAR(0,byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) )),1)
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,0, carry) } ||
            updateAddressMem(ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ), uchar_byte(sum)) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    INC_9IY_d0(desloc) =
    PRE desloc : SCHAR & (( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 )) : DATA_R_ADR  THEN 
        ANY 
            sum, negative, carry, half_carry, zero
            
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &         
            (sum, negative, carry, half_carry, zero) = add8UCHAR(0,byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) )),1)
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,0, carry) } ||
            updateAddressMem(ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ), uchar_byte(sum)) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    DEC_r(rr) =
    PRE 
        rr : id_reg_8 & rr /= f0
    THEN
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &         
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar( rgs8(rr)), 1)
        THEN 
            rgs8 := rgs8 <+ {(rr |-> uchar_byte(sum) ),
                update_flag_reg( negative,zero, half_carry,carry,1, z_c) } || 
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    DEC_9HL0 =
    PRE bv16_ushort(bv_HL) : DATA_R_ADR  THEN 
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &      
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(bv_9HL0),1)
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,1, z_c) } ||
            updateAddressMem( bv_HL , uchar_byte(sum) )||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    
    DEC_9IX_d0(desloc) =
    PRE desloc : SCHAR & (( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 )) : DATA_R_ADR  THEN 
        ANY 
            sum, negative, carry, half_carry, zero
            
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ) )),1)
            
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,1, z_c) } ||
            updateAddressMem(ushort_bv16 ( (bv16_ushort ( ix ) + desloc + pow2_16 ) mod pow2_16 ), uchar_byte(sum)) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    DEC_9IY_d0(desloc) =
    PRE desloc : SCHAR & (( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 )) : DATA_R_ADR  THEN 
        ANY 
            sum, negative, carry, half_carry, zero
        WHERE  sum : UCHAR & negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            (sum, negative, carry, half_carry, zero) = substract8UCHAR(0,byte_uchar(mem ( ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ) )),1)
        THEN 
            rgs8 := rgs8 <+ {update_flag_reg( negative,zero, half_carry,carry,1, z_c) } ||
            updateAddressMem(ushort_bv16 ( (bv16_ushort ( iy ) + desloc + pow2_16 ) mod pow2_16 ), uchar_byte(sum)) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
  /* Prob Simplification */
  ADD_HL_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN      
        ANY result, bv_value, bvh, bvl,
            negative, carry, half_carry, zero
        WHERE 
            result : USHORT & bv_value : BV16  &  bvh : BYTE &   bvl : BYTE &
            negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            get_bv_reg16(sp,rgs8,ss) = bv_value &
            result = add16USHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value ) ) &
            (bvh,bvl) = bv16_byte(ushort_bv16(result))&
            negative = z_s &
            zero = z_z &
            half_carry = add_halfcarryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  ) &
            carry =  add_carryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  )
        THEN
            rgs8 := rgs8 <+ { h0|-> bvh,  l0|-> bvl ,
                update_flag_reg( negative,zero, half_carry,z_p ,0, carry) } ||
            
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    ADC_HL_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        ANY result, bv_value, bvh, bvl,
            negative, carry, half_carry, zero
            
        WHERE 
            result : USHORT & bv_value : BV16  &  bvh : BYTE &   bvl : BYTE &
            negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            
            get_bv_reg16(sp,rgs8,ss) = bv_value &
            
            result = add16USHORT(z_c , bv16_ushort( bv_HL) , bv16_ushort( bv_value )) &
            negative = 1 &
            zero = is_zero16USHORT(result) &
            half_carry = add_halfcarryUSHORT(z_c , bv16_ushort( bv_HL) , bv16_ushort( bv_value )  ) &
            carry =  add_carryUSHORT(z_c , bv16_ushort( bv_HL) , bv16_ushort( bv_value ) )
            
        THEN
            rgs8 := rgs8 <+ { h0|-> bvh,  l0|-> bvl ,
                update_flag_reg( negative,zero, half_carry, carry ,0, carry) } ||
            
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    
    
    
    SBC_HL_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        
        ANY result, bv_value, bvh, bvl,
            negative, carry, half_carry, zero
            
        WHERE 
            result : USHORT & bv_value : BV16  &  bvh : BYTE &   bvl : BYTE &
            negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &            
            get_bv_reg16(sp,rgs8,ss) = bv_value &
            result = sub16USHORT(z_c, bv16_ushort( bv_HL) , bv16_ushort( bv_value )) &
            negative = 1 &
            zero = is_zero16USHORT(result) &
            half_carry = sub_halfcarryUSHORT(z_c, bv16_ushort( bv_HL) , bv16_ushort( bv_value ) ) &
            carry =  sub_carryUSHORT(z_c, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  )
            
        THEN
            rgs8 := rgs8 <+ { h0|-> bvh,  l0|-> bvl ,
                update_flag_reg( negative,zero, half_carry, carry ,0, carry) } ||
            
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    ADD_IX_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        
        ANY result, bv_value, bvh, bvl,
            negative, carry, half_carry, zero
            
        WHERE 
            
            result : USHORT & bv_value : BV16  &  bvh : BYTE &   bvl : BYTE &
            negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            
            get_bv_reg16(sp,rgs8,ss) = bv_value &
            
            result = add16USHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value ) ) &
            (bvh,bvl) = bv16_byte(ushort_bv16(result))&
            negative = z_s &
            zero = z_z &
            half_carry = add_halfcarryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  ) &
            carry =  add_carryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  )
            
        THEN
            rgs8 := rgs8 <+ { update_flag_reg( negative,zero, half_carry,z_p ,0, carry) } ||
            ix :=  ushort_bv16(result) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    ADD_IY_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        
        ANY result, bv_value, bvh, bvl,
            negative, carry, half_carry, zero
        WHERE 
            result : USHORT & bv_value : BV16  &  bvh : BYTE &   bvl : BYTE &
            negative : BIT & carry : BIT & half_carry : BIT & zero : BIT &
            
            get_bv_reg16(sp,rgs8,ss) = bv_value &
            
            result = add16USHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value ) ) &
            (bvh,bvl) = bv16_byte(ushort_bv16(result))&
            negative = z_s &
            zero = z_z &
            half_carry = add_halfcarryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  ) &
            carry =  add_carryUSHORT(0, bv16_ushort( bv_HL) , bv16_ushort( bv_value )  )
            
        THEN
            rgs8 := rgs8 <+ { update_flag_reg( negative,zero, half_carry,z_p ,0, carry) } ||
            iy :=  ushort_bv16(result) ||
            pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        END
    END;
    
    
    INC_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        
        IF ss = SP THEN sp:= inc_BV16(sp)
        ELSE 
            ANY
                rh,rl, vh,vl
            WHERE rh : id_reg_8 & rl : id_reg_8 & vh : BYTE &  vl : BYTE &
                REG16_TO_REG8(ss)= (rh, rl) & not( rh = rl) &
                bv16_byte( inc_BV16( byte_bv16( rgs8(rh),rgs8(rl) ))) = (vh,vl)
            THEN
                rgs8 := rgs8<+ { rh|-> vh , rl|-> vl }
            END
        END
        ||		pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
        
    END;
    
    
    INC_IX=
    BEGIN
        ix := inc_BV16(ix)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    INC_IY=
    BEGIN
        iy := inc_BV16(iy)||
        pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    DEC_ss(ss)=
    PRE ss : id_reg_16 & not(ss = AF) THEN
        
        IF ss = SP THEN sp:= inc_BV16(sp)
        ELSE 
            ANY
                rh,rl, vh,vl
            WHERE rh : id_reg_8 & rl : id_reg_8 & vh : BYTE &  vl : BYTE &
                REG16_TO_REG8(ss)= (rh, rl) & not( rh = rl) &
                bv16_byte( dec_BV16( byte_bv16( rgs8(rh),rgs8(rl) ))) = (vh,vl)
            THEN
                rgs8 := rgs8<+ { rh|-> vh , rl|-> vl }	||		pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
            END
        END
        
    END;
    
    
    DEC_IX=
    BEGIN
        ix := dec_BV16(ix)	||		pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END;
    
    
    DEC_IY=
    BEGIN
        ix := dec_BV16(ix)	||		pc := instruction_next(pc) || r_ := update_refresh_reg(r_)
    END 
    
  

END
