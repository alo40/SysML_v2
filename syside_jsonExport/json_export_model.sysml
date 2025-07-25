package 'JSON Export Example' {
  part def Electrical;
  part def Mechanical;

  part Automobile {
    part 'Drive Train' : Electrical;
    part Chassis : Mechanical;
  }
}