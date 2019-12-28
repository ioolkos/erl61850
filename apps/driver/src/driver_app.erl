%%%-------------------------------------------------------------------
%% @doc driver public API
%% @end
%%%-------------------------------------------------------------------

-module(driver_app).

-behaviour(application).
-export([start/2, stop/1, connect/0]).
-import(tpkt, [decode_header/1, encode_header/1]).
-import(cotp, [encode/1]).


start(_StartType, _StartArgs) ->
    driver_sup:start_link().
stop(_State) ->
    ok.

connect()->
    {ok, Socket} = gen_tcp:connect({127,0,0,1}, 102, [binary]),
    {ok, ConnectRequest} = cotp:encode(connectrequest),
    {ok, TpktHeader} = tpkt:encode(ConnectRequest),
    ok = gen_tcp:send(Socket, TpktHeader),
    %receive_data(Socket, []).
    receive
        {tcp, Socket, Data} ->
            case  tpkt:decode(Data) of
            {ok, Tpdu} -> 
                case cotp:decode(Tpdu) of
                {ok } -> {ok};
                {error} -> {error}
                end;
            {error, Rest} -> {error, Rest}
            end
            
    end.

 receive_data(Socket, SoFar)->
     receive
         {tcp, Socket, Bin} ->
             receive_data(Socket, [Bin|SoFar]);
         {tcp_closed, Socket}->
             list_to_binary(lists:reverse(SoFar))
     end.


%% internal functions


