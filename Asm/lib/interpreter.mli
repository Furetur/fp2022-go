(** Copyright 2021-2022, andreyizrailev and contributors *)

(** SPDX-License-Identifier: LGPL-3.0-or-later *)

open Ast
open Utils

module Interpreter : sig
  type state_t =
    { reg_map : int IntMap.t
        (* Map from register ids to their values.
         Note that we won't have registers like "ax" here since their value can be
         obtained from "eax". So, the map only contains "primary" registers, i.e.
         ones that are not part of the others *)
    ; stack : int ListStack.t (* Program stack in an oridnary sense *)
    ; flags : int
        (* Updated after each cmp command. Negative if the left
           operand of cmp was less than the right one, zero if they
           were equal, positive otherwise *)
    ; label_map : instruction list StringMap.t
        (* Map from label commands to suffixes of the instruction list.
           When jumping to label, we will obtain the instructions that we should
           executed from this map. *)
    ; cstack : instruction list ListStack.t
        (* Call stack. We push the list of instructions after the call and pop
           it after ret *)
    }
  [@@deriving show]

  val eval_whole : ast -> state_t
end
