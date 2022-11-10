
// Create nodes
CREATE (pZakria:Person {firstname: 'Zakria', lastname: 'Samma', birthday: date('2005-11-30')}), 
	   (pKalel:Person {firstname: 'Kalel', lastname: 'Poeta', birthday: date('2005-01-03')})

// Select Node
MATCH (pZakria:Person) WHERE pZakria.firstname = 'Zakria' RETURN pZakria;

// Create friendship between person nodes
MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
CREATE (pKalel)-[friendship:FRIENDS_WITH{since: date("2021-08-27")}]->(pZakria)
RETURN type(friendship)

MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
return pKalel, pZakria;

MATCH (uAron: User) WHERE ID(uAron) = 4 DETACH DELETE uAron;