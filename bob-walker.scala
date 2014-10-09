object bobWalker {

  def main(args: Array[String]) {
    val bobModes = process(args.toSeq)
    startBob(bobModes)
  }

  def process(args: Seq[String]): Seq[String] = {
    val allArgs: Seq[Char] = args.flatMap(x => x)
    val bobModes: Seq[String] = for {
      arg <- allArgs
      modes <- addMode(arg)
    } yield modes
    bobModes :+ "beard" :+ "beer" :+ "pie"
  }

  def addMode(letter: Char): Seq[String] = {
    var newModes: Seq[String] = Seq[String]()
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

  def startBob(bobModes: Seq[String]) = {
    var i = 0
    while (i < 1000000000) {
      printBob(bobModes)
      i = i + 1
    }
  }

  def printBob(bobModes: Seq[String]) = {
    for {
      x <- bobModes
    } println(x)
  }

}
