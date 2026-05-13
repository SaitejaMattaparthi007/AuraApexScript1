private void bar() {
     buz('Howdy');  //Bad: the String 'Howdy' could be declared as a constant field.
     buz('Howdy');
     buz('Howdy');
     buz('Howdy');
 }

 private void buz(String x) {}
