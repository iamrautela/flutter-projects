void main() {
  print(3 + 2);
  print(3 - 1);
  print(3 * 2);
  print(10 / 2);

  //EDGE CASE: beacuse dart consists this as text and + considered as addition of two strings
  print('3' + '2');
  print(
    '3' * 2,
  ); //it will give 33 beacuse it will consider 3 as string and multiply it two times
  print(5 / 4 + 2 - 4 * 2); //BODMAS rule will be applied as it follow operator precidence

  print(75 / (5 + 2));
  print(75 / 5 + 2);
}

/* This is a multi-line comment
*/
