%%%-------------------------------------------------------------------
%% @doc erlluminate top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(erlluminate_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    {ok, { {one_for_all, 1, 5000},
           [{serv,
             {erlluminate_serv, start_link, []},
             permanent,
             5000,
             worker,
             dynamic}
           ]}
    }.

%%====================================================================
%% Internal functions
%%====================================================================
