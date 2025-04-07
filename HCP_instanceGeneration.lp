% GENERATION OF PROBLEM INSTANCE - Problem instance requires persons, things, personTOthing relation, cabinetDomain and roomDomain 
% constants (placeholders) - can be overwritten during execution
#const numberOfPersons = 50.
#const numberOfThingsPerPerson = 100.

% creation of persons and things
person(1..numberOfPersons).
thing(1..numberOfPersons*numberOfThingsPerPerson).

% creation of personTOthing
% first {numberOfThingsPerPerson}-many things belong the person 1, the next to person 2 ...
personTOthing(P, T) :- person(P), thing(T), T <= ((P)*numberOfThingsPerPerson), T > ((P-1)*numberOfThingsPerPerson).  

% creation of cabinetDomain
% For each set of 5 things a person has, there must be a cabinet for it. If a person has 13 things, there must be 3 cabinets. 
% Divisions are floored by default, so modulo is necessary.
numberOfCabinetsPerPerson(X) :- X = (numberOfThingsPerPerson/5), 0 = (numberOfThingsPerPerson\5). 
numberOfCabinetsPerPerson(X+1) :- X = (numberOfThingsPerPerson/5), 0 != (numberOfThingsPerPerson\5).  

cabinetDomain(1..X) :- numberOfCabinetsPerPerson(N), X = N*numberOfPersons.

% creation of roomDomain 
% For each set of 4 cabinets of a person, there must be a room. If a person has 9 cabinets, there must be 3 rooms.  
numberOfRoomsPerPerson(X) :- numberOfCabinetsPerPerson(N), X = (N/4), 0 = (N\4).
numberOfRoomsPerPerson(X+1) :- numberOfCabinetsPerPerson(N), X = (N/4), 0 != (N\4). 

roomDomain(1..X) :- numberOfRoomsPerPerson(N), X = N*numberOfPersons.

