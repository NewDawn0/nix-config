use fzf_wrapped::{Border, Color, Fzf, Layout};
use std::{
    collections::HashSet,
    env::args,
    fs::{self, File, OpenOptions},
    io::{self, Read, Write},
    path::Path,
    process::exit,
};

// Consts
const NC: &'static str = "\x1b[0m";
const RED: &'static str = "\x1b[1;31m";
const GREEN: &'static str = "\x1b[1;32m";
const COL: &'static str = "\x1b[1;33m";
const STACK_DIR: &'static str = "/tmp/dirStack";

fn help() {
    let banner: &str = r#"     _ _      ____  _             _    
  __| (_)_ __/ ___|| |_ __ _  ___| | __
 / _` | | '__\___ \| __/ _` |/ __| |/ /
| (_| | | |   ___) | || (_| | (__|   < 
 \__,_|_|_|  |____/ \__\__,_|\___|_|\_\
=============©NewDawn0================="#;
    println!("{}{}{}", COL, banner, NC);
    println!("Version: 0.1.0");
    println!("Author:  NewDawn0");
    println!("{}USAGE:{}   dirStack <action> [args]", COL, NC);
    println!("{}ACTIONS:{}", COL, NC);
    println!(
        "  {}-h{} | {}--help{}       Show this help menu",
        COL, NC, COL, NC
    );
    println!(
        "  {}-l{} | {}--list{}       List the quick access directories",
        COL, NC, COL, NC
    );
    println!(
        "  {}-c{} | {}--clear{}      Clear the quick access directories",
        COL, NC, COL, NC
    );
    println!(
        "  {}-p{} | {}--push{}       Push directory to the quick access list",
        COL, NC, COL, NC
    );
    println!(
        "  {}-g{} | {}--goto{}       CD into a selected directory",
        COL, NC, COL, NC
    );
    println!(
        "  {}-i{} | {}--init{}       Generate the initalizer script",
        COL, NC, COL, NC
    );
    exit(0)
}

fn main() {
    // Parse args
    let args = args().into_iter().skip(1).collect::<Vec<_>>();
    if args.len() == 0 {
        select_wrapped()
    }
    if args.len() > 0 {
        match args[0].as_str() {
            "-i" | "--init" => init(),
            "-l" | "--list" => list_wrapped(),
            "-h" | "--help" => help(),
            "-g" | "--goto" => select_wrapped(),
            "-p" | "--push" => push(args[1..].to_vec()).expect("Could not push to the stack"),
            "-c" | "--clear" => clear().expect("Could not clear stack"),
            _ => {
                eprintln!("{}[ERROR]{} Unknown action: {}", RED, NC, args[0]);
                eprintln!("    {}`->{} Showing the help menu", RED, NC);
                help()
            }
        }
    }
}

fn init() {
    let func = r#"function ds () {
    output=$(dirStack $*)
    while IFS= read -r line; do
        if [[ $line == EXEC:* ]]; then
            eval "''${line#EXEC: }"
        else
            echo -e $line
        fi
    done <<< "$output"
}"#;
    println!("{}[INFO]{} Paste the following in your shell rc\n```", GREEN, NC);
    println!("{}", func);
    println!("```");
}
fn select(selection: Vec<String>) -> Result<String, Box<dyn std::error::Error>> {
    let mut fzf = Fzf::builder()
        .border(Border::Rounded)
        .border_label("Select directory")
        .layout(Layout::Reverse)
        .color(Color::Sixteen)
        .custom_args(vec!["--height=50%".to_string()])
        .build()?;
    fzf.run()?;
    fzf.add_items(selection)?;
    return match fzf.output() {
        Some(dir) => Ok(dir),
        None => {
            eprintln!("{}[ERROR]{} No directory selected", RED, NC);
            eprintln!("    {}`->{} Aborting", RED, NC);
            exit(1)
        }
    };
}

fn select_wrapped() {
    match list() {
        Ok(assortement) => match select(assortement) {
            Ok(dir) => {
                println!("EXEC: cd {}", dir.replace("~", "$HOME"));
            }
            Err(_) => {
                eprintln!(
                    "{}[ERROR]{} Something went wrong while selecting directory",
                    RED, NC
                );
                eprintln!("    {}`->{} Aborting", RED, NC);
                exit(1)
            }
        },
        Err(_) => {
            eprintln!(
                "{}[ERROR]{} An error occured whilst reading the stack",
                RED, NC
            );
            eprintln!("    {}`->{} Aborting", RED, NC);
        }
    }
}

fn stat_files(paths: &Vec<String>) {
    let mut ok = true;
    for path_str in paths {
        let path = Path::new(&path_str);
        match fs::metadata(path) {
            Ok(meta) => {
                if !meta.is_dir() {
                    eprintln!("{}[ERROR]{} `{}` is not a directory", RED, NC, path_str);
                    ok = false;
                }
            }
            Err(_) => {
                eprintln!("{}[ERROR]{} `{}` does not exist", RED, NC, path_str);
                ok = false;
            }
        }
    }
    if !ok {
        eprintln!("    {}`->{} Aborting", RED, NC);
        exit(1)
    }
}

fn clear() -> io::Result<()> {
    if Path::new(STACK_DIR).exists() {
        fs::remove_file(STACK_DIR)?;
    }
    println!("{}Suceccfully cleared the quick access list{}", COL, NC);
    Ok(())
}

fn push(dirs: Vec<String>) -> io::Result<()> {
    if dirs.len() == 0 {
        eprintln!("{}[ERROR]{} Provide directories", RED, NC);
        eprintln!("    {}`->{} Aborting", RED, NC);
        exit(1)
    }
    stat_files(&dirs);
    let mut file = OpenOptions::new()
        .create(true)
        .append(true)
        .read(true)
        .open(STACK_DIR)?;
    let mut existing = String::new();
    file.read_to_string(&mut existing)?;
    let mut lines: HashSet<String> = existing.lines().map(|s| s.to_string()).collect();
    for dir in dirs {
        match fs::canonicalize(&dir) {
            Err(_) => {} // Should not happen
            Ok(path) => {
                let pathstr = path.to_str().expect("Should not happen").to_string();
                if lines.insert(pathstr.clone()) {
                    writeln!(file, "{}", pathstr)?;
                }
            }
        }
    }
    println!(
        "{}Suceccfully added items to the the quick access list{}",
        COL, NC
    );
    Ok(())
}

fn list_wrapped() {
    match list() {
        Ok(res) => {
            for (i, e) in res.iter().enumerate() {
                println!("{}{}{} : {}", COL, i, NC, e);
            }
        }
        Err(_) => {
            eprintln!(
                "{}[ERROR]{} An error occured whilst reading the stack",
                RED, NC
            );
            eprintln!("    {}`->{} Aborting", RED, NC);
        }
    }
}
fn list() -> io::Result<Vec<String>> {
    if !Path::new(STACK_DIR).exists() {
        println!("{}No directories in the quick access list{}", COL, NC);
        exit(0);
    }
    let mut file = File::open(STACK_DIR)?;
    let mut data = String::new();
    file.read_to_string(&mut data)?;
    let data_vec = data.lines().map(|s| s.to_string()).collect::<Vec<String>>();
    if data_vec.len() == 0 {
        println!("{}No directories in the quick access list{}", COL, NC);
        exit(0);
    }
    Ok(data_vec)
}
