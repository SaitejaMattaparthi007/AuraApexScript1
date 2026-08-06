    public void directLiteral(String name) {
        Database.query('SELECT Id FROM Contact WHERE Name = :name');
    }
