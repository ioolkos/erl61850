%CONNECT SPDU
-record(connect_spdu,{
    length_session,
    protocol_options_flags = 2,
    version_flags = 2,
    session_requirement_flags = 2, 
    calling_session_selector = 1,
    called_session_selector = 1,
    length_user_data
}).

-define(CONNECT_SPDU, 13).
-define(CONNECT_ACCEPT_ITEM, 5).
-define(PROTOCOL_OPTIONS, 19).
-define(VERSION_NUMBER, 22).
-define(SESSION_REQUIREMENT, 20).
-define(CALLING_SESSION_SELECTOR, 51).
-define(CALLED_SESSION_SELECTOR, 52).
-define(SESSION_USER_DATA, 193).
