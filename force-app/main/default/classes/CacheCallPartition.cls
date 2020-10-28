public with sharing class CacheCallPartition {
        public static final String PARTITION_NAME = 'ObjectData';
    
        @AuraEnabled(cacheable=true)
        public static List<ObjectOptions> CacheCallPartition(String charName) {
                return ((List<ObjectOptions>)Cache.Org.getPartition(PARTITION_NAME))?.get(charName);
                    }
        
        public class ObjectOptions implements Comparable{
            @AuraEnabled
            public String label{get;set;}
            public String value{get;set;}
            
            public ObjectOptions(String label, String apiName){
                    this.label = label;
                    this.value = apiName;
            }
            public Integer compareTo(Object objectComparison){
                    return label.CompareTo(((ObjectOptions) ObjectComparison).label);
            }
            
    }
    }
    