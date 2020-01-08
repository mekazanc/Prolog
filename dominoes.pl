% run it with sequence(NewList3).

sequence(NewList3):-
    % create potential lists
    findall(D,permutate(D,[0,1,2,3]),List),
    % remove list which contains repeated sublists such as[[1,0],[1,0]..]. 
    all_different2(List,NewList),
    % remove lists which does not obey sum=3 rule,
    check_sum2(NewList,NewList2),
	% compare all list elements in pairs,
	check_pair2(NewList2,NewList3).


% rotation control of overall list  
check_pair2([],[]).
check_pair2([H|T],[H|NewList]):-
    check_pair(H,T),
    check_pair2(T,NewList).

check_pair2([H|T],NewList):-
    not(check_pair(H,T)),
    check_pair2(T,NewList).


% rotation control in pairs. 
check_pair(H,[H1|T]):-
    not(check_rotation(H,H1)),
    check_pair(H,T).
check_pair(_,[]).    
    

% cover all lists in pairs. 
all_different2([],[]).
all_different2([H|T],[H|NewList]):-
    all_different(H),
    all_different2(T,NewList).
all_different2([H|T],NewList):-
    not(all_different(H)),
    all_different2(T,NewList).

% compare elements in a list. 
all_different([D1,D2,D3,D4]):-
    compare(D1,D2),
    compare(D1,D3),
    compare(D1,D4),
    compare(D2,D3),
    compare(D2,D4),
    compare(D3,D4).

% cover all lists. Select one list : compare whole remaining lists. 
check_sum2([],[]).
check_sum2([H|T],[H|NewList]):-
    check_sum(H),
    check_sum2(T,NewList).
check_sum2([H|T],NewList):-
    not(check_sum(H)),
    check_sum2(T,NewList).

% total sum control
check_sum([[Q1,Q2],[X1,X2],[Y1,Y2],[Z1,Z2]]):-
       3 is Q1 + Q2 + X1,
       3 is X1 + X2 + Y1,
       3 is Y1 + Y2 + Z1,
       3 is Z1 + Z2 + Q1.
    
% compare sublists 
compare([X1,Y1],[X2,Y2]):-
    [X1,Y1] \= [X2,Y2],
    compare_reverse([X1,Y1],[X2,Y2]).
% compare sublists in terms of symmetry
compare_reverse([X1,Y1],[X2,Y2]):-
    [X1,Y1] \= [Y2,X2].

% create possible combinations
permutate([[D1,D2],[D3,D4],[D5,D6],[D7,D8]],List):-
  member(D1,List),member(D2,List),member(D3,List),member(D4,List),
  member(D5,List),member(D6,List),member(D7,List),member(D8,List).


% rotation control
check_rotation(List1,List2):-
    rotation90(List1,List2);
    rotation180(List1,List2);
    rotation270(List1,List2).
    

rotation90([X,Y,Z,T],[ A,B,C,D]):-
    X = B,
    Y = C,
    Z = D,
    T = A.

rotation180([X,Y,Z,T],[ A,B,C,D]):-
    X = C,
    Y = D,
    Z = A,
    T = B.

rotation270([X,Y,Z,T],[A,B,C,D]):-
    X = D,
    Y = A,
    Z = B,
    T = C.

    
 




