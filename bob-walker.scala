object bobWalker {

  var drunk = false

  def main(args: Array[String]) {
    val bobModes = process(args.toSeq)
    val hydratedBobModes = hydrate(bobModes)
    startBob(hydratedBobModes)
  }

  def process(args: Seq[String]): Seq[String] = {
    val bobModes: Seq[String] = for {
      arg <- args
      char <- arg
      modes <- addMode(char)
    } yield modes
    bobModes :+ "beard" :+ "beer" :+ "pie"
  }

  def addMode(letter: Char): Seq[String] = {
    var newModes: Seq[String] = Seq[String]()
    letter match {
      case 'd' =>
        drunk = true
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

  def hydrate(bobModes: Seq[String]) = {
    if (drunk) {
      bobModes.map( word  => word.replace("e", "eee") )
    } else {
      bobModes
    }
  }

  def startBob(bobModes: Seq[String]) = {
    for (i <- 1 until 1000000000) {
      printBob(bobModes)
      if (drunk) { Thread.sleep(2000) }
    }
  }

  def printBob(bobModes: Seq[String]) = {
    for {
      x <- bobModes
    } println(x)
  }

}
