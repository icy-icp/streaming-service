import HashMap "mo:base/HashMap";
import List "mo:base/List";

module {
    public type Chunk = Text;

    public type Queue = (
        List.List<Chunk>, // <-  in
        List.List<Chunk>, // out ->
    );
    
    public type Streams = HashMap.HashMap<Text, Queue>;

    public let queMaxSize: Nat = 3;
    public let hashmapInitSize: Nat = 1;
}