import Array "mo:base/Array";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Text "mo:base/Text";

import FIFO "./fifo";
import StrTypes  "./streaming.types";

module {
// V - FIFO ITEMS TYPE
// n - fifo max size
// m - hashmap init size

       public class Streaming<V>(n: Nat, m:Nat){
        
        let streams: StrTypes.Streams<V> = HashMap.HashMap(m, Text.equal, Text.hash);

        public func addToStream(data: V, userId: Text) {
            let stream: ?StrTypes.FIFO<V> = streams.get(userId);
            switch (stream) {
                case (?stream){
                    if(FIFO.size<V>(stream) >= n){
                        let (element, queue) = FIFO.pop(stream);
                        streams.put(userId, queue);
                    };
                    let queue: StrTypes.FIFO<V> = FIFO.push(data,stream);
                    streams.put(userId, queue);
                };
                case (null){
                    let initQueue: StrTypes.FIFO<V> = (null,null);
                    let queue: StrTypes.FIFO<V> = FIFO.push(data, initQueue);
                    streams.put(userId, queue);
                };
            }
        };
        
        public func deleteStream(userId: Text) : Text {
            switch (streams.get(userId)){
                case (null){
                    return "Stream " # userId # "not created";
                };
                case(?(q, i)){
                    streams.delete(userId);
                    return "Stream " # userId # "deleted";
                }
            }
        };
       }
}