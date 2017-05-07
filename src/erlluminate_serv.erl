-module(erlluminate_serv).
-behavior(gen_server).
-export([start_link/0, turn_light_off/0, turn_light_on/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         code_change/3, terminate/2]).

start_link() ->
    io:format("Starting the server~n"),
    gen_server:start_link({local, requester}, ?MODULE, [], []).

init([]) ->
    {ok, ok}.

turn_light_off() ->
    gen_server:call(requester, {light, off}).
turn_light_on() ->
    gen_server:call(requester, {light, on}).

handle_call({light, off}, _From, State) ->
    {ok, Bridge_IP} = application:get_env(bridge_ip),
    {ok, API_User} = application:get_env(api_user),
    {ok, Light_num} = application:get_env(light_num),
    Url = "http://" ++ Bridge_IP ++ "/api/" ++ API_User ++ "/lights/" ++ Light_num ++ "/state",
    {_, Result} = httpc:request(put, {Url, [], "application/json", "{\"on\": false}"}, [], []),
    {reply, Result, State};
handle_call({light, on}, _From, State) ->
    {ok, Bridge_IP} = application:get_env(bridge_ip),
    {ok, API_User} = application:get_env(api_user),
    {ok, Light_num} = application:get_env(light_num),
    Url = "http://" ++ Bridge_IP ++ "/api/" ++ API_User ++ "/lights/" ++ Light_num ++ "/state",
    {_, Result} = httpc:request(put, {Url, [], "application/json", "{\"on\": true}"}, [], []),
    {reply, Result, State}.

handle_info(_Info, State) -> {noreply, State}.
handle_cast(_Request, State) -> {noreply, State}.
code_change(_OldVsn, State, _Extra) -> {ok, State}.
terminate(_Reason, _State) -> ok.
