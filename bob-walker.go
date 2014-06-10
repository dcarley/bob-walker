package main

import (
	"flag"
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"time"
)

func main() {

	var drunkMode, sportMode, turboMode bool
	flag.BoolVar(&drunkMode, "d", false, "Drunk mode!")
	flag.BoolVar(&sportMode, "s", false, "Sport mode!")
	flag.BoolVar(&turboMode, "t", false, "Turbo mode!")

	flag.Usage = func() {
		thisProg := filepath.Base(os.Args[0])
		fmt.Fprintf(os.Stderr,
			"usage: %s options\n\n"+
				"This scripts simulates a bob walker\n\n"+
				"OPTIONS:\n",
			thisProg)
		flag.PrintDefaults()
	}

	flag.Parse()

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
