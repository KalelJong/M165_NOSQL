
// Create nodes
CREATE (pZakria:Person {firstname: 'Zakria', lastname: 'Samma', birthday: date('2005-11-30')}), 
	   (pKalel:Person {firstname: 'Kalel', lastname: 'Poeta', birthday: date('2005-01-03')}),
	   (pMolly:Person {firstname: 'Molly', lastname: 'Sapey', birthday: date('2006-04-13')}),
	   (pBecky:Person {firstname: 'Becky', lastname: 'Lee', birthday: date('2005-08-19')}),
	   (pMilena:Person {firstname: 'Milena', lastname: 'Soldato', birthday: date('2005-05-30')}),
	   (pAlex:Person {firstname: 'Alex', lastname: 'Kazmer', birthday: date('2004-10-26')}),
	   (pAkina:Person {firstname: 'Akina', lastname: 'Keates', birthday: date('2005-11-12')}),
	   (pJoseph:Person {firstname: 'Joseph', lastname: 'Boyse', birthday: date('2004-02-11')}),
	   (pLeo:Person {firstname: 'Leo', lastname: 'Barun', birthday: date('2005-10-02')}),
	   (pDamian:Person {firstname: 'Damian', lastname: 'Bloesser', birthday: date('2005-10-15')}),
	   (pSamuel:Person {firstname: 'Samuel', lastname: 'Sporer', birthday: date('2005-01-10')})

     
	   
	   
	   

// Create with relationship
CREATE p = (pAron:Person {firstname: 'Aron', lastname: 'Heuberger', birthday: date('2005-12-02')})
-[ff:DATING {since: date("2022-07-01")}]->(pGrace: Person{firstname: 'Grace', lastname: 'Rose', birthday: date('2005-12-02')})
RETURN p

// Update node property
MATCH (n {firstname: "Grace"}) SET n.birthday = date("2005-12-24") Return n;


// Get All nodes
MATCH (n) return n;

// Select Node
MATCH (pZakria:Person) WHERE pZakria.firstname = 'Zakria' RETURN pZakria;

// Create friendship between person nodes
MATCH p = 
  (pKalel:Person {firstname: "Kalel"}),
  (pLeo:Person {firstname: "Leo"}),
  (pDamian:Person {firstname: "Damian"}),
  (pSamuel:Person {firstname: "Samuel"})
CREATE (pKalel)-[ff:FRIENDS_WITH]->(pLeo),
(pLeo)-[ee:FRIENDS_WITH{since: date("2021-08-27")}]->(pKalel),
(pKalel)-[bb:FRIENDS_WITH]->(pDamian),
(pDamian)-[aa:FRIENDS_WITH{since: date("2021-08-27")}]->(pKalel),
(pKalel)-[cc:FRIENDS_WITH]->(pSamuel),
(pSamuel)-[gg:FRIENDS_WITH{since: date("2021-08-27")}]->(pKalel),
(pLeo)-[dd:FRIENDS_WITH]->(pDamian),
(pDamian)-[hh:FRIENDS_WITH{since: date("2021-08-27")}]->(pLeo),
(pLeo)-[ii:FRIENDS_WITH]->(pSamuel),
(pSamuel)-[jj:FRIENDS_WITH{since: date("2021-08-27")}]->(pLeo),
(pSamuel)-[kk:FRIENDS_WITH]->(pDamian),
(pDamian)-[ll:FRIENDS_WITH{since: date("2021-08-27")}]->(pSamuel)
RETURN aa

// Dynamically create relationship between all nodes
MATCH (e:Person), (c:Person)
WHERE ID(e) > -1 
 AND e.firstname <> c.firstname AND EXISTS((e)-[:FRIENDS_WITH]->(c)) = false
 AND EXISTS((c)-[:FRIENDS_WITH]->(e)) = false 

CREATE (e)-[r:FRIENDS_WITH]->(c), (c)-[rel:FRIENDS_WITH]->(e);

// Delete friendship
MATCH (pKalel:Person {firstname: 'Kalel'})-[r:DATING{since: date("2021-08-27")}]->(pZakria:Person {firstname: 'Zakria'})
DELETE r

// Add relationship to existing nodes
MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
return pKalel, pZakria;

// Delete Node and it's relationships
MATCH (uAron: User) WHERE ID(uAron) = 4 DETACH DELETE uAron;

//Query for people with same birthdates 
MATCH (n:Person), (c:Person) WHERE n.firstname <> c.firstname AND n.birthday = c.birthday CREATE (n)-[HAS_SAME_BDAY_AS]->(c) return c, n