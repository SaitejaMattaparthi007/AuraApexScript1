    public void apiCoverage(String p1, String p2, String p3) {
        // Database.query
        Database.query('SELECT Id FROM Lead WHERE Email = :p1');
        
        // Database.getQueryLocator
        Database.getQueryLocator('SELECT Id FROM Task WHERE Subject = :p2');
        
        // Custom/Standard setCondition
        QueryBuilder qb = new QueryBuilder();
        qb.setCondition('Phone = :p3');
    }
