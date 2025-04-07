%Aggregates (AG):
:- #count {C : cabinetTOthing(C,T)} < 1, thing(T).
:- #count { T : cabinetTOthing(C,T), thing(T) } >= 6, cabinet(C).
:- #count {R : roomTOcabinet(R,C)} < 1, cabinet(C).
:- #count { C : roomTOcabinet(R,C), cabinetDomain(C) } >= 5, room(R).

%Normal Rules (RL):
cabinet(C) :- cabinetDomain(C), not cabinet_n(C).
cabinet_n(C) :- cabinetDomain(C), not cabinet(C).
room(R) :- roomDomain(R), not room_n(R).
room_n(R) :- roomDomain(R), not room(R).
cabinetTOthing(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing_n(C,T).
cabinetTOthing_n(C,T) :- thing(T), cabinetDomain(C), not cabinetTOthing(C,T).
roomTOcabinet(R,C) :- cabinet(C), roomDomain(R), not roomTOcabinet_n(R,C).
roomTOcabinet_n(R,C) :- cabinet(C), roomDomain(R), not roomTOcabinet(R,C).
personTOcabinet(P,C) :- personTOthing(P,T), cabinetTOthing(C,T).
personTOroom(P,R) :- personTOcabinet(P,C), roomTOcabinet(R,C).
room(R1) :- roomDomain(R1), roomDomain(R2), room(R2), R1 < R2.
cabinet(C1) :- cabinetDomain(C1), cabinetDomain(C2), cabinet(C2), C1 < C2.
room(R) :- roomTOcabinet(R,C).
cabinet(C) :- cabinetTOthing(C,T).