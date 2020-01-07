
% question of single elimination badminton tournament... 

% player no and losers. 
beat(1,[2,3,4,5,6]).
beat(2,[3,4,5,6,7,8]).
beat(3,[4,5,6,7,8]).
beat(4,[5,6,7,8]).
beat(5,[6,7,8]).
beat(6,[7,8]).
beat(7,[1,8]).
beat(8,[1]).



% create list up to total number of persons. 
createList(0,[]).
createList(N,[N|List]):-
    N>0,
    N2 is N-1,
    createList(N2,List).

% permutate a given list. 
permut([],[]).
permut(List,[X|P]):-
    del(X,List,L2),
    permut(L2,P).

% delete an element.
del(X,[X|T],T).
del(X,[Y|H],[Y|List]):-
    del(X,H,List).

% get nth element of list. 
getelement(0,[H|_],H).
getelement(N,[_|T],List):-
    N2 is N-1,
    getelement(N2,T,List).

    

% Select median of permutated list for obtain single sequence. 
% Creating random sequence may be better at this point. 
% You can test is with beatlist(8,List,Winner).
% If you want to test it with number different from 8, you need to be sure that
% it has requiered facts above at top. 

beatlist(N,List,Winner):-
 createList(N,List1),
 findall(List2, permut(List1,List2), ListAll),
 N2 is N/2,
 getelement(N2,ListAll,List),
 tournament(List, Winner).


% finding  winner. 
onematch([],[]).
onematch([H1,H2|T],[H1|Winner]):-
    beat(H1,List),
    member(H2,List),
    onematch(T,Winner).
onematch([H1,H2|T],[H2|Winner]):-
    beat(H1,List),
    not(member(H2,List)),
    onematch(T,Winner).


% finding tournament based winner
tournament([H],H).
tournament(List,Winner2):-
    onematch(List,Winner),
    tournament(Winner,Winner2). 



%% last part of 5th question
%% Here, I used all possible sequences. 
numberwins(N,Player,NumberWinner):-
 createList(N,List1),
 findall(List2, permut(List1,List2), ListAll),
 multiseq(ListAll, Player, NumberWinner).


%% use accumulator to count number of occurances of given player. 
multiseq([H|T], Player, NumberWinner ):-
    multiseqacc([H|T], Player, NumberWinner, 0 ).


multiseqacc([], _, Acc, Acc ).
multiseqacc([H|T], Player, NumberWinner, Acc ):-   
    tournament(H,Winner),
    Winner = Player,
	Acc2 is Acc + 1,
    multiseqacc(T, Player, NumberWinner, Acc2).

multiseqacc([H|T], Player, NumberWinner, Acc ):-   
    tournament(H,Winner),
    not(Winner = Player),
    multiseqacc(T, Player, NumberWinner, Acc).

  
member(H,[H|_]).
member(H,[_|T]):-
    member(H,T).





