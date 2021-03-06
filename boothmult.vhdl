library IEEE;
use IEEE.STD_LOGIC_1164.ALL;--This is the library that defines the basic std_logic data types and a few functions.
-- This should probably be included in every entity created.
use ieee.std_logic_unsigned.all;
--This library defines all of the same arithmetic (+, -, *), comparison (<, <=, >, >=, =, /=) and shift (shl, shr) operations as the std_logic_arith library.
-- This difference is that the extensions will take std_logic_vector values as arguments and treat them as unsigned integers 
 --All designs are expressed in terms of entities. An entity is
--the most basic building block in a design. The uppermost level of
--the design is the top-level entity. If the design is hierarchical, then
--the top-level description will have lower-level descriptions contained
--in it. These lower-level descriptions will be lower-level entities
--contained in the top-level entity description.

entity boothmult is
    Port ( mpcd,mplr : in  STD_LOGIC_vector(7 downto 0);
          
           result : out  STD_LOGIC_vector(15 downto 0));
          
end boothmult;
 --All entities that can be simulated have an architecture
--description. The architecture describes the behavior of the
--entity. A single entity can have multiple architectures. One architecture
--might be behavioral while another might be a structural
--description of the design.
  --here the architecture name is boot!!


architecture booth_architec of boothmult is

begin
  --The process is sensitive to signals x and y. In this example, x and y are
--input ports to the model. Input ports create signals that can be used as
--inputs; output ports create signals that can be used as outputs; and inout
--ports create signals that can be used as both. Whenever port x or y has a
--change in value, the statements inside of the process are executed. Each
--statement is executed in serial order starting with the statement at the
--top of the process statement and working down to the bottom. After all of
--the statements have been executed once, the process waits for another
--change in a signal or port in its sensitivity list.
process(mplr,mpcd)
variable br,nbr :std_logic_vector(7 downto 0);--Here br stores the multiplier whereas nbr stores the 2's complement of multiplier
variable acqr:std_logic_vector(15 downto 0);-- storing the 16 bit result
variable qnl : std_logic;
--qnl is used for storing the last previous bit of acqr.initially it is initialized to 0
begin

acqr(15 downto 8):=(others=>'0');
acqr(7 downto 0):= mpcd;
br :=mplr;
nbr :=(not mplr)+'1';
qnl := '0';

loop1: for i in 7 downto 0 loop
if(acqr(0) = '0' and qnl = '0' ) then--no action
qnl := acqr(0);
acqr(14 downto 0):=acqr(15 downto 1);--duplicate the first bit and shift to right 
elsif(acqr(0)='0' and qnl = '1') then--add
acqr(15 downto 8):=acqr(15 downto 8)+ br;
qnl :=acqr(0);
acqr(14 downto 0):= acqr(15 downto 1);--duplicate the first bit and shift to right 
elsif(acqr(0)='1' and qnl ='0') then --subtract
acqr(15 downto 8):=acqr(15 downto 8)+ nbr;
qnl := acqr(0);
acqr(14 downto 0):= acqr(15 downto 1);--duplicate the first bit and shift to right 
elsif(acqr(0)='1' and qnl ='1') then--no action
qnl:=acqr(0);
acqr(14 downto 0):= acqr(15 downto 1);--duplicate the first bit and shift to right 
end if;
end loop loop1;
 --Signal select <= will get a numeric value assigned to it
result<=acqr;


end process;

end booth_architec;--end of architecture booth_arch
