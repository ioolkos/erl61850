-module('tpkt').
-export([decode/1, encode/1]).
-include("tpkt.hrl").

    %       TPKT Header
    %  ____________________   byte
    % |                    |
    % |     3 (version)    |   1
    % |____________________|
    % |                    |
    % |      Reserved      |   2
    % |____________________|
    % |                    |
    % |    Length (MSB)    |   3
    % |____________________|
    % |                    |
    % |    Length (LSB)    |   4
    % |____________________|
    % |                    |
    % |     X.224 TPDU     |   5 - ?


    decode(<<?VERSION:8, ?RESERVED:8, Length:16, Tpdu/binary>>)  
    when Length == byte_size(Tpdu) + 4 ->
        {ok, Tpdu};
    decode(_)->
        {error, error("invalid tpkt")}.


    encode(Tpdu) ->
        Length = 4 +  byte_size(Tpdu),
        {ok, << ?VERSION:8/unsigned-integer, ?RESERVED:8/unsigned-integer, Length:16/unsigned-integer, Tpdu/binary >>}.