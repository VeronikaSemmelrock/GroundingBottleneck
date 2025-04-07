cabinet(C) :- cabinetDomain(C), not cabinet_n(C).
cabinet_n(C) :- cabinetDomain(C), not cabinet(C).

room(R) :- roomDomain(R), not room_n(R).
room_n(R) :- roomDomain(R), not room(R).

cabinetTOthing(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing_n(C,T).
cabinetTOthing_n(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing(C,T).
:- cabinetTOthing(C1,T), cabinetTOthing(C2,T), C1 < C2.
:- cabinetTOthing(C1,T1), cabinetTOthing(C2,T2), C1<C2, T1>T2.
:- 1 > #count {C : cabinetTOthing(C,T)}, thing(T).
:- 6 <= #count { T : cabinetTOthing(C,T), thing(T) }, cabinet(C).

roomTOcabinet(R,C) :- cabinet(C), roomDomain(R), not roomTOcabinet_n(R,C).
roomTOcabinet_n(R,C) :- cabinet(C), roomDomain(R), not roomTOcabinet(R,C).
:- roomTOcabinet(R1,C), roomTOcabinet(R2,C), R1 < R2.
:- 1 > #count {R : roomTOcabinet(R,C)}, cabinet(C).
:- 5 <= #count { C : roomTOcabinet(R,C), cabinetDomain(C) }, room(R).

personTOcabinet(P,C) :- personTOthing(P,T), cabinetTOthing(C,T).
:- personTOcabinet(P1, C), personTOcabinet(P2, C), P1<P2.

personTOroom(P,R) :- personTOcabinet(P,C), roomTOcabinet(R,C).
:- personTOroom(P1,R), personTOroom(P2,R), P1<P2.

room(R1) :- roomDomain(R1), roomDomain(R2), room(R2), R1 < R2.
cabinet(C1) :- cabinetDomain(C1), cabinetDomain(C2), cabinet(C2), C1 < C2.

room(R) :- roomTOcabinet(R,C).

cabinet(C) :- cabinetTOthing(C,T).



%%%%%%%%%% HEURISTICS %%%%%%%%%%%%%%
maxCabinet(C) :- cabinetDomain(C), not cabinetDomain(C+1). 
maxRoom(R) :- roomDomain(R), not roomDomain(R+1).  
maxThing(T) :- thing(T), not thing(T+1).

fullCabinet(C) :- 5 <= #count { T : cabinetTOthing(C,T), thing(T) }, cabinet(C).
fullRoom(R) :-  4 <= #count { C : roomTOcabinet(R,C), cabinetDomain(C)}, room(R).

assignedThing(T) :- cabinetTOthing(_,T).
assignedCabinet(C) :- roomTOcabinet(_,C).

personTOcabinet(P, C) :- personTOthing(P,T), cabinetTOthing(C,T). 
otherPersonTOcabinet(P,C) :- personTOcabinet(P2,C), person(P), P!=P2.
otherPersonTOroom(P, R) :- roomTOcabinet(R,C), personTOcabinet(P2,C), person(P), P!=P2. 

% Assign things to cabinets
#heuristic cabinetTOthing(C, T) :
    cabinetDomain(C), not fullCabinet(C),
    not T assignedThing(T), personTOthing(P, T),
    not otherPersonTOcabinet(P, C),
    maxThing(MT),
    maxCabinet(MC), W=(MC-C)+(MT-T). [(W)@2] 


% Fill rooms with cabinets - assign cabinets to rooms
#heuristic roomTOcabinet(R, C) :
    roomDomain(R), not fullRoom(R),
    cabinet(C), not T assignedCabinet(C),
    personTOcabinet(P, C), not otherPersonTOroom(P, R),
    maxRoom(MR), W=MR-R. [(W)@1]

% Close unassigned choice points
#heuristic F cabinetTOthing(C, T) :
    not cabinetTOthing(C, T), cabinetDomain(C), thing(T).
#heuristic F roomTOcabinet(R, C) :
    not roomTOcabinet(R, C), roomDomain(R), cabinet(C).
