
%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

parse(X) :- lines(X, []).

lines(Input, Rest) :-
    line(Input, Rest1),
    (   Rest1 = [';'|Rest2] ->
        lines(Rest2, Rest)
    ;   Rest1 = Rest
    ).

line(Input, Rest) :-
    num(Input, Rest1),
    (   Rest1 = [','|Rest2] ->
        line(Rest2, Rest)
    ;   Rest1 = Rest
    ).

num(Input, Rest) :-
    digit(Input, Rest1),
    (   digit(Rest1, Rest2) ->
        num_cont(Rest2, Rest)
    ;   Rest1 = Rest
    ).

num_cont(Input, Rest) :-
    (   digit(Input, Rest1) ->
        num_cont(Rest1, Rest)
    ;   Input = Rest
    ).

digit([H|T], T) :-
    member(H, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.
