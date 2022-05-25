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
        
        var streams: StrTypes.Streams<V> = HashMap.HashMap(m, Text.equal, Text.hash);

        public func addToStream(data: Nat, userId: Text) {
            let stream = streams.get(userId);
            switch (stream) {
                case (stream){
                    if(FIFO.size(stream) < n){
                        FIFO.pop(stream)
                    }
                };
                case null{

                };
            }
            if(stream != null){
                if (streams[userId].size() == streamMaxSize){
                    streams[userId].removeLast();
                };
                streams[userId].add(data);
            } else {
                createStream(data, userId)
            }
        };
        
        private func createStream(data: Nat, userId: Text) {
            let initStream = Buffer(streamMaxSize);
            initStream.add(data)
            streams.put(userId, initStream);
        };

        private func deleteStream(userId: Text) {
            streams.remove(userId);
        };
       }
}