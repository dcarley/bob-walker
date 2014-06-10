package main

import (
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"
)

func print_usage() {
	// Get the name of the current executable
	thisProg := filepath.Base(os.Args[0])

	fmt.Print(`usage: ` + thisProg + ` options

This script simulates a bob walker

OPTIONS:
  -h    Show this message
  -d    Drunk mode!
  -s    Sport mode!
  -t    Turbo mode!
`)
}

func main() {

	drunkMode := false
	sportMode := false
	turboMode := false

	// Check for commandline options
	cmdOpts := os.Args[1:]
	if len(cmdOpts) > 0 {
		for _, opt := range cmdOpts {
			switch opt {
			case "-d":
				drunkMode = true
			case "-s":
				sportMode = true
			case "-t":
				turboMode = true
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

	if turboMode {
		runtime.GOMAXPROCS(runtime.NumCPU())
	}

	channel := make(chan string)

	go talk(channel, phrases, sportMode, drunkMode)

	for {
		select {
		case msg := <-channel:
			fmt.Println(msg)
		case <-time.After(2 * time.Second):
			fmt.Println("zzzzz...")
		}
	}
}

func talk(channel chan string, phrases []string, sportMode bool, drunkMode bool) {
	for {
		for _, phrase := range phrases {
			if drunkMode {
				phrase = strings.Replace(phrase, "e", "eeee", -1)
			}

			channel <- phrase

			if drunkMode {
				time.Sleep(time.Duration(rand.Intn(3)) * time.Second)
			}
		}
	}
}
