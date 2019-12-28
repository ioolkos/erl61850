-define(VERSION, 16#03). %Versão 
-define(RESERVED, 16#00). %Reservado

-record(tpkt_packet_header, {
    version = ?VERSION,
    reserved = ?RESERVED,
    length = undefined
}).