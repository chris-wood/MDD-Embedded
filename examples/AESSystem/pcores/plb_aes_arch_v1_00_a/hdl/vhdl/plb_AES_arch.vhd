-- 
-- Copyright (c) 2002-2011 by Impulse Accelerated Technologies, Inc.
-- All rights reserved.
-- 
-- This source file may be used and redistributed without charge
-- subject to the provisions of the IMPULSE ACCELERATED TECHNOLOGIES,
-- INC. REDISTRIBUTABLE IP LICENSE AGREEMENT, and provided that this
-- copyright statement is not removed from the file, and that any
-- derivative work contains this copyright notice.
-- 
library ieee;
use ieee.std_logic_1164.all;

library impulse;
use impulse.plb_if.all;

library plb_AES_arch_v1_00_a;
use plb_AES_arch_v1_00_a.all;


entity plb_AES_arch is
  generic (
    C_FAMILY           : string                    := "virtex2";
    C_BASEADDR     : std_logic_vector(0 to 31) := X"FFFFFFFF";
    C_HIGHADDR     : std_logic_vector(0 to 31) := X"00000000";
    C_SPLB_NUM_MASTERS  : integer                   := 8;
    C_SPLB_MID_WIDTH    : integer                   := 3;
    C_SPLB_AWIDTH       : integer                   := 32;
    C_SPLB_DWIDTH       : integer                   := 64  );
  port (
    -- plb ports
    PLB_Clk          : in std_logic;
    PLB_Rst          : in std_logic;
    PLB_abort        : in std_logic;
    PLB_ABus         : in std_logic_vector(0 to C_SPLB_AWIDTH-1);
    PLB_BE           : in std_logic_vector(0 to (C_SPLB_DWIDTH/8)-1);
    PLB_busLock      : in std_logic;
    PLB_TAttribute   : in std_logic_vector(0 to 15);
    PLB_lockErr      : in std_logic;
    PLB_masterID     : in  std_logic_vector(0 to C_SPLB_MID_WIDTH-1);
    PLB_MSize        : in std_logic_vector(0 to 1);
    PLB_PAValid      : in std_logic;
    PLB_RNW          : in std_logic;
    PLB_size         : in std_logic_vector(0 to 3);
    PLB_type         : in std_logic_vector(0 to 2);
    PLB_UABus        : in std_logic_vector(0 to C_SPLB_AWIDTH-1);
    Sl_addrAck       : out std_logic;
    Sl_MBusy         : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_MRdErr        : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_MWrErr        : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    Sl_rearbitrate   : out std_logic;
    Sl_SSize         : out std_logic_vector(0 to 1);
    Sl_wait          : out std_logic;
    Sl_MIRQ          : out std_logic_vector(0 to C_SPLB_NUM_MASTERS-1);
    PLB_rdPrim       : in std_logic;
    PLB_SAValid      : in std_logic;
    PLB_wrPrim       : in std_logic;
    PLB_wrBurst      : in std_logic;
    PLB_wrDBus       : in std_logic_vector(0 to C_SPLB_DWIDTH-1);
    Sl_wrBTerm       : out std_logic;
    Sl_wrComp        : out std_logic;
    Sl_wrDAck        : out std_logic;
    PLB_rdBurst      : in std_logic;
    Sl_rdBTerm       : out std_logic;
    Sl_rdComp        : out std_logic;
    Sl_rdDAck        : out std_logic;
    Sl_rdDBus        : out std_logic_vector(0 to C_SPLB_DWIDTH-1);
    Sl_rdWdAddr      : out std_logic_vector(0 to 3);
    PLB_rdPendReq    : in  std_logic;
    PLB_wrPendReq    : in  std_logic;
    PLB_rdPendPri    : in  std_logic_vector(0 to 1);
    PLB_wrPendPri    : in  std_logic_vector(0 to 1);
    PLB_reqPri       : in  std_logic_vector(0 to 1);
    co_clk : in std_logic
    );
end plb_AES_arch;

architecture impl of plb_AES_arch is
  component AES_arch is
    port (
    reset : in std_ulogic;
    sclk : in std_ulogic;
    clk : in std_ulogic;
    p_Producer_AESdataStream_en : in std_ulogic;
    p_Producer_AESdataStream_eos : in std_ulogic;
    p_Producer_AESdataStream_data : in std_ulogic_vector (7 downto 0);
    p_Producer_AESdataStream_rdy : out std_ulogic;
    p_Consumer_AESoutputStream_en : in std_ulogic;
    p_Consumer_AESoutputStream_data : out std_ulogic_vector (7 downto 0);
    p_Consumer_AESoutputStream_eos : out std_ulogic;
    p_Consumer_AESoutputStream_rdy : out std_ulogic;
    p_Producer_AESinputSignal_en : in std_ulogic;
    p_Producer_AESinputSignal_data : in std_ulogic_vector (31 downto 0)
    );
  end component;

  signal p_Producer_AESdataStream_rdy : std_ulogic;
  signal p_Producer_AESdataStream_en : std_ulogic;
  signal p_Producer_AESdataStream_eos : std_ulogic;
  signal p_Producer_AESdataStream_idata : std_ulogic_vector (7 downto 0);
  signal p_Consumer_AESoutputStream_rdy : std_ulogic;
  signal p_Consumer_AESoutputStream_en : std_ulogic;
  signal p_Consumer_AESoutputStream_eos : std_ulogic;
  signal p_Consumer_AESoutputStream_idata : std_ulogic_vector (7 downto 0);
  signal p_Producer_AESinputSignal_en : std_ulogic;
  signal p_Producer_AESinputSignal_idata : std_ulogic_vector (31 downto 0);

  signal p_Producer_AESdataStream_cs : std_logic;
  signal p_Producer_AESdataStream_odata : std_logic_vector(C_SPLB_DWIDTH-1 downto 0);
  signal p_Consumer_AESoutputStream_cs : std_logic;
  signal p_Consumer_AESoutputStream_odata : std_logic_vector(C_SPLB_DWIDTH-1 downto 0);
  signal p_Producer_AESinputSignal_cs : std_logic;
  signal p_Producer_AESinputSignal_odata : std_logic_vector(C_SPLB_DWIDTH-1 downto 0);

  -- plb4 signals
  signal IP2Plb_data : std_logic_vector (C_SPLB_DWIDTH-1 downto 0);
  signal Plb2IP_Reset : std_logic;
  signal Plb2IP_Clk : std_logic;
  signal Plb2IP_CS : std_logic;
  signal Plb2IP_RdCE : std_logic;
  signal Plb2IP_WrCE : std_logic;
  signal Plb2IP_raddr : std_logic_vector (5 downto 0);
  signal Plb2IP_waddr : std_logic_vector (5 downto 0);
  signal Plb2IP_data : std_logic_vector (C_SPLB_DWIDTH-1 downto 0);
  signal plbsel : std_logic_vector(1 downto 0);
  -- end plb4 signals
begin
  ipif : impulse_plb_ipif
  generic map
  (
    C_BASEADDR, C_HIGHADDR,
    C_SPLB_NUM_MASTERS,
    C_SPLB_MID_WIDTH,
    C_SPLB_AWIDTH,
    C_SPLB_DWIDTH,
    6
  )
  port map
  (
    PLB_Clk,
    PLB_Rst,
    PLB_abort,
    PLB_masterID,
    PLB_PAValid,
    PLB_RNW,
    PLB_ABus,
    PLB_wrDBus,
    Sl_MBusy,
    Sl_MRdErr,
    Sl_MWrErr,
    Sl_rearbitrate,
    Sl_wait,
    Sl_SSize,
    Sl_addrAck,
    Sl_rdBTerm,
    Sl_rdComp,
    Sl_rdDAck,
    Sl_rdWdAddr,
    Sl_rdDBus,
    Sl_wrBTerm,
    Sl_wrComp,
    Sl_wrDAck,
    Sl_MIRQ,
    IP2Plb_data,
    Plb2IP_Reset,
    Plb2IP_Clk,
    Plb2IP_CS,
    Plb2IP_RdCE,
    Plb2IP_WrCE,
    Plb2IP_raddr,
    Plb2IP_waddr,
    Plb2IP_data
  );

  p_Producer_AESdataStream_cs <=
    '1' when Plb2IP_raddr(5 downto 4) = "00" and Plb2IP_RdCE = '1' else
    '1' when Plb2IP_waddr(5 downto 4) = "00" and Plb2IP_WrCE = '1' else
    '0';

  p_Producer_AESdataStream_if: plb_to_stream
    generic map (
      C_SPLB_DWIDTH => C_SPLB_DWIDTH,
      datawidth => 8
    )
    port map (
      clk => Plb2IP_Clk,
      plb_raddr => Plb2IP_raddr(3 downto 3),
      plb_waddr => Plb2IP_waddr(3 downto 3),
      plb_ce => p_Producer_AESdataStream_cs,
      plb_read => Plb2IP_RdCe,
      plb_reset => Plb2IP_Reset,
      plb_write => Plb2IP_WrCe,
      plb_wdata => Plb2IP_Data,
      plb_rdata => p_Producer_AESdataStream_odata,
      stream_en => p_Producer_AESdataStream_en,
      stream_rdy => p_Producer_AESdataStream_rdy,
      stream_eos => p_Producer_AESdataStream_eos,
      stream_data => p_Producer_AESdataStream_idata
    );

  p_Consumer_AESoutputStream_cs <=
    '1' when Plb2IP_raddr(5 downto 4) = "01" and Plb2IP_RdCE = '1' else
    '1' when Plb2IP_waddr(5 downto 4) = "01" and Plb2IP_WrCE = '1' else
    '0';

  p_Consumer_AESoutputStream_if: stream_to_plb
    generic map (
      C_SPLB_DWIDTH => C_SPLB_DWIDTH,
      datawidth => 8
    )
    port map (
      clk => Plb2IP_Clk,
      plb_raddr => Plb2IP_raddr(3 downto 3),
      plb_waddr => Plb2IP_waddr(3 downto 3),
      plb_ce => p_Consumer_AESoutputStream_cs,
      plb_read => Plb2IP_RdCe,
      plb_reset => Plb2IP_Reset,
      plb_write => Plb2IP_WrCe,
      plb_wdata => Plb2IP_Data,
      plb_rdata => p_Consumer_AESoutputStream_odata,
      stream_en => p_Consumer_AESoutputStream_en,
      stream_rdy => p_Consumer_AESoutputStream_rdy,
      stream_eos => p_Consumer_AESoutputStream_eos,
      stream_data => p_Consumer_AESoutputStream_idata
    );

  p_Producer_AESinputSignal_cs <=
    '1' when Plb2IP_raddr(5 downto 4) = "10" and Plb2IP_RdCE = '1' else
    '1' when Plb2IP_waddr(5 downto 4) = "10" and Plb2IP_WrCE = '1' else
    '0';

  p_Producer_AESinputSignal_if: plb_to_signal
    generic map (
      C_SPLB_DWIDTH => C_SPLB_DWIDTH,
      datawidth => 32
    )
    port map (
      clk => Plb2IP_Clk,
      plb_raddr => Plb2IP_raddr(3 downto 3),
      plb_waddr => Plb2IP_waddr(3 downto 3),
      plb_ce => p_Producer_AESinputSignal_cs,
      plb_read => Plb2IP_RdCe,
      plb_reset => Plb2IP_Reset,
      plb_write => Plb2IP_WrCe,
      plb_wdata => Plb2IP_Data,
      plb_rdata => p_Producer_AESinputSignal_odata,
      signal_en => p_Producer_AESinputSignal_en,
      signal_data => p_Producer_AESinputSignal_idata
    );

  plbsel <= Plb2IP_raddr(5 downto 4);

  plb4_mux: process (p_Producer_AESdataStream_odata,p_Consumer_AESoutputStream_odata,p_Producer_AESinputSignal_odata,plbsel) is
  begin
    case plbsel is
      when "00"  => IP2Plb_Data <= p_Producer_AESdataStream_odata;
      when "01"  => IP2Plb_Data <= p_Consumer_AESoutputStream_odata;
      when "10"  => IP2Plb_Data <= p_Producer_AESinputSignal_odata;
      when others => IP2Plb_Data <= (others => 'X');
    end case;
  end process plb4_mux;

  AES_arch_0: AES_arch
    port map (
      PLB_Rst,
      PLB_Clk,
      co_clk,
      p_Producer_AESdataStream_en,
      p_Producer_AESdataStream_eos,
      p_Producer_AESdataStream_idata,
      p_Producer_AESdataStream_rdy,
      p_Consumer_AESoutputStream_en,
      p_Consumer_AESoutputStream_idata,
      p_Consumer_AESoutputStream_eos,
      p_Consumer_AESoutputStream_rdy,
      p_Producer_AESinputSignal_en,
      p_Producer_AESinputSignal_idata);

end;

