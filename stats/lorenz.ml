#!/usr/bin/env ocaml

#use "topfind";;
#require "re.str";;

let parse () =
	let xs = ref [] in
	begin
		try
			while true do
				let line = input_line stdin in
				match Re_str.split (Re_str.regexp "[ \t]+") line with
				| count :: _ ->
					begin
						try
							xs := int_of_string count :: !xs
						with _ -> ()
					end
				| _ -> ()
			done;
			[]
		with End_of_file -> !xs
	end

let cumulative_contributions raw =
	let number_of_people = List.length raw in
	let total = List.fold_left (+) 0 raw in
	let i = ref 0 in
	let subtotal = ref 0 in
	List.iter
		(fun x ->
			incr i;
			subtotal := !subtotal + x;
			Printf.printf "%.016g %.016g\n" (float_of_int !i /. (float_of_int number_of_people)) (float_of_int !subtotal /. (float_of_int total));
		) (List.sort compare raw)

let _ =
	let all = parse () in
	cumulative_contributions all

