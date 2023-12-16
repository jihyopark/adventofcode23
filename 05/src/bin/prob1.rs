use std::fs::File;
use std::io::{prelude::*, BufReader};
use regex::Regex;

pub fn main() {
    
    let mut lines: Vec<String> = Vec::new();

    let fname = String::from("./input.txt");

    let file = match File::open(&fname) {
        Err(why) => panic!("Couldn't open {fname}: {}", why),
        Ok(file) => file
    };

    let reader = BufReader::new(file);

    for line in reader.lines() {
        let text = match line {
        Err(why) => panic!("Couldn't read line, {}", why),
        Ok(text) => text
        };

        lines.push(text);

    }

    if lines.len() < 3 {
        panic!();
    }

    let re = Regex::new(r"[0-9]+").unwrap();

    // let mut i: u32 = 0;
    // let mut j: u32 = 0;
    let mut set: Vec<Vec<i64>> = Vec::new();
    let mut data: Vec<Vec<Vec<i64>>> = Vec::new();

    for line in &lines[2..] {
        if line == "" {
            // i += 1;
            data.push(set);
            
            set = Vec::new();
        }
        else {
            // print!("hhhh");
            // let nums_st: Vec<String> = re.find_iter(line).map(|m| m.as_str().to_string()).collect();
            let nums: Vec<i64> = re.find_iter(line).map(|m| m.as_str().parse::<i64>().unwrap()).collect();
            if nums.len() != 0 {
                set.push(nums.clone());
                // j += 1;
                // print!("{} ", &nums[0]);
            }
        }
    }

    data.push(set.clone());
    
    let seeds: Vec<i64> = re.find_iter(&lines[0]).map(|m| m.as_str().parse::<i64>().unwrap()).collect();

    let mut locs: Vec<i64> = Vec::new();

    for seed in seeds {
        let mut i:i64 = seed;
        // let mut breaked = false;

        for data_types in &data {
            for line in data_types {
                if line.len() < 3 {
                    panic!();
                }
                else {
                    // print!("({} {} {})", &line[0],&line[1],&line[2]);

                    if i >= line[1] && i < line[1] + line[2] {
                        i = line[0] + i - line[1];
                        // breaked = true;
                        break;
                    }
                }
            }

            print!("i = {}\n", i);

        }

        locs.push(i);
        print!("{} {}\n", i, seed);
    }

    print!("{}", locs.iter().min().unwrap_or(&0));

}