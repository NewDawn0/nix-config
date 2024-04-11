package main

import (
	"flag"
	"log"
	"os"
	"os/exec"
	"strings"
	"github.com/google/uuid"
)

func main() {
    // Get editor
    _ed := os.Getenv("EDITOR")
    if _ed == "" { _ed = "vim" }
    // Parse args
    ext_flag := flag.String("ext", "md", "File extension of the note")
    ed_flag := flag.String("ed", _ed, "Text editor used : (If unset $EDITOR is used)")
    ed_args_flag := flag.String("args", "", "Text editor arguments used")
    flag.Parse()
    ext := *ext_flag
    editor := *ed_flag
    args := *ed_args_flag

    // Execute
    fname := mk_fname(ext)                    // Generate file name
    mk_file(fname)                            // Touch file
    mk_exec(editor, args, fname)              // Run command
}

func mk_fname(ext string) string {
    fname := uuid.New().String() + "." + ext  // gen filename
    if _, err := os.Stat(fname); err == nil { // check if exist
        log.Fatalf("File %s already exists...\nAborting\n", fname)
    }
    return fname
}

func mk_file(fname string) {
    file, err := os.Create(fname)             // touch file
    if err != nil {                           // check for err
        log.Fatalf("Unable to create file %s...\nRecieved error: %v", fname, err)
    }
    defer file.Close()                        // close file
}

func mk_exec(editor string, args string, fname string) {
    argsList := append(strings.Fields(args), fname)
    cmd := exec.Command(editor, argsList...)  // Set command to open file with editor
    cmd.Stdin = os.Stdin                      // Map stdin, stdout, stderr
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    if err := cmd.Run(); err != nil {         // Run command and check for error
        log.Fatalf("Unable to open temporary `%s` with %s...\nRecieved error: %v", fname, editor, err)
    }

    if err := os.Remove(fname); err != nil {
        log.Fatalf("Unable to remove temporary file `%s`...\nRecieved error: %v", fname, err)
    }
}
