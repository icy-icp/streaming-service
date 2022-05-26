import Array "mo:base/Array";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Text "mo:base/Text";

import FIFO "./fifo";
import StrTypes  "./streaming.types";

actor  Streaming{
        private let n = 5; // fifo max size
        private let m = 5; // hashmap init size
        private type V = Nat;
        
        let streams: StrTypes.Streams<V> = HashMap.HashMap(m, Text.equal, Text.hash);

        public shared func addToStream(data: V, userId: Text):() {
            let stream: ?StrTypes.FIFO<V> = streams.get(userId);
            switch (stream) {
                case (?q){
                    if(FIFO.size<V>(q) >= n){
                        let (element, queue) = FIFO.pop(q);
                        streams.put(userId, queue);
                    };
                    let queue: StrTypes.FIFO<V> = FIFO.push(data,q);
                    streams.put(userId, queue);
                };
                case (null){
                    let initQueue: StrTypes.FIFO<V> = (null,null);
                    let queue: StrTypes.FIFO<V> = FIFO.push(data, initQueue);
                    streams.put(userId, queue);
                };
            };
        };
        
        public shared func readStream(userId: Text): async ?V {
            let stream: ?StrTypes.FIFO<V> = streams.get(userId);
            switch (stream){
                case (?q){
                    switch(FIFO.peek(q)){
                        case (v, _){
                            return v;
                        };
                    };
                };
                case (null){
                    return null;
                };
            };
        };
        
        public shared func deleteStream(userId: Text) : async (Bool, Text) {
            switch (streams.get(userId)){
                case (null){
                    return (false, "Stream " # userId # "not created");
                };
                case(?(q, i)){
                    streams.delete(userId);
                    return (true, "Stream " # userId # "deleted");
                };
            };
        };
};