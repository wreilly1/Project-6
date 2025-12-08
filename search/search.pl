%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here:
%%%%%%%%%%%%%%%%%%%%%%

search(Actions) :-
    initial(Start),
    bfs([[state(Start, []), []]], Actions).

bfs([[state(Room, _Keys), Actions] | _], FinalActions) :-
    treasure(Room),
    reverse(Actions, FinalActions).

bfs([[state(Room, Keys), Actions] | Rest], Solution) :-
    \+ treasure(Room),
    findall([state(NewRoom, NewKeys), [move(Room, NewRoom) | Actions]],
            can_move(Room, NewRoom, Keys, NewKeys), NewStates),
    append(Rest, NewStates, Queue),
    bfs(Queue, Solution).

can_move(From, To, Keys, NewKeys) :-
    door(From, To),
    NewKeys = Keys.

can_move(From, To, Keys, NewKeys) :-
    door(To, From),
    NewKeys = Keys.

can_move(From, To, Keys, NewKeys) :-
    locked_door(From, To, Color),
    member(Color, Keys),
    NewKeys = Keys.

can_move(From, To, Keys, NewKeys) :-
    locked_door(To, From, Color),
    member(Color, Keys),
    NewKeys = Keys.

can_move(From, To, Keys, NewKeys) :-
    key(To, Color),
    door(From, To),
    \+ member(Color, Keys),
    NewKeys = [Color | Keys].

can_move(From, To, Keys, NewKeys) :-
    key(To, Color),
    door(To, From),
    \+ member(Color, Keys),
    NewKeys = [Color | Keys].
