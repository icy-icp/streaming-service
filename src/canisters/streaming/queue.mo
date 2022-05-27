import List "mo:base/List";

import TYPES "types";

module {
    private type Chunk = TYPES.Chunk;
    private type Queue = TYPES.Queue;

    public func push(v : Chunk, (i, o) : Queue) : Queue {
        (?(v, i), o);
    };

    public func pop(q : Queue) : (?Chunk, Queue) {
        switch (peek(q)) {
            case (null, _)     { (null, q);          };
            case (? x, (i, o)) { (?x, (i, tail(o))); }; 
        };
    };

    public func peek(q : Queue) : (?Chunk, Queue) {
        switch (q) {
            case ((null, null))  { (null, q);                      };
            case ((xs, null))    { peek((null, List.reverse(xs))); };
            case ((_, ?(x, xs))) { (?x, q);                        };
        };
    };

    public func size((i, o) : Queue) : Nat {
        List.size(i) + List.size(o);
    };

    public func tail(l : List.List<Chunk>) : List.List<Chunk> {
        switch (l) {
            case (null)      { null; };
            case (? (x, xs)) { xs;   };
        };
    };
};