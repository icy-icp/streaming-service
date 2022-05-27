import Text "mo:base/Text";

import Queue "./queue";
import TYPES  "./types";

module {
        
        private type Chunk = TYPES.Chunk;
        private type QType = TYPES.Queue;

        private let n = TYPES.queMaxSize;

        public func addToStream(streams: TYPES.Streams, data: Chunk, id: Text): () {
            let stream: ?QType = streams.get(id);
            switch (stream) {
                case (?q){
                    var newQ: QType = q;
                    if(Queue.size(q) >= n){
                        let (element, queue) = Queue.pop(q);
                        newQ := queue;
                    };
                    newQ := Queue.push(data,newQ);
                    streams.put(id, newQ);
                };
                case (null){
                    let initQueue: QType = (null,null);
                    let queue: QType = Queue.push(data, initQueue);
                    streams.put(id, queue);
                };
            };
        };
        
        public func readStream(streams: TYPES.Streams, id: Text):  ?Chunk {
            let stream: ?QType = streams.get(id);
            switch (stream){
                case (?q){
                    switch(Queue.peek(q)){
                        case (v, _){v;};
                    };
                };
                case (null){null;};
            };
        };
        
        public func deleteStream(streams: TYPES.Streams, id: Text) :  (Bool, Text) {
            switch (streams.get(id)){
                case (null){
                    return (false, "Stream " # id # "not created");
                };
                case(?(q, i)){
                    streams.delete(id);
                    return (true, "Stream " # id # "deleted");
                };
            };
        };

        public func getQue(streams: TYPES.Streams, id: Text):  QType {
            switch(streams.get(id)){
                case(?q){
                    return q;
                };   
                case(null){
                    return (null, null);
                };
            }
        };

        public func getQueSize(streams: TYPES.Streams, id: Text):  Nat {
            switch(streams.get(id)){
                case(?q){
                    return Queue.size(q);
                };   
                case(null){
                    return 0;
                };
            }
        };
};