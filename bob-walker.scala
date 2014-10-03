final case object bobwalker {

  def main(args: Array[String]) {
    val bob_modes = process(args)
    start_bob(bob_modes)
  }

  def process(args: Array[String]): Array[String] = {
    val all_args: Array[Char] = args.flatMap(x => x)
    val bob_modes = for {
      x <- all_args
    } yield add_mode(x)
    bob_modes.flatMap(x => x)
  }

  def add_mode(letter: Char): Array[String] = {
    var new_modes: Array[String] = Array[String]("beard", "beer", "pie")
    letter match {
      case 'd' =>
        println("Drunk mode not yet enabled")
      case 'p' =>
        new_modes = new_modes :+ "chef" :+ "perl" :+ "CPAN"
      case 's' => 
        new_modes = new_modes :+ "rugby" :+ "cricket"
      case 'x' =>
        new_modes = new_modes :+ "mince pies" :+ "reindeer"
      case _   => //do nothing
    }
    new_modes
  }

  def start_bob(bob_modes: Array[String]) = {
    var i = 0
    while (i < 1000000000) {
      print_bob(bob_modes)
      i = i + 1
    }
  }

  def print_bob(bob_modes: Array[String]) = {
    for {
      x <- bob_modes
    } println(x)
  }

}
