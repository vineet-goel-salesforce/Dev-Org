/**
 * @description       : This class has methods that shows how to fetch ObjectNames using Entity Definition(200 rows only)
                        Usage of platform cache to showcase the performance gains
 * @author            : Vineet Goel
**/
public with sharing class ObjectNameController {

        public static final String PARTITION_NAME = 'ObjectData';

        /**
         * @description Gets list of object API name and label for 200 objects using SOQL on EntityDefinition object
         * @author Vineet Goel
         * @return List<Options>
         **/
        @AuraEnabled(cacheable=true)
        public static List<ObjectOptions> objectNamesbySOQL(){
              List<ObjectOptions> objectNames = new List<ObjectOptions>();
                try{
                        for (EntityDefinition obj : [
                        SELECT QualifiedApiName, Label
                        FROM EntityDefinition 
                        WHERE Label != '__MISSING LABEL__ PropertyFile - val ChannelProgramMember not found in section StandardFeedLabel'
                        ORDER BY Label
                        LIMIT 200
                        ]) {
                        objectNames.add(new ObjectOptions(obj.Label, obj.QualifiedApiName));
                        }
                        system.debug('objectNames'+objectNames.size());
                        system.debug('objectNames>>>'+objectNames);
                }catch (exception e) {
                        throw new AuraHandledException(e.getMessage());
                        }
                return objectNames;
        }

        /**
         * @description Gets list of object API name and label using Cache Utility (Cache Builder Interface)
         *              This method show how to leverage org cache and use cache builder interface for handling cache misses
         * @author Vineet Goel
         * @return List<Options>
         **/
        @AuraEnabled(cacheable=true)
        public static List<ObjectOptions> objectNamesbyCacheBuilderInterface(){
                List<ObjectOptions> objectNames = new List<ObjectOptions>();
                try {
                        // Instantiate partition
                        Cache.OrgPartition orgPartition = Cache.Org.getPartition(
                                PARTITION_NAME
                        );
                        if (orgPartition != null) {
                        objectNames = (List<ObjectOptions>) orgPartition.get(
                                ObjectCacheBuilder.class,
                                'objectlist'
                        );
                        }
                } catch (exception e) {
                        throw new AuraHandledException(e.getMessage());
                }
                return objectNames;
        }

        
        /**
         * @description Gets list of object API name and label using Cache 
         * 		    The method shows how to use org cache and handle cache miss and specify TTL
         * @author Vineet Goel
         * @return List<Options>
         **/
        @AuraEnabled(cacheable=true)
        public static List<ObjectOptions> objectNamesFromCache() {
        List<ObjectOptions> objectNames = new List<ObjectOptions>();
                try {
                        // Instantiate partition
                        Cache.OrgPartition orgPartition = Cache.Org.getPartition(
                                PARTITION_NAME
                        );
                        if (orgPartition != null) {
                                // Load from Cache
                                if (orgPartition.get('objectlistcache') != null) {
                                objectNames = (List<ObjectOptions>) orgPartition.get(
                                        'objectlistcache'
                                );
                                } else {
                                List<ObjectNameController.ObjectOptions> cacheObjectnames = new List<ObjectNameController.ObjectOptions>();
                                for (EntityDefinition obj : [
                                        SELECT QualifiedApiName, Label
                                        FROM EntityDefinition
                                        WHERE Label != '__MISSING LABEL__ PropertyFile - val ChannelProgramMember not found in section StandardFeedLabel'
                                        ORDER BY Label
                                        LIMIT 200
                                        ]) {
                                        cacheObjectnames.add(new ObjectOptions(obj.Label, obj.QualifiedApiName));
                                        }
                                //Putting values into the org partition
                                orgPartition.put(
                                        'objectlistcache',
                                        cacheObjectnames,
                                        300,
                                        Cache.Visibility.ALL,
                                        true
                                );
                                return cacheObjectnames;
                                }
                        }
                } catch (exception e) {
                throw new AuraHandledException(e.getMessage());
                }
                return objectNames;
        }

        public class ObjectOptions implements Comparable{
                @AuraEnabled
                public String label{get;set;}
                public String value{get;set;}
                
                public ObjectOptions(String label, String apiName){
                        this.label = label;
                        this.value = apiName;
                }
                public Integer compareTo(Object ObjectComparison){
                        return label.CompareTo(((ObjectOptions) ObjectComparison).label);
                }
                
        }
}