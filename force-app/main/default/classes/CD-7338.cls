public MyController {
  private interface Implementation{
    void run();
  }
  private class AdminImplementation implements Implementation{
    public void run(){
      ... do something privileged
    }
  }
  private class StandardImplementation implements Implementation{
    public void run(){
	  ... normal implementation
    }
  }

  public void init(){
    Implementation i = Type.forName(implementationName);
      i.run(); //Bad: This unchecked implementation could lead to unexpectedly running the AdminImplementation code.
  }

}
