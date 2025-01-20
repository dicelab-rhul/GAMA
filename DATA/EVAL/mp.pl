mp(S2, D1, D2, S1, H,T):-
            ((S1<S2,
              D1>D2,
              S1<D1,
             S2>D2);
            (S1>S2,
              D1<D2,
              S1>D1,
             S2<D2)
            ),
            ((payoff(H,H,S1,S2),
            payoff(H,T,D1,D2),
            payoff(T,H,D1,D2),
            payoff(T,T,S1,S2));
            (payoff(H,H,S2,S1),
            payoff(H,T,D2,D1),
            payoff(T,H,D2,D1),
            payoff(T,T,S2,S1));
            (payoff(H,H,D1,D2),
            payoff(H,T,S1,S2),
            payoff(T,H,S1,S2),
            payoff(T,T,D1,D2));
            (payoff(H,H,D2,D1),
            payoff(H,T,S2,S1),
            payoff(T,H,S2,S1),
            payoff(T,T,D2,D1))
			).
