import grpc
from google.protobuf import any_pb2

from profanedb.protobuf import db_pb2, db_pb2_grpc, storage_pb2

import test_pb2

def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = db_pb2_grpc.DbStub(channel)

    # to_serialize = test_pb2.KeyInt(
    #         int_key = 12312
    # )

    # serializable = any_pb2.Any()
    # serializable.Pack(to_serialize)

    # stub.Put(db_pb2.PutReq(
    #     serializable = serializable
    # ))
    message_list =["first", "second"]

    # for message in message_list:

    new_put = test_pb2.RepeatedKeyStr()
    new_put.int_key_repeated.extend(message_list)

    serializable = any_pb2.Any()
    serializable.Pack(new_put)

    stub.Put(db_pb2.PutReq(
        serializable = serializable
    ))

    key = storage_pb2.Key(
            message_type = "schema.RepeatedKeyStr",
            field = "int_key_repeated",
            value = b"f"
    )

    retrieved = stub.Get(db_pb2.GetReq(
        key = key
    ))

    retrieved_unpacked = test_pb2.RepeatedKeyStr()

    retrieved.message.Unpack(retrieved_unpacked)

    print(retrieved_unpacked.int_key_repeated[0] )


if __name__ == '__main__':
    run()
