import grpc
from google.protobuf import any_pb2

from profanedb.protobuf import db_pb2, db_pb2_grpc, storage_pb2

import test_pb2




def create_stub():

    channel = grpc.insecure_channel('localhost:50051')
    stub = db_pb2_grpc.DbStub(channel)

    return stub


def send_put_request(stub, message):

    serializable = any_pb2.Any()
    serializable.Pack(message)

    stub.Put(db_pb2.PutReq(
        serializable = serializable
    ))
    return


def send_get_request(stub, key, retrieved_unpacked):

    retrieved = stub.Get(db_pb2.GetReq(
        key = key
    ))
    retrieved.message.Unpack(retrieved_unpacked)
    return 


def send_receive_basic_key_str(stub):
    
    new_put = test_pb2.KeyStr()
    new_put.string_key ="second"
    send_put_request(stub=stub, message=new_put)

    key = storage_pb2.Key(
            message_type = "schema.KeyStr",
            field = "string_key",
            value = b"second"
    )

    retrieved_unpacked = test_pb2.KeyStr()

    send_get_request(stub=stub, key=key, retrieved_unpacked=retrieved_unpacked)

    print(retrieved_unpacked.string_key )
    return


def send_receive_repeated_str_key(stub):
    ## not working!

    message_list =["first", "second"]

    # for message in message_list:

    new_put = test_pb2.RepeatedKeyStr()
    new_put.int_key_repeated.extend(message_list)

    send_put_request(stub=stub, message=new_put)


    ### this part does not work ;/
    key = storage_pb2.Key(
            message_type = "schema.RepeatedKeyStr",
            field = "int_key_repeated",
            value = b"first"
    )

    retrieved_unpacked = test_pb2.RepeatedKeyStr()
    send_get_request(stub=stub, key=key, retrieved_unpacked=retrieved_unpacked)

    print(retrieved_unpacked.int_key_repeated[0] )
    return



def send_receive_non_keyable_nested(stub):

    new_put = test_pb2.NonKeyableNested()
    new_put.int_key = 36
    # new_put.string_key ='first'
    new_put.nested_nonkeyable_message.boolean =True

    send_put_request(stub=stub, message=new_put)

    key = storage_pb2.Key(
            message_type = "schema.NonKeyableNested",
            field = "int_key",
            value = b"36"
    )

    retrieved_unpacked = test_pb2.NonKeyableNested()
    send_get_request(stub=stub, key=key, retrieved_unpacked=retrieved_unpacked)

    print(retrieved_unpacked.nested_nonkeyable_message.boolean )
    return


def send_receive_keyable_nested(stub):

    ## okay so I can send and recieve a keyable nested only when I do not assign 
    ## anything to the nested portion?
    ## THIS DOES NOT WORK ! WHAT A BIG WASTE OF TIME

    new_put = test_pb2.KeyStr()
    new_put.string_key = "juju"
    new_put.body ="hey there!"
    send_put_request(stub=stub, message=new_put)

    new_put2 = test_pb2.KeyableNestedStr()
    new_put2.str_key ="firstNested3"
    # new_put2.nested_keyable.CopyFrom(new_put)# 'KeyInt/1234567'
    new_put2.nested_keyable.string_key='juju2'

    send_put_request(stub=stub, message=new_put2)


    key = storage_pb2.Key(
            message_type = "schema.KeyableNestedStr",
            field = "str_key",
            value = b"firstNested3"
    )

    retrieved_unpacked = test_pb2.KeyableNestedStr()
    send_get_request(stub=stub, key=key, retrieved_unpacked=retrieved_unpacked)

    print(retrieved_unpacked.str_key )
    # return



if __name__ == '__main__':


    stub = create_stub()
    # send_receive_basic_key_str(stub)
    
    # send_receive_non_keyable_nested(stub)

    send_receive_keyable_nested(stub)