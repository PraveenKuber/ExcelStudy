package com.EStudy.manager;

import com.mongodb.*;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.result.UpdateResult;
import org.bson.Document;
import org.omg.CORBA.portable.ApplicationException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

;

/**
 * Created by Praveen on 24/02/19.
 */
public class MongoPersistenceManager {
    private static MongoPersistenceManager persistenceManager = null;
    private String username;
    private String password;
    private String dbName;
    private String ipAddress;
    private int port;
    private MongoClient mongoClient = null;
    private MongoDatabase mongoDatabase = null;
    private DB dataBase = null;


    private MongoPersistenceManager() {
        /*Config config = Config.getInstance();
        try {
            this.username = config.getConfig("estudy.mongodb.username");
            this.password = config.getConfig("estudy.mongodb.password");
            this.dbName = config.getConfig("estudy.mongodb.dbName");
            this.ipAddress = config.getConfig("estudy.mongodb.ip");
            this.port = Integer.parseInt(config.getConfig("estudy.mongodb.port"));


            MongoCredential mongoCredential = MongoCredential.createCredential(username, dbName, password.toCharArray());

            //Added recent by Hemanth to ensure DB connection is not lost even during idle time.
            MongoClientOptions.Builder optionsBuilder = new MongoClientOptions.Builder();
            optionsBuilder.maxConnectionIdleTime(0);
            optionsBuilder.maxConnectionLifeTime(0);
            MongoClientOptions options = optionsBuilder.build();

            this.mongoClient = new MongoClient(new ServerAddress(ipAddress, port), Arrays.asList(mongoCredential),options);
            this.mongoDatabase = mongoClient.getDatabase(dbName);
            this.dataBase = mongoClient.getDB(dbName);
        } catch (Exception e) {
            System.out.println(e);
        }*/


        this.mongoClient = new MongoClient("localhost", 27017);
        this.mongoDatabase = mongoClient.getDatabase("estudy");
        this.dataBase = mongoClient.getDB("estudy");
    }

    public static synchronized MongoPersistenceManager getInstance() {
        if (persistenceManager == null) {
            persistenceManager = new MongoPersistenceManager();
        }
        return persistenceManager;
    }

    public void closeConnection() {
        if (mongoClient != null) {
            mongoClient.close();
        }
    }
    /* Insert operations */
    /*id field is assigned implicitly by Mongo and it is of 12 bytes divided as _id: ObjectId(4 bytes timestamp, 3 bytes machine id, 2 bytes process id, 3 bytes incrementer)*/

    /* For latest version of MongoDB */
    public void insertOneDocument(String collectionName, Document document) {
        String id = "" + document.get("_id");
        if (id == null) {
            document.remove("_id");
        }
        MongoCollection mongoCollection = mongoDatabase.getCollection(collectionName);
        mongoCollection.insertOne(document);
    }

    public void insertManyDcoument(String collectionName, List<Document> documents) {
        for (Document document : documents) {
            String id = (String) document.get("_id");
            if (id == null) {
                document.remove("_id");
            }
        }
        MongoCollection mongoCollection = mongoDatabase.getCollection(collectionName);
        mongoCollection.insertMany(documents);
    }

    /* For older versions of MongoDB */
    public WriteResult insertBasicDBObject(String collectionName, DBObject dBObject) {
        String id = (String) dBObject.get("_id");
        if (id == null) {
            dBObject.removeField("_id");
        }
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.insert(dBObject);
    }

    public WriteResult insertManyBasicDBObject(String collectionName, List<DBObject> dbObjectList) {
        for (DBObject dbObject : dbObjectList) {
            String id = (String) dbObject.get("_id");
            if (id == null) {
                dbObject.removeField("_id");
            }
        }
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.insert(dbObjectList);
    }

    public WriteResult insertBasicDBObjectBuilder(String collectionName, BasicDBObjectBuilder basicDBObjectBuilder) {
        String id = (String) basicDBObjectBuilder.get().get("_id");
        if (id == null) {
            basicDBObjectBuilder.get().removeField("_id");
        }
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.insert(basicDBObjectBuilder.get());
    }

    public WriteResult insertMap(String collectionName, Map documentMap) {
        String id = (String) documentMap.get("_id");
        if (id == null) {
            documentMap.remove("_id");
        }
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.insert(new BasicDBObject(documentMap));
    }

    /*public WriteResult insertJSON(String collectionName, String json) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        DBObject dbObject = (DBObject) JSON.parse(json);
        return dbCollection.insert(dbObject);
    }*/

    /* Read operations */

    /*
    MongoDB provides an implicit AND operation when specifying a comma separated list of expressions.
    Using an explicit AND with the $and operator is necessary when the same field or operator has to be specified in multiple expressions.
     */

    public DBCursor searchEntity(String collectionName, DBObject dbObject) {
        DBCollection collection = dataBase.getCollection(collectionName);
        DBCursor cursor = collection.find(dbObject);
        return cursor;
    }

    public DBCursor searchEntity(String collectionName) {
        DBCollection collection = dataBase.getCollection(collectionName);
        return collection.find();
    }

    public DBCursor searchEntityByCriteria(String collectionName, DBObject query, DBObject fields) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find(query, fields);
    }


    public DBCursor searchEntityWithSkipAndLimit(String collectionName, int skipSize, int limitSize) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find().skip(skipSize).limit(limitSize);
    }


    public DBCursor searchEntityByCriteriaAndLimit(String collectionName, DBObject query, DBObject fields, int skipSize, int limitSize) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find(query, fields).skip(skipSize).limit(limitSize);
    }

    public DBCursor limitResults(String collectionName, DBObject query, DBObject sortObject, int skipSize, int limitSize) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find(query).sort(sortObject).skip(skipSize).limit(limitSize);
    }

    public Object searchMaxValueOfAField(String collectionName, String fieldName) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        BasicDBObject sortObject = new BasicDBObject();
        sortObject.append(fieldName, -1);
        DBCursor cursor = dbCollection.find().sort(sortObject).limit(1);
        while (cursor.hasNext()) {
            Object maxValue = cursor.next().get(fieldName);
            return maxValue;
        }
        return null;
    }

    public DBCursor limitResults(String collectionName, DBObject query, DBObject fields, DBObject sortObject, int skipSize, int limitSize) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find(query, fields).sort(sortObject).skip(skipSize).limit(limitSize);
    }

    public DBCursor searchEntityByORCriterion(String collectionName, List<BasicDBObject> query, DBObject fields) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        DBObject whereQuery = new BasicDBObject();
        whereQuery.put("$or", query);
        return dbCollection.find(whereQuery, fields);
    }

    public DBObject searchAndModifyEntityBasedOnCriteria(String collectionName, DBObject query, DBObject update) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.findAndModify(query, update);
    }


    /* Update operations*/

    /*
    Entire document is replaced with another new document if modifiers like $set, $inc etc not used in update query object
     */
    public WriteResult updateOneBasicDBObject(String collectionName, DBObject searchQuery, DBObject updateQuery) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.update(searchQuery, updateQuery);
    }

    public WriteResult upsertOneBasicDBObject(String collectionName, DBObject searchQuery, DBObject updateQuery) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.update(searchQuery, updateQuery, true, false);
    }

    public WriteResult upsertMultipleBasicDBObject(String collectionName, DBObject searchQuery, DBObject updateQuery) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.update(searchQuery, updateQuery, true, true);
    }

    public WriteResult updateMultiBasicDBObject(String collectionName, DBObject searchQuery, DBObject updateQuery) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.updateMulti(searchQuery, updateQuery);
    }

    public WriteResult updateOrInsert(String collectionName, DBObject searchObject, DBObject modifiedObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.update(searchObject, modifiedObject, true, false);
    }

    public boolean collectionExists(String collectionName) {
        return dataBase.collectionExists(collectionName);
    }

    /**
     * Added by Chandan for latest Mongo DB versions
     * This Method is used to
     *
     * @param collectionName
     * @param newDocument
     * @param newDocument
     * @return Count of documents updated
     */
    public boolean updateOneDocument(String collectionName, Document searchCriteria, Document newDocument) {
        try {
            MongoCollection mongoCollection = mongoDatabase.getCollection(collectionName);
            UpdateResult updateResult = mongoCollection.updateOne(searchCriteria, newDocument);
            return (updateResult.getModifiedCount() > 0);
        } catch (Exception e) {
            //ApplicationException applicationException = new ApplicationException(GenericErrorCode.UNABLE_TO_UPDATE, "Unable to update document in database with search criteria: " + searchCriteria.toString(), e);
           // throw applicationException;
            return false;
        }
    }

    /**
     * Added by Chandan for latest Mongo DB versions
     *
     * @param collectionName
     * @param searchCriteria
     * @param newDocument
     * @return Count of documents replaced
     */
    public boolean replaceOneDocument(String collectionName, Document searchCriteria, Document newDocument) throws ApplicationException {
        try {
            MongoCollection mongoCollection = mongoDatabase.getCollection(collectionName);
            UpdateResult updateResult = mongoCollection.replaceOne(searchCriteria, newDocument);
            return (updateResult.getModifiedCount() > 0);
        } catch (Exception e) {
            //ApplicationException applicationException = new ApplicationException(GenericErrorCode.UNABLE_TO_REPLACE, "Unable to replace document in database with search criteria: " + searchCriteria.toString(), e);
            //logger.error(applicationException);
            //throw applicationException;
            return false;
        }
    }

    /*
    The save() method uses either the insert or the update command.
    If document does not contain an _id field, then the save() method calls the insert() method
     else update() with  upsert option set to true and the query predicate on the _id field.
     Note when upsert:true,update will replace the document
     */
    public WriteResult saveBasicDBObject(String collectionName, DBObject dbObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.save(dbObject);
    }

    /* Delete operations */
    public WriteResult deleteBasicDbObject(String collectionName, DBObject dbObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.remove(dbObject);
    }

    public DBObject deleteBasicDbObjectBasedOnCriteria(String collectionName, DBObject query) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.findAndRemove(query);
    }




    public void createIndex(String collectionName, BasicDBObject basicDBObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        dbCollection.createIndex(basicDBObject);
    }

    public void createIndex(String collectionName, BasicDBObject basicDBObject, DBObject options) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        dbCollection.createIndex(basicDBObject, options);
    }
    public void dropIndexes(String collectionName) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        dbCollection.dropIndexes();
    }

    public DBCollection createCollection(String collectionName) {
        DBCollection dbCollection = null;
        if(!dataBase.collectionExists(collectionName)) {
            dbCollection = dataBase.createCollection(collectionName, new BasicDBObject());
        } else {
            dbCollection = dataBase.getCollection(collectionName);
        }
        return dbCollection;
    }

    public DBObject getConfigEntry(String key) {
        DBObject dbObject = null;
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("key", key);
        DBCursor dbCursor = searchEntityByCriteria("Config", whereQuery, new BasicDBObject("_id", 0));
        while (dbCursor.hasNext()) {
            dbObject = dbCursor.next();
        }
        return dbObject;
    }

    public String getConfigValue(String key) {
        BasicDBObject whereQuery = new BasicDBObject();
        whereQuery.put("key", key);
        DBCursor dbCursor = searchEntityByCriteria("Config", whereQuery, new BasicDBObject("_id", 0));
        if (dbCursor.hasNext()) {
            return dbCursor.next().get("value").toString();
        }
        return null;
    }

    public DBCursor getCustomObject(String collectionName, BasicDBObject basicDBObject) {
        DBCollection collection = dataBase.getCollection(collectionName);
        DBCursor cursor = collection.find(basicDBObject);
        return cursor;
    }

    public DBCursor searchSpecificColumns(String collectionName, BasicDBObject searchCriteria, BasicDBObject fieldVisiblity) {
        DBCollection collection = dataBase.getCollection(collectionName);
        DBCursor cursor = collection.find(searchCriteria, fieldVisiblity);
        return cursor;
    }

    /*Utility Operations*/
    public long getCountOfCollection(String collectionName) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.getCount();
    }

    public int getCountOfCollection(String collectionName, DBObject searchObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.find(searchObject).count();
    }

    public void dropCollection(String collectionName) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        dbCollection.drop();
    }

    /**
     * @param source     - Rename the source collection
     * @param target     - To target collection name
     * @param dropTarget - Drops the target collection if exists before renaming, if dropTarget is true
     *                   Otherwise, rename API will result in error if dropTarget is false and the target
     *                   collection exists
     */
    public void renameCollection(String source, String target, boolean dropTarget) {
        DBCollection dbCollection = dataBase.getCollection(source);
        dbCollection.rename(target, dropTarget);
    }

    public List distinctQuery(String collectionName, String fieldName, DBObject dbObject) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.distinct(fieldName, dbObject);
    }

    public List distinctQuery(String collectionName, String fieldName) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.distinct(fieldName);
    }

    public AggregationOutput aggregate(String collectionName, List<DBObject> pipeline) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.aggregate(pipeline);
    }

    public Cursor aggregate(String collectionName, List<DBObject> pipeline, AggregationOptions options) {
        DBCollection dbCollection = dataBase.getCollection(collectionName);
        return dbCollection.aggregate(pipeline, options);
    }

    public void copyCollection(String sourceCollection, String targetCollection) {
        DBCollection sourceCol = dataBase.getCollection(sourceCollection);
        DBCollection targetCol = dataBase.getCollection(targetCollection);
        if (sourceCol != null && targetCol != null) {
            DBCursor cursor = sourceCol.find();
            try {
                while (cursor.hasNext()) {
                    targetCol.insert(cursor.next());
                }
            } finally {
                cursor.close();
            }
        }

    }


    public List<String> getCollections() {
        Set<String> collections = dataBase.getCollectionNames();
        List<String> finalCollections = null;
        if(collections!=null && !collections.isEmpty()) {
            finalCollections = new ArrayList<String>(collections);
        }
        return finalCollections;
    }
}
