    public void basicVariableUsage(String name) {
        String cond = 'Name = :name', 'Name2 = :name2';
        QueryBuilder query = new QueryBuilder();
        query.setCondition(cond); // 'name' is used in 'cond'
    }
