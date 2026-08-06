public void partialUsage(String p1, String p2) {
    String queryStr = 'SELECT Id FROM Account WHERE Field1 = :p1';
    Database.query(queryStr); 
}

private void partialUsage(String p1, String p2) {
    String queryStr = 'SELECT Id FROM Account WHERE Field1 = :p1';
    Database.query(queryStr);
}
