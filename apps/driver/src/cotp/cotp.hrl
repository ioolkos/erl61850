-define(ED_TPDU, 16#10). % /* COTP */
-define(EA_TPDU, 16#20). % /* COTP */
-define(UD_TPDU, 16#40). % /* CLTP */
-define(RJ_TPDU, 16#50). % /* COTP */
-define(AK_TPDU, 16#60). % /* COTP */
-define(ER_TPDU, 16#70). % /* COTP */
-define(DR_TPDU, 16#80). % /* COTP */
-define(DC_TPDU, 16#C0). % /* COTP */
-define(CC_TPDU, 16#D0). % /* COTP */
-define(CR_TPDU, 16#E0). % /* COTP */
-define(DT_TPDU, 16#F0). % /* COTP */


%Included parameter length as it is fixed
-define(TPDU_SIZE, 16#c001).
-define(DST_TSAP, 16#c202).
-define(SRC_TSAP, 16#c102).


    %  The structure of the CR TPDU shall be as follows:

    %   1    2        3        4       5   6    7    8    p  p+1...end
    %  +--+------+---------+---------+---+---+------+-------+---------+
    %  |LI|CR CDT|     DST - REF     |SRC-REF|CLASS |VARIAB.|USER     |
    %  |  |1110  |0000 0000|0000 0000|   |   |OPTION|PART   |DATA     |
    %  +--+------+---------+---------+---+---+------+-------+---------+
    % CLASS is always 0
    % Lenght is 17 because of the standard size of this message.


-record(cotp_packet_conreq, {
          length        = 17,
          tpdu          = ?CR_TPDU,
          dest_ref      = 0,
          src_ref       = 1,
          class_option  = 0 ,
          tpdu_size = 8192, 
          dst_tsap = 1,
          src_tsap = 1
        }).

-record(cotp_packet_data, {
          length        = 2,
          tpdu          = ?DT_TPDU,
          class_option  = 16#80
        }).

-define(CONNECTREQUEST, <<16#11:8, 16#E0:8, 16#0:16, 16#0:16, 16#0, 16#c0, 16#01, 16#0d, 16#c2, 16#02, 16#0001:16, 16#c1, 16#02, 16#0001:16>>).