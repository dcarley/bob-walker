package main

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func print_usage() {
	// Get the name of the current executable
	this_prog := filepath.Base(os.Args[0])

	fmt.Print(`usage: ` + this_prog + ` options

This script simulates a bob walker

OPTIONS:
  -h    Show this message
  -s    Sport mode!
  -d    Drunk mode!
`)
}

func main() {

	sportMode := false
	drunkMode := false

	// Check for commandline options
	cmdOpts := os.Args[1:]
	if len(cmdOpts) > 0 {
		for _, opt := range cmdOpts {
			switch opt {
			case "-s":
				sportMode = true
			case "-d":
				drunkMode = true
			case "-h":
				print_usage()
				os.Exit(0)
			default:
				print_usage()
				os.Exit(1)
			}
		}
	}

	phrases := []string{
		"beard",
		"beer",
		"pie",
	}

	if sportMode {
		phrases = append(phrases, "cricket")
		phrases = append(phrases, "rugby")
	}

	// Eternal loop
	for {
		for _, phrase := range phrases {
			if drunkMode {
				phrase = strings.Replace(phrase, "e", "eeee", -1)
			}

			fmt.Println(phrase)

			if drunkMode {
				time.Sleep(time.Second)
			}
		}
	}
}
