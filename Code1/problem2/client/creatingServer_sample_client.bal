import ballerina/io;

import ballerina/grpc as grpc;



ReposityOfFunctionsClient ep = check new ("http://localhost:9090");



public function main() {

    io:print();

    AddFuntionReq addFunctionReq = {

        function: {

            name: "Sunny",

            versionNum: 1,

            lang: "Cpp",

            functionDef: "print('Sunny')",

            keywords: ["beginner"],

            developerName: "Nino",

            developerEmail: "Sunny@Nino"

        }

    };

   AddFunctionRes |grpc:Error addFunctionsRes = ep->add_new_function(addFfuctionReq);

    if addFunctionsRes is error {

        io:println("Error adding new function: ", addFunctionsRes.message());

    } else {

        io:println("Success: ", addFuctionsRes.message);

    }



   AddFunctionReq[] addFunctionsReq = [

        { // should succeed

        fn: {

            devEmail: "Sunny@Nino",

            keywords: ["testing", "test"],

            versionNum: 1,

            name: "test1",

            lang: "test1",

            developerName: "test1",

            functionDef: "test1"

        }

    }, 

        { // should fail

        function: {

            developerEmail: "Sunny@Nino",

            keywords: ["testing", "test"],

            versionNum: 1,

            name: "test2",

            lang: "test2",

            developerName: "test2",

            functionDef: "test2"

        }

    }, 

        { // should succeed

        function: {

            devEmail: "Sunny@Nino",

            keywords: ["testing", "test"],

            versionNum: 1,

            name: "test3",

            lang: "test3",

            developerName: "test3",

            functionDef: "test3"

        }

    }

    ];

    Add_functionsStreamingClient|grpc:Error addFunctionnsStream = ep->add_functions();

    if addFunctionsStream is error {

        io:println("error added functions: ", addFnsStream.message());

    } else {

        foreach AddFunctionReq aFReq in addFunctionsReq {

            grpc:Error? err = addFunctionsStream->sendAddFunctionsReq(aFReq);

            if err is error {

                io:println("Failed to send addFns req");

            }

        }



        grpc:Error? err = addFunctionsStream->complete();

        if err is error {

            io:println("Failed to send complete message");

        } else {

           AddFunctionRes|grpc:Error? functionsRes = addFunctionsStream->receiveAddFunctionsRes();

            if functionsRes is error {

                io:println("Failed to retrieve addFuntionsRes: ", functionsRes.message());

            } else {

                if functionsRes is AddFunctionsRes {

                    foreach string msg in functionsRes.functionNames {

                        io:println(msg);

                    }

                }

            }

        }



    }



    ShowFunctionReq showFunctionReq = {

        functionName: "Sunnyy",

        versionNum: 1

    };

    ShowFunctionnRes|grpc:Error showFunctionRes = ep->show_function(showFunctionReq);

    if showFunctionnRes is error {

        io:println("Error retrieving function: ", showFunctionRes.message());

    } else {

        io:println("Success: ", showFunctionRes);

    }



    ShowAllFonctionsReq showAllFunctionnsReq = {

        functionName: "Sunny"

    };

    stream<ShowAllFunctionsRes, grpc:Error?>|grpc:Error showAllFunctionsStream = ep->show_all_functions(showAllFunctionsReq);

    if showAllFunctionsStream is error {

        io:println("Failed to show all fns: ", showAllFnsStream.message());

    } else {

        error? e = showAllFnsStream.forEach(function(ShowAllFnsRes res) {

            io:println("Successfully retrieved fn: ", res.fn.name);

        });

    }



    ShowAllWithCritReq[] showAllWithCritReqs = [{

        keywords: ["testing", "beginner"],

        lang: ""

    }];

    Show_all_with_criteriaStreamingClient|grpc:Error showAllWithCritStream = ep->show_all_with_criteria();

    if showAllWithCritStream is error {

        io:println("error occured setting up showAllWithCrit stream: ", showAllWithCritStream.message());

    } else {

        foreach ShowAllWithCritReq showAllWithCritReq in showAllWithCritReqs {

            error? err = showAllWithCritStream->sendShowAllWithCritReq(showAllWithCritReq);

            if err is error {

                io:println("failed to send showAllWithCriteria req: ", err.message());

            }

        }

        error? err = showAllWithCritStream->complete();

        if err is error {

            io:println("failed to send showAllWithCriteria complete message: ", err.message());

        }



        ShowAllWithCritRes|grpc:Error? showAllWithCritRes = showAllWithCritStream->receiveShowAllWithCritRes();

        while true {

            if showAllWithCritRes is error {

                io:println("failed to send showAllWithCriteria complete message: ", showAllWithCritRes.message());

                break;

            } else {

                if showAllWithCritRes is () {

                    break;

                } else {

                    io:println("showAllWithCriteria response: ", showAllWithCritRes.fns);

                    showAllWithCritRes = showAllWithCritStream->receiveShowAllWithCritRes();

                }

            }

        }

    }



    DeleteFnReq delFnReq = {

        funcName: "Sunny",

        versionNum: 1

    };

    DeleteFnRes|grpc:Error delRes = ep->delete_fn(delFnReq);

    if delRes is error {

        io:println("Error deleting fn: ", delRes.message());

    } else {

        io:println("Success: ", delRes.message);

    }


}

