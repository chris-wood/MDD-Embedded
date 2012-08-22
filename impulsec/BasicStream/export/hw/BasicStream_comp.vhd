-- ****************************************
-- DO NOT EDIT
-- This file was automatically generated by the Impulse C Compiler.
-- 
-- Impulse C is Copyright 2002-2009, Impulse Accelerated Technologies, Inc.
-- 
-- Stage Master is Copyright 2002-2009, Green Mountain Computing Systems, Inc.
-- 
-- All rights reserved.
-- 
-- ****************************************


-- TARGET: VHDL
    
library ieee;
use ieee.std_logic_1164.all;

package external_components is
end package;
library ieee;
use ieee.std_logic_1164.all;

library impulse;
use impulse.components.all;
    
entity HWproc is
  port (signal reset : in std_ulogic;
    signal sclk : in std_ulogic;
    signal clk : in std_ulogic;
    signal p_HWinput_rdy : in std_ulogic;
    signal p_HWinput_en : inout std_ulogic;
    signal p_HWinput_eos : in std_ulogic;
    signal p_HWinput_data : in std_ulogic_vector (0 downto 0);
    signal p_HWoutput_rdy : in std_ulogic;
    signal p_HWoutput_en : inout std_ulogic;
    signal p_HWoutput_eos : out std_ulogic;
    signal p_HWoutput_data : out std_ulogic_vector (0 downto 0));
end HWproc;

use work.external_components.all;
architecture rtl of HWproc is
  function mkvec(b : in std_ulogic) return std_ulogic_vector is
    variable res : std_ulogic_vector(0 downto 0);
  begin
    res(0):=b;
    return(res);
  end;

  type stateType is (init, b0s0, b1s0, b1s1, b2s0, b3s0, finished);
  signal thisState : stateType;
  signal nextState : stateType;
  signal stateEn : std_ulogic;
  signal newState : std_ulogic;
  signal r_HWinput : std_ulogic_vector (0 downto 0);
  signal r_nSample : std_ulogic_vector (0 downto 0);
  signal ni88_nSample : std_ulogic_vector (0 downto 0);
  signal ni89_nSample : std_ulogic_vector (0 downto 0);
  signal r_suif_tmp : std_ulogic_vector (31 downto 0);
  signal ni87_suif_tmp : std_ulogic_vector (31 downto 0);
  signal s_b1s0_en : std_ulogic;
  signal s_b1s1_en : std_ulogic;
  signal s_b2s0_en : std_ulogic;
begin
  process (clk,reset)
  begin
    if (reset='1') then
     thisState <= init;
    elsif (clk'event and clk='1') then
      if (stateEn = '1') then
        thisState <= nextState;
      end if;
    end if;
  end process;

  s_b1s0_en <= p_HWinput_rdy;
  s_b1s1_en <= p_HWoutput_rdy;
  s_b2s0_en <= p_HWinput_eos and p_HWoutput_rdy;
  stateEn <= 
    '0' when thisState = b1s0 and s_b1s0_en = '0' else
    '0' when thisState = b1s1 and s_b1s1_en = '0' else
    '0' when thisState = b2s0 and s_b2s0_en = '0' else
    '1';

  process (ni87_suif_tmp,thisState)
  begin
    case thisState is
    when init =>
      nextState <= b0s0;
    when b0s0 =>
      nextState <= b1s0;
    when b1s0 =>
      if ((not ni87_suif_tmp(0)) = '1') then
        nextState <= b2s0;
      else
        nextState <= b1s1;
      end if;
    when b1s1 =>
      nextState <= b1s0;
    when b2s0 =>
      nextState <= b0s0;
    when b3s0 =>
      nextState <= finished;
    when finished =>
      nextState <= finished;
    when others =>
      nextState <= init;
    end case;
  end process;

  process (clk,reset)
  begin
    if (reset='1') then
     newState <= '1';
    elsif (clk'event and clk='1') then
      newState <= stateEn;
    end if;
  end process;

-- b0s0

-- b1s0
  ni87_suif_tmp <= "0000000000000000000000000000000" & eq("0" & mkvec(p_HWinput_eos), "00");

-- b1s1
  ni88_nSample <= r_HWinput;
  ni89_nSample <= not ni88_nSample;

-- b2s0

-- b3s0

-- 


  process (clk)
  begin
    if (clk'event and clk='1') then
      case thisState is
      when b1s0 =>
        if (stateEn = '1') then
          r_suif_tmp <= ni87_suif_tmp;
        end if;
      when others =>
      end case;
    end if;
  end process;

  process (clk)
  begin
    if (clk'event and clk='1') then
      case thisState is
      when b1s1 =>
        if (stateEn = '1') then
          r_nSample <= ni89_nSample;
        end if;
      when others =>
      end case;
    end if;
  end process;

-- "HWinput" interface signals
  process (clk)
  begin
    if (clk'event and clk='1') then
      if ((p_HWinput_en and p_HWinput_rdy) = '1') then
        r_HWinput <= p_HWinput_data;
      end if;
    end if;
  end process;

  p_HWinput_en <= 
    s_b1s0_en and not p_HWinput_eos when thisState = b1s0 else
    s_b2s0_en or not p_HWinput_eos when thisState = b2s0 else
    '0';

-- "HWoutput" interface signals
  p_HWoutput_en <= 
    s_b1s1_en when thisState = b1s1 else
    s_b2s0_en when thisState = b2s0 else
    '0';
  p_HWoutput_data <= ni89_nSample;
  p_HWoutput_eos <= 
    '1' when thisState = b2s0 else
    '0';

end rtl;
