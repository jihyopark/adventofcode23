(* lexer *)

let lexer str =
  let length = String.length str in
  
  let rec lex_helper str pos acc is_win = 
    if pos >= length then
      acc

    else
      let (win, mine) = acc in
      if Str.string_match (Str.regexp {|||}) str pos then
        lex_helper str (pos + 1) acc false
      
      else if Str.string_match (Str.regexp {|[0-9]+|}) str pos then
        let value = Str.matched_string str in
          if is_win then lex_helper str (pos + (String.length value)) ((int_of_string value)::win, mine) is_win
          else lex_helper str (pos + (String.length value)) (win, (int_of_string value)::mine) is_win
    
      else lex_helper str (pos + 1) acc is_win

  in lex_helper str 8 ([], []) true

(* finding number of wins a card has *)

let win_nums (win, mine) = 
  List.fold_left (fun acc n -> if (List.mem n win) then 
    acc + 1 else acc) 0 mine

(* find number of cards gained from a card *)

let rec find_win_num line lines curr_index = 
  let i = win_nums line in 
  (* print_string (string_of_int i) ; *)
  let rec helper acc n = 
    if n >= i + 1 then acc
    else
      (* ((print_string ((string_of_int n)^":n, index:"^(string_of_int curr_index)^"\n")) ; *)
      helper (acc + (find_win_num (List.nth lines (curr_index + n)) lines (curr_index + n))) (n + 1)
(* ) *)
  in helper 1 1

(* read file & calculate *)

let rec fold f accu l index =
  match l with
    [] -> accu
  | a::l -> fold f (f accu a index) l (index + 1)

let read_lines fname =
  let ic = open_in fname in
  let rec read_line lst = 
    let line = (try (input_line ic) with End_of_file -> 
      (print_string (string_of_int 
      (fold (fun acc line index -> acc + (find_win_num line lst index)) 0 lst 0)); exit 0)) in
    read_line (lst@[(lexer line)])
  in read_line [];;

read_lines "input.txt";;