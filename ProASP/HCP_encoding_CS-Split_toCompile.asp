%Constraints without aggregates (CS): 
:- cabinetTOthing(C1,T), cabinetTOthing(C2,T), C1 < C2.
:- cabinetTOthing(C1,T1), cabinetTOthing(C2,T2), C1<C2, T1>T2.
:- roomTOcabinet(R1,C), roomTOcabinet(R2,C), R1 < R2.
:- personTOcabinet(P1, C), personTOcabinet(P2, C), P1 < P2.
:- personTOroom(P1,R), personTOroom(P2,R), P1 < P2.
