package main

import "fmt"

var reset = "\x1b[0m"

func show(prefix string) {
	fmt.Print(prefix, "\x1b[30m"+"30", " ")
	fmt.Print(prefix, "\x1b[31m"+"31", " ")
	fmt.Print(prefix, "\x1b[32m"+"32", " ")
	fmt.Print(prefix, "\x1b[33m"+"33", " ")
	fmt.Print(prefix, "\x1b[34m"+"34", " ")
	fmt.Print(prefix, "\x1b[35m"+"35", " ")
	fmt.Print(prefix, "\x1b[36m"+"36", " ")
	fmt.Print(prefix, "\x1b[37m"+"37"+"\n", reset)
}
func main() {
	bold := "\x1b[1m"
	show("")
	show(bold)
}
