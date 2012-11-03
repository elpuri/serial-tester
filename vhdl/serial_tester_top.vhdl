-- Copyright (c) 2012, Juha Turunen
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met: 
--
-- 1. Redistributions of source code must retain the above copyright notice, this
--    list of conditions and the following disclaimer. 
-- 2. Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution. 
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
-- ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity serial_tester_top is Port (
    clk_50 : in std_logic;
    uart_rxd : in std_logic;
    uart_txd : out std_logic;
    hex0 : out std_logic_vector(6 downto 0);
    hex1 : out std_logic_vector(6 downto 0);
    hex2 : out std_logic_vector(6 downto 0);
    hex3 : out std_logic_vector(6 downto 0);
    hex4 : out std_logic_vector(6 downto 0);
    hex5 : out std_logic_vector(6 downto 0);
    hex6 : out std_logic_vector(6 downto 0);
    hex7 : out std_logic_vector(6 downto 0);
    btn : in std_logic_vector(3 downto 3)
);
end serial_tester_top;


architecture Behavioral of serial_tester_top is

signal displayed_byte : std_logic_vector(7 downto 0);
signal disp0_7seg_output : std_logic_vector(6 downto 0);
signal disp1_7seg_output : std_logic_vector(6 downto 0);
signal reset : std_logic;

begin
   
    reset <= not btn(3);
    uart_txd <= '1';
    
    hex0 <= disp0_7seg_output;
    hex1 <= disp1_7seg_output;
    hex2 <= (others => '1');        -- Turn off all other displays
    hex3 <= (others => '1');
    hex4 <= (others => '1');
    hex5 <= (others => '1');
    hex6 <= (others => '1');
    hex7 <= (others => '1');
    
    -- Lower nybble
    disp0 : entity work.bin_to_7seg port map(
        value => displayed_byte(3 downto 0),
        display => disp0_7seg_output 
    );
    
    -- Higher nybble
    disp1 : entity work.bin_to_7seg port map(
        value => displayed_byte(7 downto 4),
        display => disp1_7seg_output
    );
    
    rx : entity work.serial_rx port map(
        clk_50 => clk_50,
        rx => uart_rxd,
        dout => displayed_byte,
        reset => reset
    );
    
end Behavioral;

