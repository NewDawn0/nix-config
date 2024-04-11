use clap::Parser;
use std::fs::{self, DirEntry};
use std::io;
use std::path::{Path, PathBuf};
use std::process::Command;

const RED: &'static str = "\x1b[31m";
const GREEN: &'static str = "\x1b[32m";
const NC: &'static str = "\x1b[0m";

#[derive(Parser, Debug)]
#[clap(author = "NewDawn0", version = "0.1.0", about = "An extensible project generator", long_about = None)]
struct Args {
    /// Lists all available rules
    #[clap(short, long)]
    list: bool,

    /// Specifies the rule to use
    rule: Option<String>,

    /// Specifies the name for the generated output
    name: Option<String>,
}

// haskells die
macro_rules! die {
    () => {
        std::process::exit(1)
    };
}

fn main() {
    let args = Args::parse();
    let config_dir = dirs::home_dir().unwrap().join(".config/gen/");
    let rules_dir = config_dir.join("rules");

    ensure_cfg(&config_dir, &rules_dir);

    if args.list {
        match list_rules(&rules_dir) {
            Ok(rules) => {
                if rules.is_empty() {
                    eprintln!("{}No rules found{}", RED, NC);
                    die!();
                }
                println!("{}Available rules{}", GREEN, NC);
                for (i, rule) in rules.iter().enumerate() {
                    if i < rules.len() - 1 {
                        println!(" {}-> {}{}", GREEN, NC, rule);
                    } else {
                        println!(" {}`-> {}{}", GREEN, NC, rule);
                    }
                }
            }
            Err(e) => {
                println!("{}Error{} listing rules: {}", RED, NC, e);
                die!();
            }
        }
    } else if let (Some(rule), Some(name)) = (&args.rule, &args.name) {
        let rule_dir = rules_dir.join(rule);
        if rule_dir.exists() && rule_dir.is_dir() {
            match execute_rule(&rule_dir, name) {
                Ok(_) => {}
                Err(e) => {
                    eprintln!("{}Error executing rule: {}{}", RED, e, NC);
                    die!();
                }
            }
        }
    } else {
        eprintln!("{}Usage: gen [--list] <rule> <name>{}", RED, NC);
        die!();
    }
}

fn execute_rule(rule_dir: &Path, name: &str) -> io::Result<()> {
    let target_dir = PathBuf::from(name);
    if !target_dir.exists() {
        fs::create_dir(&target_dir)?;
    }

    println!("{}> {}Running setup", GREEN, NC);
    let setupfile_path = rule_dir.join("SETUPFILE");
    if setupfile_path.exists() && setupfile_path.is_file() {
        // Assuming SETUPFILE is a bash script, execute it
        Command::new("bash")
            .arg(setupfile_path)
            .current_dir(&target_dir)
            .status()?;
    }

    println!("{}> {}Copying files", GREEN, NC);
    for entry in fs::read_dir(rule_dir)? {
        let entry = entry?;
        let path = entry.path();
        if entry.file_name() != "SETUPFILE" && entry.file_name() != "POSTSETUPFILE" {
            let dest_path = target_dir.join(entry.file_name());
            copy_recursive(&path, &dest_path)?;
        }
    }
    println!("{}> {}Running post-setup", GREEN, NC);
    let postsetupfile_path = rule_dir.join("POSTSETUPFILE");
    if postsetupfile_path.exists() && postsetupfile_path.is_file() {
        // Assuming POSTSETUPFILE is a bash script, execute it
        Command::new("bash")
            .arg(postsetupfile_path)
            .current_dir(&target_dir)
            .status()?;
    }

    Ok(())
}

fn copy_recursive(src: &Path, dst: &Path) -> io::Result<()> {
    if src.is_dir() {
        if !dst.exists() {
            fs::create_dir(dst)?;
        }
        for entry in fs::read_dir(src)? {
            let entry = entry?;
            let path = entry.path();
            let dest_path = dst.join(entry.file_name());
            copy_recursive(&path, &dest_path)?;
        }
    } else {
        fs::copy(src, dst)?;
    }
    Ok(())
}

// Ensure config and rules directories exist
#[inline(always)]
fn ensure_cfg(config_dir: &PathBuf, rules_dir: &PathBuf) {
    if !config_dir.exists() {
        fs::create_dir_all(&config_dir).unwrap();
    }
    if !rules_dir.exists() {
        fs::create_dir_all(&rules_dir).unwrap();
    }
}

fn list_rules(rules_dir: &Path) -> Result<Vec<String>, std::io::Error> {
    let mut rules = Vec::new();
    if rules_dir.is_dir() {
        for entry in fs::read_dir(rules_dir)? {
            let entry = entry?;
            if is_dir(&entry) {
                if let Some(name) = entry.file_name().to_str() {
                    rules.push(name.to_owned());
                }
            }
        }
    }
    Ok(rules)
}

#[inline(always)]
fn is_dir(entry: &DirEntry) -> bool {
    entry.file_type().map(|ft| ft.is_dir()).unwrap_or(false)
}
