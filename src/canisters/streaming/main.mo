import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

import Manager "./manager";
import TYPES "./types";

actor Main {
    
    private type Chunk = TYPES.Chunk;
    private type QType = TYPES.Queue;
    private let m = TYPES.hashmapInitSize;

    let streams: TYPES.Streams = HashMap.HashMap<Text, QType>(m, Text.equal, Text.hash);    

    public shared query func streaming( data: Chunk, id:Text): async () {
        Manager.addToStream(streams, data, id)
    };

    public shared query func stopStreaming( id:Text): async (Bool, Text) {
        Manager.deleteStream(streams,id);
    };

    public shared query func watchStream(id:Text): async ?Chunk {
        Manager.readStream(streams, id);
    };

    public shared query func getStreams(): async [Text] {
        Iter.toArray(streams.keys());
    };
}
