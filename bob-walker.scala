object bobWalker {

  def main(args: Array[String]) {
    val bobModes = process(args)
    startBob(bobModes)
  }

  def process(args: Array[String]): Array[String] = {
    val allArgs: Array[Char] = args.flatMap(x => x)
    val bobModes = for {
      x <- allArgs
    } yield addMode(x)
    bobModes.flatMap(x => x)
  }

  def addMode(letter: Char): Array[String] = {
    var newModes: Array[String] = Array[String]("beard", "beer", "pie")
    letter match {
      case 'd' =>
        println("Drunk mode not yet enabled")
      case 'p' =>
        newModes = newModes :+ "chef" :+ "perl" :+ "CPAN"
      case 's' => 
        newModes = newModes :+ "rugby" :+ "cricket"
      case 'x' =>
        newModes = newModes :+ "mince pies" :+ "reindeer"
      case _   =>
        // if we do not have a case for the character
        // then do nothing
    }
    newModes
  }

  def startBob(bobModes: Array[String]) = {
    var i = 0
    while (i < 1000000000) {
      printBob(bobModes)
      i = i + 1
    }
  }

  def printBob(bobModes: Array[String]) = {
    for {
      x <- bobModes
    } println(x)
  }

}
