LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY test_bench IS
    PORT
    (
        KEY  : IN std_logic_vector(1 DOWNTO 0);
        SW   : IN std_logic_vector(3 DOWNTO 0);
        LEDR : OUT std_logic_vector(3 DOWNTO 0)
    );
END ENTITY test_bench;

ARCHITECTURE rtl OF test_bench IS

BEGIN
    fooEnt : ENTITY foo;

    barEnt : ENTITY bar;

END ARCHITECTURE rtl;