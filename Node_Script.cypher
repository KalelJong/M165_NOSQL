
// Create nodes
CREATE (pZakria:Person {firstname: 'Zakria', lastname: 'Samma', birthday: date('2005-11-30')}), 
	   (pKalel:Person {firstname: 'Kalel', lastname: 'Poeta', birthday: date('2005-01-03')}),
	   (pMolly:Person {firstname: 'Molly', lastname: 'Sapey', birthday: date('2006-04-13')}),
	   (pBecky:Person {firstname: 'Becky', lastname: 'Lee', birthday: date('2005-08-19')}),
	   (pMilena:Person {firstname: 'Milena', lastname: 'Soldato', birthday: date('2005-05-30')}),
	   (pAlex:Person {firstname: 'Alex', lastname: 'Kazmer', birthday: date('2004-10-26')}),
	   (pAkina:Person {firstname: 'Akina', lastname: 'Keates', birthday: date('2005-11-12')}),
	   (pJoseph:Person {firstname: 'Joseph', lastname: 'Boyse', birthday: date('2004-02-11')})

     
// Create with relationship
CREATE p = (pAron:Person {firstname: 'Aron', lastname: 'Heuberger', birthday: date('2005-12-02')})
-[ff:DATING {since: date("2022-07-01")}]->(pGrace: Person{firstname: 'Grace', lastname: 'Rose', birthday: date('2005-12-02')})
RETURN p

// Update node property
MATCH (n {firstname: "Grace"}) SET n.birthday = date("2005-12-24") Return n;

// Get All nodes and relationships
MATCH (n) return n;

// Select Node
MATCH (pZakria:Person) WHERE pZakria.firstname = 'Zakria' RETURN pZakria;

// Create relationship between all nodes
// Explanation: All people created until now are in the same friend group
MATCH (e:Person), (c:Person)
WHERE ID(e) > -1 
 AND e.firstname <> c.firstname AND EXISTS((e)-[:FRIENDS_WITH]->(c)) = false
 AND EXISTS((c)-[:FRIENDS_WITH]->(e)) = false 

CREATE (e)-[r:FRIENDS_WITH]->(c), (c)-[rel:FRIENDS_WITH]->(e);

// Adde person nodes from another friend group
CREATE (pLeo:Person {firstname: 'Leo', lastname: 'Barun', birthday: date('2005-10-02')}),
	   (pDamian:Person {firstname: 'Damian', lastname: 'Bloesser', birthday: date('2005-10-15')}),
	   (pSamuel:Person {firstname: 'Samuel', lastname: 'Sporer', birthday: date('2005-01-10')})
// Create friendship between person nodes
MATCH p = 
  (pKalel:Person {firstname: "Kalel"}),
  (pLeo:Person {firstname: "Leo"}),
  (pDamian:Person {firstname: "Damian"}),
  (pSamuel:Person {firstname: "Samuel"})
CREATE (pKalel)-[ff:FRIENDS_WITH]->(pLeo),
(pLeo)-[ee:FRIENDS_WITH]->(pKalel),
(pKalel)-[bb:FRIENDS_WITH]->(pDamian),
(pDamian)-[aa:FRIENDS_WITH]->(pKalel),
(pKalel)-[cc:FRIENDS_WITH]->(pSamuel),
(pSamuel)-[gg:FRIENDS_WITH]->(pKalel),
(pLeo)-[dd:FRIENDS_WITH]->(pDamian),
(pDamian)-[hh:FRIENDS_WITH]->(pLeo),
(pLeo)-[ii:FRIENDS_WITH]->(pSamuel),
(pSamuel)-[jj:FRIENDS_WITH]->(pLeo),
(pSamuel)-[kk:FRIENDS_WITH]->(pDamian),
(pDamian)-[ll:FRIENDS_WITH]->(pSamuel)
RETURN aa

// FIRST ADD HOBBIES FROM FILE hobby/createHobby.cypher

// Add relationship to hobbies
MATCH
  (pKalel:Person {firstname: "Kalel"}),
  (pMolly:Person {firstname: 'Molly'}),
  (pBecky:Person {firstname: 'Becky'}),
  (pMilena:Person {firstname: 'Milena'}),
  (pAlex:Person {firstname: 'Alex'}),
  (pAkina:Person {firstname: 'Akina'}),
  (pJoseph:Person {firstname: 'Joseph'}),
  (pAron:Person {firstname: 'Aron'}),
  (pGrace: Person {firstname: "Grace"}),
  (pZakria:Person {firstname: "Zakria"}),
  (pLeo:Person {firstname: "Leo"}),
  (pDamian:Person {firstname: "Damian"}),
  (pSamuel:Person {firstname: "Samuel"}),
  (mpb:Hobby{genre:"mpb"}),
  (shooter:Hobby {hobby:'gaming', genre:'shooter'}),
  (indie:Hobby {hobby:'music', genre:'indie'}),
  (bPop:Hobby {hobby:'music', genre:'bedroom pop'}),
  (alternative:Hobby {hobby:'music', genre:'alt-rock'}),
  (metal:Hobby {hobby:'music', genre: 'metal'}),
  (strat:Hobby {hobby:'gaming', genre:'strategie'}),
  (sandbox:Hobby {hobby:'gaming', genre:'sandbox'}),
  (fighting:Hobby {hobby:'gaming', genre:'fighting'}),
  (rock:Hobby {hobby:'music', genre:'rock'}),
  (pop:Hobby {hobby:'music', genre:'pop'}),
  (pp2000:Hobby {hobby:'music', genre:'early 2000s punk-pop'}),
  (jazz:Hobby {hobby:'music', genre:'jazz'}),
  (eguitar:Hobby {hobby:'instrument', type:"electric guitar"}),
  (aguitar:Hobby {hobby:'instrument', type:"acoustic guitar"}),
  (bguitar:Hobby {hobby:'instrument', type:"bass guitar"}),
  (piano:Hobby {hobby:'instrument', type:"keyboard/piano"}),
  (violin:Hobby {hobby:'instrument', type:"violin"})
CREATE (pKalel)-[:LISTENS_TO{artists:["Legiao Urbana", "Ben Jor", "Chico Buarque","Elis Regina"]}]->(mpb),
  (pKalel)-[:LISTENS_TO{artists:["Girl in red"]}]->(indie),
  (pKalel)-[:LISTENS_TO{artists:["Mother mother", "Scalene", "Radiohead", "Red hot chilli peppers"]}]->(alternative),
  (pKalel)-[:PLAYS{games: ["Overwatch", "Valorant"]}]->(shooter),
  (pMolly)-[:LISTENS_TO]->(alternative), (pMolly)-[:LISTENS_TO]->(bPop),
  (pJoseph)-[:LISTENS_TO]->(metal), (pJoseph)-[:LISTENS_TO]->(indie),
  (pGrace)-[:LISTENS_TO]->(pp2000), (pGrace)-[:LISTENS_TO]->(rock),
  (pAlex)-[:LISTENS_TO]->(rock),(pAlex)-[:LISTENS_TO]->(alternative),
  (pZakria)-[:PLAYS{games:["Valorant", "Overwatch"]}]->(shooter), (pZakria)-[:PLAYS{games:["Minecraft"]}]->(sandbox),
  (pZakria)-[:PLAYS{games:["Smash Bros."]}]->(fighting), (pGrace)-[:PLAYS{games:["Minecraft"]}]->(sandbox)
  (pZakria)-[:PLAYS{games:["Minecraft"]}]->(sandbox), (pJoseph)-[:PLAYS{games:["Minecraft"]}]->(sandbox), (pMolly)-[:PLAYS{games:["Minecraft"]}]->(sandbox),
  (pSamuel)-[:PLAYS{games:["Minecraft"]}]->(sandbox),(pDamian)-[:PLAYS{games:["Minecraft"]}]->(sandbox),(pLeo)-[:PLAYS{games:["Minecraft"]}]->(sandbox)
  (pBecky)-[:PLAYS{games:["Minecraft"]}]->(sandbox), (pAron)-[:PLAYS{games:["Minecraft"]}]->(sandbox), 
  (pAkina)-[:PLAYS{games:["Chess"]}]->(strat), (pAlex)-[:PLAYS{games:["Chess"]}]->(strat),
  (pKalel)-[:PLAYS]->(eguitar), (pKalel)-[:PLAYS]->(aguitar), (pKalel)-[:PLAYS]->(piano),
  (pAlex)-[:PLAYS]->(bguitar), (pAlex)-[:PLAYS]->(piano),
  (pAkina)-[:PLAYS]->(violin), 
  (pGrace)-[:PLAYS]->(aguitar),(pGrace)-[:PLAYS]->(eguitar)

// FIRST ADD SCHOOLS FROM FILE school/createSchools.cypher
MATCH
  (pKalel:Person {firstname: "Kalel"}),
  (pMolly:Person {firstname: 'Molly'}),
  (pBecky:Person {firstname: 'Becky'}),
  (pMilena:Person {firstname: 'Milena'}),
  (pAlex:Person {firstname: 'Alex'}),
  (pAkina:Person {firstname: 'Akina'}),
  (pJoseph:Person {firstname: 'Joseph'}),
  (pAron:Person {firstname: 'Aron'}),
  (pGrace: Person {firstname: "Grace"}),
  (pZakria:Person {firstname: "Zakria"}),
  (pLeo:Person {firstname: "Leo"}),
  (pDamian:Person {firstname: "Damian"}),
  (pSamuel:Person {firstname: "Samuel"}),
  (tbz:School {name:"TBZ Technische Berufsschule Zürich"}),
  (mng:School{name: "MNG Kantonsschule Rämibühl"}),
  (bmz:School{name: "BMZ Berufmaturitätsschule Zürich"}),
  (gbw:School{name: "Gewerbliche Berufsschule Wetzikon"}),
  (bu:School {name: "Bildungszentrum Uster"}),
  (hs:School{name: "Hull's School"}),
  (hmz:School{name: "Handelsmittelschule Zürich"})

CREATE (pKalel)-[:ATTENDS_TO]->(tbz),(pZakria)-[:ATTENDS_TO]->(tbz),(pAron)-[:ATTENDS_TO]->(tbz),
(pKalel)-[:ATTENDS_TO]->(bmz), (pZakria)-[:ATTENDS_TO]->(bmz), (pAron)-[:ATTENDS_TO]->(bmz),
(pJoseph)-[:ATTENDS_TO]->(bu), (pMilena)-[:ATTENDS_TO]->(gbw), (pGrace)-[:ATTENDS_TO]->(tbz),
(pAkina)-[:ATTENDS_TO]->(hs), (pAlex)-[:ATTENDS_TO]->(mng),(pBecky)-[:ATTENDS_TO]->(mng),
(pLeo)-[:ATTENDS_TO]->(hmz),(pDamian)-[:ATTENDS_TO]->(hmz),(pSamuel)-[:ATTENDS_TO]->(hmz)

// Delete friendship
MATCH (pKalel:Person {firstname: 'Kalel'})-[r:FRIENDS_WITH]->(pZakria:Person {firstname: 'Zakria'})
DELETE r

// Add relationship to existing nodes
MATCH
  (pKalel:Person),
  (pZakria:Person)
WHERE pKalel.firstname = 'Kalel' AND pZakria.firstname = 'Zakria'
CREATE (pKalel)-[:FRIENDS_WITH]->(pZakria), (pZakria)-[:FRIENDS_WITH]->(pKalel)
return pKalel, pZakria;

// Delete Node and it's relationships
MATCH (uAron: User) WHERE ID(uAron) = 4 DETACH DELETE uAron;

//Query for people with same birthdates and create re
MATCH (n:Person), (c:Person) WHERE n.firstname <> c.firstname AND n.birthday = c.birthday return c, n