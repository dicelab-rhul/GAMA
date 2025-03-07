:- dynamic initially/2.

% All legal evolutions of a game: can be used both as a generator and test.
game(F,F):- final(F).
game(S,F):- \+ final(S), legal(M,S), game(do(M,S),F).


% The domain independent version of the situation calculus is as follows:

% Situation Calculus - our formulation for games.
holds(F, S):- initially(F, S).
holds(F, do(M, S)):- effect(F, M, S).
holds(F, do(A, S)):- holds(F, S), \+ abnormal(F, A, S).

% (Re)initialise the state
initialise(Target, State):-
    Target =.. [Pred, Id, _],
    Current =.. [Pred, Id, _],
    (initially(Current, State) -> retract(initially(Current, State)); true),
    assert(initially(Target, State)).