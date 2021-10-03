import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR, descMap: getDescriptorMap()}
service "creatingServer" on ep {

    remote function add_new_fn(function value) returns string|error {
    }
    remote function add_fns(function value) returns string|error {
    }
    remote function delete_fn(string value) returns string|error {
    }
    remote function show_fn(criteria value) returns function|error {
    }
    remote function show_all_fns(string value) returns stream<string, error?>|error {
    }
    remote function show_all_with_criteria(string value) returns stream<string, error?>|error {
    }
}

