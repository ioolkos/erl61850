-module(cotp).
-include("cotp.hrl").
-export([encode/1, decode/1]).



encode(connectrequest) ->
    Packet = #cotp_packet_conreq{},
    #cotp_packet_conreq{
          tpdu          = Tpdu,
          dest_ref      = Dest_ref,
          src_ref       = Src_ref,
          class_option  = Class_option,
          tpdu_size     = Tpdu_size,
          dst_tsap      = Dst_tsap,
          src_tsap      = Src_tsap
    } = Packet,
    Message = <<Tpdu:8/unsigned-integer,
                Dest_ref:16/unsigned-integer, 
                Src_ref:16/unsigned-integer, 
                Class_option:8/unsigned-integer, 
                ?TPDU_SIZE:16/unsigned-integer,
                Tpdu_size:8/unsigned-integer, 
                ?DST_TSAP:16/unsigned-integer, 
                Dst_tsap:16/unsigned-integer, 
                ?SRC_TSAP:16/unsigned-integer,
                Src_tsap:16/unsigned-integer>>,
    Length = byte_size(Message),
    {ok, <<Length:8/unsigned-integer, Message/binary>>};

encode(data_transfer) ->
    Packet = #cotp_packet_data{},
    #cotp_packet_data{      
        length        = Length,
        tpdu          = Tpdu,
        class_option  = Class_option
    } = Packet,
    {ok, <<Length:8/unsigned-integer, Tpdu:8/unsigned-integer, Class_option:8/unsigned-integer>>}.



decode(<<Length:8, Rest/binary >>) when Length == byte_size(Rest) ->
    decode(Rest);

decode(<<?CC_TPDU, _>>) ->
    {ok};

decode(<<?DT_TPDU, _>>) ->
    {ok};

decode(_) ->
    {error, error("invalid cotp")}.







    %{ok, ?CONNECTREQUEST};
    % Message = << ?CR_TPDU/binary,
    %              ?DESTINATIONREFERENCE/binary,
    %              ?SOURCEREFERENCE/binary,
    %              ?CLASS/binary,
    %              ?TPDUSIZE/binary,
    %              ?TPDUSIZEVALUE/binary,
    %              ?DSTTSAP/binary,
    %              ?DSTTSAPVALUE/binary,
    %              ?SRCTSAP/binary,
    %              ?SRCTSAPVALUE/binary>>,
    % Length = byte_size(Message), 
    % {ok, << Length, Message/binary>>, ok};


% static const value_string cotp_tpdu_type_abbrev_vals[] = {
%   { ED_TPDU, "ED Expedited Data" },
%   { EA_TPDU, "EA Expedited Data Acknowledgement" },
%   { RJ_TPDU, "RJ Reject" },
%   { AK_TPDU, "AK Data Acknowledgement" },
%   { ER_TPDU, "ER TPDU Error" },
%   { DR_TPDU, "DR Disconnect Request" },
%   { DC_TPDU, "DC Disconnect Confirm" },
%   { CC_TPDU, "CC Connect Confirm" },
%   { CR_TPDU, "CR Connect Request" },
%   { DT_TPDU, "DT Data" },
%   { 0,       NULL }
% };



