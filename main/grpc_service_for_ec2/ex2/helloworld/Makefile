proto_server:

	protoc --go_out=../greeter_server/gen --go_opt=paths=source_relative \
    --go-grpc_out=../greeter_server/gen --go-grpc_opt=paths=source_relative \
    -I ./ ./*.proto



proto_client:

	protoc --go_out=../greeter_client/gen --go_opt=paths=source_relative \
    --go-grpc_out=../greeter_client/gen --go-grpc_opt=paths=source_relative \
    -I ./ ./*.proto