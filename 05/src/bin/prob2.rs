use std::fs::File;
use std::io::{prelude::*, BufReader};
use regex::Regex;

pub fn main() {
    
    let fname = String::from("./test.txt");

    let file = match File::open(&fname) {
        Err(why) => panic!("Couldn't open {fname}: {}", why),
        Ok(file) => file
    };

    let reader = BufReader::new(file);

    let mut firstline = true;
    let re = Regex::new(r"[0-9]+").unwrap();
    let mut dp: Vec<i64> = Vec::new();

    for line in reader.lines() {
        let text = match line {
        Err(why) => panic!("Couldn't read line, {}", why),
        Ok(text) => text
        };

        if firstline {
            let seeds: Vec<i64> = re.find_iter(&text).map(|m| m.as_str().parse::<i64>().unwrap()).collect();

            for ran in (0..seeds.len()).step_by(2) {
                for i in seeds[ran]..(seeds[ran] + seeds[ran + 1]) {
                    dp.push(i);
                }
            }

            firstline = false;
        }
        else {
            let nums: Vec<i64> = re.find_iter(&text).map(|m| m.as_str().parse::<i64>().unwrap()).collect();
            if nums.len() >= 3 {
                for i in 0..dp.len() {
                    if dp[i] >= nums[1] && dp[i] < nums[1] + nums[2] {
                        dp[i] = nums[0] + dp[i] - nums[1];

                    }
                }
            }
        }

        print!("line done: {}\n", text);

    }

    print!("{}", &dp.iter().min().unwrap());

}