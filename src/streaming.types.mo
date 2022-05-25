import HashMap "mo:base/HashMap";
import List "mo:base/List";

module {

    public type FIFO<V> = (
        List.List<V>, // <-  in
        List.List<V>, // out ->
    );
    
    public type Streams<V> = HashMap.HashMap<Text, FIFO<V>>
}