-------------------------------------------------------------------------------
-- plb_bubblesort_arch_1_wrapper.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

library plb_BubbleSort_arch_v1_00_a;
use plb_BubbleSort_arch_v1_00_a.all;

entity plb_bubblesort_arch_1_wrapper is
  port (
    PLB_Rst : in std_logic;
    PLB_abort : in std_logic;
    PLB_Clk : in std_logic;
    PLB_ABus : in std_logic_vector(0 to 31);
    PLB_BE : in std_logic_vector(0 to 15);
    PLB_busLock : in std_logic;
    PLB_TAttribute : in std_logic_vector(0 to 15);
    PLB_lockErr : in std_logic;
    PLB_masterID : in std_logic_vector(0 to 0);
    PLB_MSize : in std_logic_vector(0 to 1);
    PLB_PAValid : in std_logic;
    PLB_RNW : in std_logic;
    PLB_size : in std_logic_vector(0 to 3);
    PLB_type : in std_logic_vector(0 to 2);
    PLB_UABus : in std_logic_vector(0 to 31);
    Sl_addrAck : out std_logic;
    Sl_MBusy : out std_logic_vector(0 to 0);
    Sl_MRdErr : out std_logic_vector(0 to 0);
    Sl_MWrErr : out std_logic_vector(0 to 0);
    Sl_rearbitrate : out std_logic;
    Sl_SSize : out std_logic_vector(0 to 1);
    Sl_wait : out std_logic;
    Sl_MIRQ : out std_logic_vector(0 to 0);
    PLB_rdPrim : in std_logic;
    PLB_SAValid : in std_logic;
    PLB_wrPrim : in std_logic;
    PLB_wrBurst : in std_logic;
    PLB_wrDBus : in std_logic_vector(0 to 127);
    Sl_wrBTerm : out std_logic;
    Sl_wrComp : out std_logic;
    Sl_wrDAck : out std_logic;
    PLB_rdBurst : in std_logic;
    Sl_rdBTerm : out std_logic;
    Sl_rdComp : out std_logic;
    Sl_rdDAck : out std_logic;
    Sl_rdDBus : out std_logic_vector(0 to 127);
    Sl_rdWdAddr : out std_logic_vector(0 to 3);
    PLB_rdPendReq : in std_logic;
    PLB_wrPendReq : in std_logic;
    PLB_rdPendPri : in std_logic_vector(0 to 1);
    PLB_wrPendPri : in std_logic_vector(0 to 1);
    PLB_reqPri : in std_logic_vector(0 to 1)
  );
end plb_bubblesort_arch_1_wrapper;

architecture STRUCTURE of plb_bubblesort_arch_1_wrapper is

  component plb_bubblesort_arch is
    generic (
      c_family : string;
      c_baseaddr : std_logic_vector;
      c_highaddr : std_logic_vector;
      C_SPLB_NUM_MASTERS : INTEGER;
      C_SPLB_MID_WIDTH : INTEGER;
      C_SPLB_AWIDTH : integer;
      C_SPLB_DWIDTH : integer
    );
    port (
      PLB_Rst : in std_logic;
      PLB_abort : in std_logic;
      PLB_Clk : in std_logic;
      PLB_ABus : in std_logic_vector(0 to (C_SPLB_AWIDTH-1));
      PLB_BE : in std_logic_vector(0 to ((C_SPLB_DWIDTH/8)-1));
      PLB_busLock : in std_logic;
      PLB_TAttribute : in std_logic_vector(0 to 15);
      PLB_lockErr : in std_logic;
      PLB_masterID : in std_logic_vector(0 to (C_SPLB_MID_WIDTH-1));
      PLB_MSize : in std_logic_vector(0 to 1);
      PLB_PAValid : in std_logic;
      PLB_RNW : in std_logic;
      PLB_size : in std_logic_vector(0 to 3);
      PLB_type : in std_logic_vector(0 to 2);
      PLB_UABus : in std_logic_vector(0 to 31);
      Sl_addrAck : out std_logic;
      Sl_MBusy : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MRdErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_MWrErr : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      Sl_rearbitrate : out std_logic;
      Sl_SSize : out std_logic_vector(0 to 1);
      Sl_wait : out std_logic;
      Sl_MIRQ : out std_logic_vector(0 to (C_SPLB_NUM_MASTERS-1));
      PLB_rdPrim : in std_logic;
      PLB_SAValid : in std_logic;
      PLB_wrPrim : in std_logic;
      PLB_wrBurst : in std_logic;
      PLB_wrDBus : in std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      Sl_wrBTerm : out std_logic;
      Sl_wrComp : out std_logic;
      Sl_wrDAck : out std_logic;
      PLB_rdBurst : in std_logic;
      Sl_rdBTerm : out std_logic;
      Sl_rdComp : out std_logic;
      Sl_rdDAck : out std_logic;
      Sl_rdDBus : out std_logic_vector(0 to (C_SPLB_DWIDTH-1));
      Sl_rdWdAddr : out std_logic_vector(0 to 3);
      PLB_rdPendReq : in std_logic;
      PLB_wrPendReq : in std_logic;
      PLB_rdPendPri : in std_logic_vector(0 to 1);
      PLB_wrPendPri : in std_logic_vector(0 to 1);
      PLB_reqPri : in std_logic_vector(0 to 1)
    );
  end component;

begin

  plb_bubblesort_arch_1 : plb_bubblesort_arch
    generic map (
      c_family => "virtex5",
      c_baseaddr => X"c4060000",
      c_highaddr => X"c406ffff",
      C_SPLB_NUM_MASTERS => 1,
      C_SPLB_MID_WIDTH => 1,
      C_SPLB_AWIDTH => 32,
      C_SPLB_DWIDTH => 128
    )
    port map (
      PLB_Rst => PLB_Rst,
      PLB_abort => PLB_abort,
      PLB_Clk => PLB_Clk,
      PLB_ABus => PLB_ABus,
      PLB_BE => PLB_BE,
      PLB_busLock => PLB_busLock,
      PLB_TAttribute => PLB_TAttribute,
      PLB_lockErr => PLB_lockErr,
      PLB_masterID => PLB_masterID,
      PLB_MSize => PLB_MSize,
      PLB_PAValid => PLB_PAValid,
      PLB_RNW => PLB_RNW,
      PLB_size => PLB_size,
      PLB_type => PLB_type,
      PLB_UABus => PLB_UABus,
      Sl_addrAck => Sl_addrAck,
      Sl_MBusy => Sl_MBusy,
      Sl_MRdErr => Sl_MRdErr,
      Sl_MWrErr => Sl_MWrErr,
      Sl_rearbitrate => Sl_rearbitrate,
      Sl_SSize => Sl_SSize,
      Sl_wait => Sl_wait,
      Sl_MIRQ => Sl_MIRQ,
      PLB_rdPrim => PLB_rdPrim,
      PLB_SAValid => PLB_SAValid,
      PLB_wrPrim => PLB_wrPrim,
      PLB_wrBurst => PLB_wrBurst,
      PLB_wrDBus => PLB_wrDBus,
      Sl_wrBTerm => Sl_wrBTerm,
      Sl_wrComp => Sl_wrComp,
      Sl_wrDAck => Sl_wrDAck,
      PLB_rdBurst => PLB_rdBurst,
      Sl_rdBTerm => Sl_rdBTerm,
      Sl_rdComp => Sl_rdComp,
      Sl_rdDAck => Sl_rdDAck,
      Sl_rdDBus => Sl_rdDBus,
      Sl_rdWdAddr => Sl_rdWdAddr,
      PLB_rdPendReq => PLB_rdPendReq,
      PLB_wrPendReq => PLB_wrPendReq,
      PLB_rdPendPri => PLB_rdPendPri,
      PLB_wrPendPri => PLB_wrPendPri,
      PLB_reqPri => PLB_reqPri
    );

end architecture STRUCTURE;

