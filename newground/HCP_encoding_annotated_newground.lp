cabinet(C) :- cabinetDomain(C), not cabinet_n(C).
cabinet_n(C) :- cabinetDomain(C), not cabinet(C).

room(R) :- roomDomain(R), not room_n(R).
room_n(R) :- roomDomain(R), not room(R).

cabinetTOthing(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing_n(C,T).
cabinetTOthing_n(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing(C,T).
:- cabinetTOthing(C1,T), cabinetTOthing(C2,T), C1 < C2.
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

#program rules. % constraint with 4 variables 
:- cabinetTOthing(C1,T1), cabinetTOthing(C2,T2), C1<C2, T1>T2.