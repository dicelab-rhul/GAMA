:- discontiguous initial/1.
:- discontiguous initially/2.
:- discontiguous final/1.
:- discontiguous legal/2.
:- discontiguous possible/2.
:- discontiguous effect/3.
:- discontiguous abnormal/3.
:- discontiguous finally/2.


% Initial state
initial(s0).

% What holds initially: who is a player, their role, and whether they can play.
initially(player(p1), s0).
initially(player(p2), s0).
initially(role(p1, player_1), s0).
initially(role(p2, player_2), s0).
initially(control(p1), s0).
initially(control(p2), s0).
initially(default_move(_, 'Opera'), s0).

% When a state is final: no need to check content as it is generated by game/2,
% implying it is a legal state.
final(do(move(_P2, _M2), do(move(_P1, _M1), S))):-initial(S).

% A legal move is a possible move where the player has control (is its turn).
legal(move(P, M), S):- possible(move(P, M), S), holds(control(P), S).

% What is possible for a player to choose
possible(move(P, 'Opera'), S):- holds(player(P), S).
possible(move(P, 'Football'), S):- holds(player(P), S).

% Moves that are opposite to each other.
opposite_move('Opera', 'Football').
opposite_move('Football', 'Opera').

% The effects of a move: if P has chosen M, then in the next state this
% is what they did.
effect(did(P, M), move(P, M), _S).

% The effects of a move: once a move is made, the player loses control, i.e.
% cannot move anymore.
abnormal(control(P), move(P, _M), _S).

% What holds finally: the outcome with players, Moves, and Utilities.
finally(outcome(P1, M1, U1, P2, M2, U2), S):-
    final(S),
    holds(role(P1, player_1), S),
    holds(did(P1, M1), S),
    holds(role(P2, player_2), S),
    holds(did(P2, M2), S),
    payoff(M1, M2, U1, U2).

% Goals achieved by the players.
finally(goal(P1, U1), S):-
    finally(outcome(P1, _, U1, _, _, _), S).
finally(goal(P2, U2), S):-
    finally(outcome(_, _, _, P2, _, U2), S).
