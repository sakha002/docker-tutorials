

# What is the Question? what am I looking for?

so I was searching for a db that can store and index protobuff messages easy. why to do that? I guess I can't say it better that this [source](http://profanedb.gitlab.io/faq/)

>You like to spend a lot of time defining a great interface for your RPC.
This is why you picked gRPC + Protocol Buffers instead of a JSON REST API. Protobuf is great! 
But then, you want to store your messages, so you have to convert them to SQL… Not cool!


# Okay so searching for a DB that can be a good fit for protobuf messages ...

my initial thoughts on this:
- Mongo DB and  Arango DB seem to be potential options.
  
but here are the **Questions**:
- How exactly MongoDB could work for the protos? should we convert them to json? and then have a JSON schema or sth? how does Mongo db work?
- Are there any protobuff specific DBs ? or I mean something that strongly support it?
- if there are what are they?

# Okay so found this one: ProfaneDB

> ProfaneDB wants to address this. It adds a simple key option in your Protobuf definitions, and then you can store your messages as they are, and retrieve them by their unique key.

This seems to be fairly small and simple.
it was a samll project, and it has been left deserted in the past four years.
I guess it can't be the solution for a big gigantic DB, but for small size developments like the one we are going to have for the ortool, is going to be enough, it is going to be in-memory anyways.

**Questions**:

- how to actually setup the DB and make it work with sample messages?
  (I read the little documentation on this, I guess it is firly easy and it would seem worth it to try out and maybe try to connect to the folks behind it, if any issues.)
- is there a better way to go about this?

- is there a pre-built image of this DB?
  (seems there is an image, but not clear, what exactly it is (no dockerfile), I guess it would be good to test it out.)
# Are there other options for proto DB?

I found this one **EuclidesDB**.
>On the other hand, EuclidesDB provides the following key features:
Written in C++ for performance
Uses protobuf for data serialization
Uses gRPC for communication

from this [source](https://stackshare.io/euclidesdb)

(well it seems that it uses protobuf but it is more for the DS models (Not cool!))

well probably this usecase that I have for the protobuf is rather tiny, in the world of dbs, not so sure.

okay based on this [source](https://stackoverflow.com/questions/45659153/persisting-protobuf-messages-to-database)
as well as [this one](https://foundationdb.github.io/fdb-record-layer/) the **FoundationDB** is supporting Protocol Buffer natively.

(looking at this FDB seems a bit tough to set it up and make it work, well given my current skills!)

# So what have said the elders of the clan...

[How we store protobufs in MongoDB](https://dataform.co/blog/mongodb-protobuf-codec)

there is a bunch of queries on SO that are around this:

https://stackoverflow.com/questions/2798607/are-there-any-databases-that-support-protocol-buffers

(this is an old question, but one answer in 2020 points to profaneDB as well)

https://stackoverflow.com/questions/17441428/protocol-buffer-database-abstraction-framework
(Riak ??!)

https://stackoverflow.com/questions/7928733/how-to-store-data-structure-matching-proto

(this seems to be doing what I used to do for the type miroring and minimal use of protobufs)


https://medium.com/@jackskj/sql-data-mapping-with-protocol-buffers-70599b30b0e2

(this seems to be addressing the reverse problem, when you have a sql DB and want to make protoDB services and messages off of it, would it be a good idea here to try and define our problem in reverse?)

https://googleapis.dev/python/protobuf/latest/google/protobuf/symbol_database.html

(this is entirely irrelevant but still seems a cool source to dig into the more advanced usage of proros in python.)

https://developers.google.com/protocol-buffers/docs/techniques
(also related to descriptors)


https://stackoverflow.com/questions/45659153/persisting-protobuf-messages-to-database

This one also suggest to convert to json and then take it from there. also there is the notion of FoundationDB here.

https://gitlab.com/ProfaneDB/ProfaneDB/-/issues/14

I found a way to use protobufs with boltdb and its more in line with what i am capable of coping with.

# Seems that I would be trying out this ProfaneDB after all.

(One other thing that I should probably try after or instead of this is using MongoDB. I need to know about it anyway)


# So how to build it?

Seems there is already docker files for a gRPC server .

https://gitlab.com/ProfaneDB/Docker/gRPC/

but was not clear on if it is for the requirements only. Well after some searching in this repo and a few docker files for building different images, I think the one that builds the app, is at 

https://gitlab.com/ProfaneDB/ProfaneDB/-/blob/develop/Dockerfile

but there was some issues in building this image.

well, I can go for the already built image, if it is the right image.

I guess it is this one: 
registry.gitlab.com/profanedb/profanedb:develop

# okay you have the image, how to run the DB?

okay so when you start the DB (container) you need to include some arguments.

so there was some directives but still not clear.

Also I got this error when I just ran it with no arguments:

```
  what():  the argument (' /usr/local/etc/profanedb/server.conf') for option '--profanedb_config_file' is invalid

```

# Server configuration and CLI parameters

from https://gitlab.com/ProfaneDB/ProfaneDB/-/tree/develop

'''
profanedb_server --rocksdb_path /tmp/profanedb -I /usr/include -S /your/schema/dir
'''
The most important parameters are the include path (-I) and schema path (-S).

The include path is used to retrieve google/protobuf/*.proto,
profanedb/protobuf/*.proto and any other dependencies.
The schema path has your definitions with the key option set.


also found this 

```
root@19d88b45950d:/usr/local/etc/profanedb# cat server.conf
log_level=trace
proto_path=/usr/include
proto_path=/usr/local/include
schema_path=/var/profanedb/schema

[rocksdb]
path=/tmp/profanedb
```

## Configuration

from http://profanedb.gitlab.io/docs/quick-start/
Currently ProfaneDB has a very simple configuration.
(Later on more specific RocksDB options will be added in configuration file).

-h [ --help ]            Display this help message
--log_level arg          trace, debug, info, warning, error, fatal
-I [ --proto_path ] arg  Specify the paths to import proto files
                         (google/protobuf/..., profanedb/protobuf/...)
-S [ --schema_path ] arg Specify the paths to load the user defined schema
--rocksdb_path arg       Set the path RocksDB uses to store its content
Let’s focus on the last 3 options:

proto_path:
google/protobuf/*.proto and profanedb/protobuf/*.proto must be reachable from here.
Multiple paths can be defined.
schema_path: the most important option, here is the root of our schema definition.
rocksdb_path: this is where RocksDB will store its files.
It must be consistent across restarts.

# DB gRPC Client Setup:
so what do i got so far?

for testing I have a sample grpc client:

- grpc client codes.
  
- profanedb standard messgaes to annotate schmea 
  - python complied files
  - profanedb protos (okay got it)
    (looks like this one is only including an options proto file)

- grpc-server service RPCs and messages.
    - proto and python compiled
    (this one includes db and storage proto files)

- Sample Schema
  - schema proto files (need to share with db)
  - schema python files (yep i have it)
  
so questions here:

- It would be good to create a simple docker image for the client.
  - for that I would need to have some simple make file to compile them into python files, (instead of the copy that exists now)
  - also the way that this projects stores protobufs, and the service, is an example around how to go around protobuf interface and actual service source codes. We had that discussion around optopy.
-  also to create a docker-compose.
  
  

okay so for the client (image) the work is not that hard.

the key question is around that CLI options.