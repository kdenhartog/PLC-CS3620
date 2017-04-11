(** [terminating trs] returns true if termination of a reorganizing TRS
    [trs] is proved, and false otherwise.  Note that false does not mean
    non-termination due to incompleteness of the method. *)
val terminating : Trs.trs -> bool
