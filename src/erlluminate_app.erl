%%%-------------------------------------------------------------------
%% @doc erlluminate public API
%% @end
%%%-------------------------------------------------------------------

-module(erlluminate_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, turn_light_off/0, turn_light_on/0]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    erlluminate_sup:start_link().

turn_light_off() -> erlluminate_serv:turn_light_off().
turn_light_on() -> erlluminate_serv:turn_light_on().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
