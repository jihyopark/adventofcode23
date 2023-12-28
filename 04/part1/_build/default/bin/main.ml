(* lexer *)

let lexer str =
  let length = String.length str in
  
  let rec lex_helper str pos acc is_win = 
    if pos >= length then
      acc

    else
      let (win, mine) = acc in
      if Str.string_match (Str.regexp "|") str pos then
        lex_helper str (pos + 1) acc false
      
      else if Str.string_match (Str.regexp "[0-9]+") str pos then
        let value = Str.matched_string str in
          if is_win then lex_helper str (pos + 1) ((int_of_string value)::win, mine) is_win
          else lex_helper str (pos + (String.length value)) (win, (int_of_string value)::mine) is_win
    
      else lex_helper str (pos + 1) acc is_win

  in lex_helper str 0 ([], []) true

(* finding winning numbers + value of each card *)

let find_winner (win, mine) = 
  List.fold_left (fun acc n -> if (List.mem n win) then 
    (if acc = 0 then 1 else acc * 2) else acc) 0 mine

(* read file & calculate *)

let read_lines fname =
  let ic = open_in fname in
  let try_read =
    try 
      Some (input_line ic)
    with End_of_file -> close_in ic; None in

  let rec loop a = (match try_read with
    | Some s -> (find_winner (lexer s)) + loop a
    | None -> 0)
  
  in loop true

let main (): int = read_lines "input.txt";;