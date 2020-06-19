// Create airlines

// CREATE CONSTRAINTS
CREATE CONSTRAINT ON (a:Airline) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Airport) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Group) ASSERT a.name IS UNIQUE;
CREATE CONSTRAINT ON (a:Handler) ASSERT a.name IS UNIQUE;


// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/airlines.csv" AS line
MERGE (:Airline {name: line.Nom});

// Create airports
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/airports.csv" AS line
MERGE (:Airport {name: line.Nom});

// Create groups
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/groups.csv" AS line
MERGE (:Group {name: line.Nom});

// Create handlers
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/handlers.csv" AS line
MERGE (:Handler {name: line.Nom});

// Create relationShip Airline-Handler
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/airlineHandler.csv" AS line
MATCH (a:Airline {name: line.Airline})
MATCH (h:Handler {name: line.Handler})
MERGE (a)-[:HandlingContract]->(h);

// Create relationShip Handler-Airport
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/handlersAirports.csv" AS line
MATCH (h:Handler {name: line.Handler})
MATCH (a:Airport {name: line.Airport})
MERGE (h)-[:isLocatedOn]->(a);

// Create relationShip Handler-Group
// USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nrouyer/handler/master/handlergroup.csv" AS line
MATCH (h:Handler {name: line.Handler})
MATCH (g:Group {name: line.Group})
MERGE (h)-[:isPartOf]->(g);
