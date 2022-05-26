
  
import List "mo:base/List";

import TYPES "streaming.types";

module {
    // A simple FIFO queue.
    public type TYPES.FIFO<V> = (
        List.List<V>, // <-  in
        List.List<V>, // out ->
    );

    // Pushes an element onto the given queue.
    public func push<V>(v : V, (i, o) : TYPES.FIFO<V>) : TYPES.FIFO<V> = (?(v, i), o);

    // Pops an element from the given queue.
    public func pop<V>(q : TYPES.FIFO<V>) : (?V, TYPES.FIFO<V>) {
        switch (peek(q)) {
            case (null, _)     { (null, q);          };
            case (? x, (i, o)) { (?x, (i, tail(o))); }; 
        };
    };

    // Peeks at the top element from the given queue.
    public func peek<V>(q : TYPES.FIFO<V>) : (?V, TYPES.FIFO<V>) {
        switch (q) {
            case ((null, null))  { (null, q);                      };
            case ((xs, null))    { peek((null, List.reverse(xs))); };
            case ((_, ?(x, xs))) { (?x, q);                        };
        };
    };

    // Returns the size of the given queue.
    public func size<V> ((i, o) : TYPES.FIFO<V>) : Nat {
        List.size(i) + List.size(o);
    };

    private func tail<V>(l : List.List<V>) : List.List<V> {
        switch (l) {
            case (null)      { null; };
            case (? (x, xs)) { xs;   };
        };
    };
};