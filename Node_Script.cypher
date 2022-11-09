
CREATE (pZakria:Person {firstname: 'Zakria', lastname: 'Samma', birthday: date('2005-11-30')}), 
	   (pKalel:Person {firstname: 'Kalel', lastname: 'Poeta', birthday: date('2005-01-03')})


MATCH (pZakria:Person) WHERE pZakria.firstname = 'Zakria' RETURN pZakria;

MATCH (uAron: User) WHERE ID(uAron) = 4 DETACH DELETE uAron;