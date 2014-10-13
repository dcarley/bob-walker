#!/usr/bin/env escript

main(Args) ->
    Words = get_words(Args),
    WordsFinal = case lists:member("--drunk", Args) of
        true -> slur(Words);
        false -> Words
    end,

    speak(WordsFinal).

get_words(Args) ->
    Base = ["beer", "beard", "pie"],
    Modes = dict:from_list([
        {"--sport", ["cricket", "rugby"]},
        {"--programming", ["chef", "perl", "CPAN"]},
        {"--xmas", ["mince pies", "reindeer"]}
    ]),

    ModeSelect = fun(Mode, Acc) ->
        case dict:find(Mode, Modes) of
          {_, Words} -> lists:append(Acc, Words);
          error -> Acc
        end
    end,

    lists:foldl(ModeSelect, Base, Args).

slur(Words) ->
    Replace = fun(Word) -> re:replace(Word, "e", "eeee", [{return, list}]) end,
    lists:map(Replace, Words).

speak(Words) ->
    Speaker = fun(Word) -> io:format("~s~n", [Word]) end,
    lists:foreach(Speaker, Words),

    speak(Words).
