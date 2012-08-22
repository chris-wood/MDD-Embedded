-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    fpga_0_RS232_Uart_1_RX_pin : in std_logic;
    fpga_0_RS232_Uart_1_TX_pin : out std_logic;
    fpga_0_Ethernet_MAC_PHY_tx_clk_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_rx_clk_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_crs_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_dv_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_rx_data_pin : in std_logic_vector(3 downto 0);
    fpga_0_Ethernet_MAC_PHY_col_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_rx_er_pin : in std_logic;
    fpga_0_Ethernet_MAC_PHY_rst_n_pin : out std_logic;
    fpga_0_Ethernet_MAC_PHY_tx_en_pin : out std_logic;
    fpga_0_Ethernet_MAC_PHY_tx_data_pin : out std_logic_vector(3 downto 0);
    fpga_0_Ethernet_MAC_PHY_MDC_pin : out std_logic;
    fpga_0_Ethernet_MAC_PHY_MDIO_pin : inout std_logic;
    fpga_0_Ethernet_MAC_MDINT_pin : in std_logic;
    fpga_0_DDR2_SDRAM_DDR2_DQ_pin : inout std_logic_vector(63 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQS_pin : inout std_logic_vector(7 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_DQS_N_pin : inout std_logic_vector(7 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_A_pin : out std_logic_vector(12 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_BA_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_RAS_N_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_CAS_N_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_WE_N_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_CS_N_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_ODT_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_CKE_pin : out std_logic;
    fpga_0_DDR2_SDRAM_DDR2_DM_pin : out std_logic_vector(7 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_CK_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR2_SDRAM_DDR2_CK_N_pin : out std_logic_vector(1 downto 0);
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      fpga_0_RS232_Uart_1_RX_pin : in std_logic;
      fpga_0_RS232_Uart_1_TX_pin : out std_logic;
      fpga_0_Ethernet_MAC_PHY_tx_clk_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_rx_clk_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_crs_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_dv_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_rx_data_pin : in std_logic_vector(3 downto 0);
      fpga_0_Ethernet_MAC_PHY_col_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_rx_er_pin : in std_logic;
      fpga_0_Ethernet_MAC_PHY_rst_n_pin : out std_logic;
      fpga_0_Ethernet_MAC_PHY_tx_en_pin : out std_logic;
      fpga_0_Ethernet_MAC_PHY_tx_data_pin : out std_logic_vector(3 downto 0);
      fpga_0_Ethernet_MAC_PHY_MDC_pin : out std_logic;
      fpga_0_Ethernet_MAC_PHY_MDIO_pin : inout std_logic;
      fpga_0_Ethernet_MAC_MDINT_pin : in std_logic;
      fpga_0_DDR2_SDRAM_DDR2_DQ_pin : inout std_logic_vector(63 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQS_pin : inout std_logic_vector(7 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_DQS_N_pin : inout std_logic_vector(7 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_A_pin : out std_logic_vector(12 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_BA_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_RAS_N_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_CAS_N_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_WE_N_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_CS_N_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_ODT_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_CKE_pin : out std_logic;
      fpga_0_DDR2_SDRAM_DDR2_DM_pin : out std_logic_vector(7 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_CK_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR2_SDRAM_DDR2_CK_N_pin : out std_logic_vector(1 downto 0);
      fpga_0_clk_1_sys_clk_pin : in std_logic;
      fpga_0_rst_1_sys_rst_pin : in std_logic
    );
  end component;

  attribute BUFFER_TYPE : STRING;
  attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of fpga_0_Ethernet_MAC_PHY_tx_clk_pin : signal is "IBUF";
  attribute BUFFER_TYPE of fpga_0_Ethernet_MAC_PHY_rx_clk_pin : signal is "IBUF";
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      fpga_0_RS232_Uart_1_RX_pin => fpga_0_RS232_Uart_1_RX_pin,
      fpga_0_RS232_Uart_1_TX_pin => fpga_0_RS232_Uart_1_TX_pin,
      fpga_0_Ethernet_MAC_PHY_tx_clk_pin => fpga_0_Ethernet_MAC_PHY_tx_clk_pin,
      fpga_0_Ethernet_MAC_PHY_rx_clk_pin => fpga_0_Ethernet_MAC_PHY_rx_clk_pin,
      fpga_0_Ethernet_MAC_PHY_crs_pin => fpga_0_Ethernet_MAC_PHY_crs_pin,
      fpga_0_Ethernet_MAC_PHY_dv_pin => fpga_0_Ethernet_MAC_PHY_dv_pin,
      fpga_0_Ethernet_MAC_PHY_rx_data_pin => fpga_0_Ethernet_MAC_PHY_rx_data_pin,
      fpga_0_Ethernet_MAC_PHY_col_pin => fpga_0_Ethernet_MAC_PHY_col_pin,
      fpga_0_Ethernet_MAC_PHY_rx_er_pin => fpga_0_Ethernet_MAC_PHY_rx_er_pin,
      fpga_0_Ethernet_MAC_PHY_rst_n_pin => fpga_0_Ethernet_MAC_PHY_rst_n_pin,
      fpga_0_Ethernet_MAC_PHY_tx_en_pin => fpga_0_Ethernet_MAC_PHY_tx_en_pin,
      fpga_0_Ethernet_MAC_PHY_tx_data_pin => fpga_0_Ethernet_MAC_PHY_tx_data_pin,
      fpga_0_Ethernet_MAC_PHY_MDC_pin => fpga_0_Ethernet_MAC_PHY_MDC_pin,
      fpga_0_Ethernet_MAC_PHY_MDIO_pin => fpga_0_Ethernet_MAC_PHY_MDIO_pin,
      fpga_0_Ethernet_MAC_MDINT_pin => fpga_0_Ethernet_MAC_MDINT_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQ_pin => fpga_0_DDR2_SDRAM_DDR2_DQ_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_pin,
      fpga_0_DDR2_SDRAM_DDR2_DQS_N_pin => fpga_0_DDR2_SDRAM_DDR2_DQS_N_pin,
      fpga_0_DDR2_SDRAM_DDR2_A_pin => fpga_0_DDR2_SDRAM_DDR2_A_pin,
      fpga_0_DDR2_SDRAM_DDR2_BA_pin => fpga_0_DDR2_SDRAM_DDR2_BA_pin,
      fpga_0_DDR2_SDRAM_DDR2_RAS_N_pin => fpga_0_DDR2_SDRAM_DDR2_RAS_N_pin,
      fpga_0_DDR2_SDRAM_DDR2_CAS_N_pin => fpga_0_DDR2_SDRAM_DDR2_CAS_N_pin,
      fpga_0_DDR2_SDRAM_DDR2_WE_N_pin => fpga_0_DDR2_SDRAM_DDR2_WE_N_pin,
      fpga_0_DDR2_SDRAM_DDR2_CS_N_pin => fpga_0_DDR2_SDRAM_DDR2_CS_N_pin,
      fpga_0_DDR2_SDRAM_DDR2_ODT_pin => fpga_0_DDR2_SDRAM_DDR2_ODT_pin,
      fpga_0_DDR2_SDRAM_DDR2_CKE_pin => fpga_0_DDR2_SDRAM_DDR2_CKE_pin,
      fpga_0_DDR2_SDRAM_DDR2_DM_pin => fpga_0_DDR2_SDRAM_DDR2_DM_pin,
      fpga_0_DDR2_SDRAM_DDR2_CK_pin => fpga_0_DDR2_SDRAM_DDR2_CK_pin,
      fpga_0_DDR2_SDRAM_DDR2_CK_N_pin => fpga_0_DDR2_SDRAM_DDR2_CK_N_pin,
      fpga_0_clk_1_sys_clk_pin => fpga_0_clk_1_sys_clk_pin,
      fpga_0_rst_1_sys_rst_pin => fpga_0_rst_1_sys_rst_pin
    );

end architecture STRUCTURE;

