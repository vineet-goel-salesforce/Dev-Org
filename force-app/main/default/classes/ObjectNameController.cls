/**
 * @description       : This class has methods that shows how to fetch ObjectNames, Entity Definition(200 rows only)
                        We use platform cache to showcase the performance gains
 * @author            : Vineet Goel
**/
public with sharing class ObjectNameController {
        @AuraEnabled
        public static string methodName(){
                String PARTITION_NAME = 'ObjectData';
                system.debug('test');
                return PARTITION_NAME;
        }
}