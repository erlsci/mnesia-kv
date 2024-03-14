%%%=============================================================================
%%%
%%%               |  o __   _|  _  __  |_   _       _ _   (TM)
%%%               |_ | | | (_| (/_ | | |_) (_| |_| | | |
%%%
%%% @copyright (C) 2014, Lindenbaum GmbH
%%%
%%% Permission to use, copy, modify, and/or distribute this software for any
%%% purpose with or without fee is hereby granted, provided that the above
%%% copyright notice and this permission notice appear in all copies.
%%%
%%% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
%%% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
%%% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
%%% ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
%%% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
%%% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
%%% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
%%%=============================================================================

-ifndef(mnkv_hrl_).
-define(mnkv_hrl_, 1).

%% The record defining an `mnkv' table entry.
-record(mnkv, {
          key :: mnkv:key() | '_',
          val :: mnkv:value() | '_',
          ver :: mnkv:version() | '_'}).

%% A special define using a `hidden' mnesia feature to set the `cookie' of a
%% table (at creation time only). This is needed to be able to merge schemas
%% of nodes. That created the same table independently (while not yet
%% connected). Please note that this bypasses a mnesia-builtin security
%% mechanism that classifies tables with the same name and different cookie as
%% incompatible by default. If two nodes have at least one table with the same
%% name and differing cookie a schema merge and thus a mnesia-connection between
%% these nodes will be refused by mnesia.
-define(MNKV_COOKIE, {{0,0,0}, mnkv}).

%% The options used in `mnesia:create_table/2'.
-define(MNKV_TABLE_OPTS, [{record_name, mnkv},
                            {attributes, record_info(fields, mnkv)},
                            {cookie, ?MNKV_COOKIE},
                            {ram_copies, [node() | nodes()]}]).

%% Default timeout for RPC calls.
-define(MNKV_RPC_TIMEOUT, 2000).

%% Simple debug macro.
-ifdef(DEBUG).
-define(MNKV_DBG(Fmt, Args), io:format(Fmt, Args)).
-else.
-define(MNKV_DBG(Fmt, Args), begin _ = Fmt, _ = Args, ok end).
-endif.

-endif. %% mnkv_hrl_
