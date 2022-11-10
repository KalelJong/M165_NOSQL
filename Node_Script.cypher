
// Create nodes
CREATE (pZakria:Person {firstname: 'Zakria', lastname: 'Samma', birthday: date('2005-11-30')}), 
	   (pKalel:Person {firstname: 'Kalel', lastname: 'Poeta', birthday: date('2005-01-03')}),
	   (pMolly:Person {firstname: 'Molly', lastname: 'Sapey', birthday: date('2006-04-13')})

// Create with relationship
CREATE p = (pAron:Person {firstname: 'Aron', lastname: 'Heuberger', birthday: date('2005-12-02')})
-[ff:FRIENDS_WITH {since: date("2021-08-01")}]->({firstname: 'Grace', lastname: 'Rose', birthday: date('2005-12-02')})
RETURN p

// Update node property
MATCH (n {firstname: "Grace"}) SET n.birthday = date("2005-12-24") Return n;


// Select Node
MATCH (pZakria:Person) WHERE pZakria.firstname = 'Zakria' RETURN pZakria;

// Create friendship between person nodes
MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
CREATE (pKalel)-[ff:FRIENDS_WITH{since: date("2021-08-27")}]->(pZakria),
(pZakria)-[ee:FRIENDS_WITH{since: date("2021-08-27")}]->(pKalel)
RETURN type(friendship,ee)

// Delete friendship
MATCH (pKalel:Person {firstname: 'Kalel'})-[r:FRIENDS_WITH{since: date("2021-08-27")}]->(pZakria:Person {firstname: 'Zakria'})
DELETE r
// Add relationship to existing nodes
MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
return pKalel, pZakria;

// Delete Node and it's relationships
MATCH (uAron: User) WHERE ID(uAron) = 4 DETACH DELETE uAron;