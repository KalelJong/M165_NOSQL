// Get all nodes and their relationships
MATCH (n) return n

// SCENARIO 1
// Kalel would to see all his friends 
MATCH
 (pKalel: Person {firstname: "Kalel"})-[friendship:FRIENDS_WITH]-(friends: Person)
RETURN
 pKalel,friendship,friends;

// SCENARIO 2
// Kalel isn't friends with Jonathan anymore
 MATCH 
  (pKalel: Person {firstname: "Kalel"})-[friendship:FRIENDS_WITH]-(pJohnny:Person{firstname:"Jonathan"}) 
 DELETE
 friendship
 return pKalel, pJohnny;

// SCENARIO 3
// Kalel would like to know which of his friends have the same music taste as him
MATCH 
 (pKalel:Person {firstname:"Kalel"})-[friendship:FRIENDS_WITH]-(friends: Person)
MATCH kalelTaste =
 (pKalel)-[:LISTENS_TO]-(genre: Hobby {hobby: "music"})
MATCH friendsTaste =
 (friends)-[:LISTENS_TO]-(genre: Hobby {hobby: "music"})
 RETURN kalelTaste, friendsTaste; 

// SCENARIO 4
// Zakria would like to find new people who play the same game genres as him to play with
MATCH zakriasGames =
  (pZakria:Person{firstname:"Zakria"})-[:PLAYS]-(games:Hobby{hobby:"gaming"})
MATCH peoplesGames =
  (person:Person)-[:PLAYS]-(games:Hobby{hobby:"gaming"})
WHERE EXISTS((pZakria)-[:FRIENDS_WITH]-(person)) = false
return zakriasGames, peoplesGames

// SCENARIO 5
// Get people who go to the BMZ and TBZ
MATCH (p:Person)-[:ATTENDS_TO]->(s:School)
WHERE s.name = "BMZ Berufmaturitätsschule Zürich" OR s.name = "TBZ Technische Berufsschule Zürich"
RETURN p, s

//SCENARIO 6
// Get people with the same birthdates
MATCH 
  (n:Person), (c:Person)
WHERE 
  n.firstname <> c.firstname 
  AND
  n.birthday = c.birthday
RETURN c, n

//SCENARIO 7
// Kalel became friends with Jonathan again
MATCH
  (pKalel:Person {firstname: "Kalel"}),
  (pJohnny:Person {firstname: "Jonathan"})
CREATE
 (pKalel)-[:FRIENDS_WITH]->(pJohnny), (pJohnny)-[:FRIENDS_WITH]->(pKalel)
RETURN
 pKalel, pJohnny;

 //SCENARIO 8
 // GET People who play an instrument
 MATCH
    (people:Person)-[:PLAYS]->(instrument:Hobby{hobby:"instrument"})
RETURN
people,instrument