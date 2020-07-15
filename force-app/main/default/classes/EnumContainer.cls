global class EnumContainer{ 
  
    global enum ObjectType {ISUNKNOWN, ISACCOUNT, ISLEAD, ISOPPORTUNITY, ISCONTACT}
    
    public static EnumContainer.ObjectType GetObjectType(String objectId){
      EnumContainer.ObjectType objectType = EnumContainer.ObjectType.ISUNKNOWN;
      if (objectID != null){            
            Schema.Describesobjectresult result = Schema.SObjectType.Lead;
            if (ObjectID.startsWith(result.getKeyPrefix())){
                    //- We have an Lead ID
                    objectType = EnumContainer.ObjectType.ISLEAD;                            
            }else{
                result = Schema.SObjectType.Contact;
                if (ObjectID.startsWith(result.getKeyPrefix())){
                    //- We have a Contact ID
                    objectType = EnumContainer.ObjectType.ISCONTACT;                    
                }else{                    
                    result = Schema.SObjectType.Opportunity;        
                    if (ObjectID.startsWith(result.getKeyPrefix())){
                        //- We have an Opportunity ID
                        objectType = EnumContainer.ObjectType.ISOPPORTUNITY;                                    
                    }else{
                        result = Schema.SObjectType.Account;                    
                        if (ObjectID.startsWith(result.getKeyPrefix())){
                            //- We have an Account ID
                            objectType = EnumContainer.ObjectType.ISACCOUNT;               
                        }        
                    }                    
                }
            }           
        }
        return objectType;
    }
    
}