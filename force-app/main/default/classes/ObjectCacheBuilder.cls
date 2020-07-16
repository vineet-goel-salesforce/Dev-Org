/**
 * @description       : A Utility class that implement CacheBuilder Interface for SOQL
 * @author            : Vineet Goel
 **/

public with sharing class ObjectCacheBuilder implements Cache.CacheBuilder {
    /**
     * @description Salesforce defined method to load data in Cache
     * @author Vineet Goel
     * @param key
     * @return Object
     **/
    public Object doLoad(String key) {
        List<ObjectNameController.ObjectOptions> objectNames = new List<ObjectNameController.ObjectOptions>();
        for (EntityDefinition obj : [
            SELECT QualifiedApiName, Label
            FROM EntityDefinition
            WHERE Label != '__MISSING LABEL__ PropertyFile - val ChannelProgramMember not found in section StandardFeedLabel'
            ORDER BY Label
            LIMIT 200
        ]) {
            objectNames.add(
                new ObjectNameController.ObjectOptions(
                    obj.Label,
                    obj.QualifiedApiName
                )
            );
        }
        return objectNames;
    }
}