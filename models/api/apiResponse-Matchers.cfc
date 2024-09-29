component singleton extends="testboxUtils.models.baseMatcher" {

    // TODO: TO BE IMPLEMENTED
    // - ToHaveAPIErrorWithMessage( “partial message”, type="complete|regex|contains|startsWith|endWith" ) //position=any
    // - expect( getAPIResponseMessages( event ) ).toHaveLengthGTE( 1 )

    helpers = new "apiResponse-helpers"( );

    function toHaveAPIResponse( expectation, args = {} ) {
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        var isValidAPIResponse = true;
        if ( !isStruct( apiResponse ) ) {
            expectation.message = "The apiResponse is not a struct";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse, { key: "data" } ) ) {
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse, { key: "error" } ) ) {
            return false;
        }
        if ( !isBoolean( apiResponse.error ) ) {
            expectation.message = "The error key must be a boolean value";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse, { key: "messages" } ) ) {
            return false;
        }
        if ( !isArray( apiResponse.messages ) ) {
            expectation.message = "The messages key is not an array";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse, { key: "pagination" } ) ) {
            return false;
        }
        if ( !isStruct( apiResponse.pagination ) ) {
            expectation.message = "The pagination key is not a struct";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse.pagination, { key: "totalPages" } ) ) {
            return false;
        }
        if ( !isNumeric( apiResponse.pagination.totalPages ) ) {
            expectation.message = "The pagination.totalPages key is not an numeric";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse.pagination, { key: "maxRows" } ) ) {
            return false;
        }
        if ( !isNumeric( apiResponse.pagination.maxRows ) ) {
            expectation.message = "The pagination.maxRows key is not numeric";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse.pagination, { key: "offset" } ) ) {
            return false;
        }
        if ( !isNumeric( apiResponse.pagination.offset ) ) {
            expectation.message = "The pagination.offset key is not an numeric";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse.pagination, { key: "page" } ) ) {
            return false;
        }
        if ( !isNumeric( apiResponse.pagination.page ) ) {
            expectation.message = "The pagination.page key is not an numeric";
            return false;
        }
        if ( !_toHaveKeyWithCase( expectation, apiResponse.pagination, { key: "totalRecords" } ) ) {
            return false;
        }
        if ( !isNumeric( apiResponse.pagination.totalRecords ) ) {
            expectation.message = "The pagination.totalRecords key is not an numeric";
            return false;
        }
        return true;
    }

    function toHaveAPIError( expectation, args = {} ) {
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }
        if ( expectation.isNot ) {
            if ( apiResponse.error ) {
                expectation.message = "The API Response is an error when you expected it not to be an error.";
                return false;
            }
            return true;
        } else {
            if ( !apiResponse.error ) {
                expectation.message = "The API Response is not an error";
                return false;
            }
            return true;
        }
    };

    function toHaveAPIErrorWithMessage( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }
        if ( expectation.isNot ) {
            if ( apiResponse.error ) {
                expectation.message = "The API Response is an error when you expected it not to be an error.";
                return false;
            }
        } else {
            if ( !apiResponse.error ) {
                expectation.message = "The API Response is not an error";
                return false;
            }
        }
        if ( expectation.isNot ) {
            if ( arrayFind( apiResponse.messages, args.expectedMessage ) ) {
                expectation.message = "The API Response contains the message [#args.expectedMessage#] when you expected it not to contain the message.";
                return false;
            }
            return true;
        } else {
            if ( !arrayFind( apiResponse.messages, args.expectedMessage ) ) {
                expectation.message = "The API Response does not contain the message [#args.expectedMessage#]";
                return false;
            }
            return true;
        }
    }

    function toHaveAPISuccessWithMessage( expectation, args = { message: "" } ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }
        if ( expectation.isNot ) {
            if ( !apiResponse.error ) {
                expectation.message = "The API Response is a success when you expected it not to be a success.";
                return false;
            }
        } else {
            if ( apiResponse.error ) {
                expectation.message = "The API Response is not a success";
                return false;
            }
        }
        if ( expectation.isNot ) {
            if ( arrayFind( apiResponse.messages, args.expectedMessage ) ) {
                expectation.message = "The API Response contains the message [#args.expectedMessage#] when you expected it not to contain the message.";
                return false;
            }
            return true;
        } else {
            if ( !arrayFind( apiResponse.messages, args.expectedMessage ) ) {
                expectation.message = "The API Response does not contain the message [#args.expectedMessage#]";
                return false;
            }
            return true;
        }
    }

    function toHaveAPIResponseWithNoMessages( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !apiResponse.messages.len() ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have no messages.";
                return false;
            }
            return true;
        } else {
            if ( apiResponse.messages.len() ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have no messages.";
                return false;
            }
            return true;
        }
    }

    function toHaveAPIResponseWithSomeMessages( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( apiResponse.messages.len() ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have some messages.";
                return false;
            }
            return true;
        } else {
            if ( !apiResponse.messages.len() ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have some messages.";
                return false;
            }
            return true;
        }
    }

    function toHaveAPIResponseWithOneMessage( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( apiResponse.messages.len() == 1 ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] message when you did not expect it to have 1 message.";
                return false;
            }
            return true;
        } else {
            if ( !apiResponse.messages.len() == 1 ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have 1 messages.";
                return false;
            }
            return true;
        }
    }

    function toHaveAPIResponseWithMessageCount( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( apiResponse.messages.len() == expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have #args.expectedCount# messages.";
                return false;
            }
            return true;
        } else {
            if ( !apiResponse.messages.len() == expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have #expectedCount# messages.";
                return false;
            }
            return true;
        }
    }

    function ToHaveAPIResponseWithMessagesCountGt( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !apiResponse.messages.len() gt expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have more than #args.expectedCount# messages.";
                return false;
            }
            return true;
        } else {
            if ( apiResponse.messages.len() gt expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have more than #expectedCount# messages.";
                return false;
            }
            return true;
        }
    }

    function ToHaveAPIResponseWithMessagesCountGte( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !apiResponse.messages.len() gte expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have more than or equal to #args.expectedCount# messages.";
                return false;
            }
            return true;
        } else {
            if ( apiResponse.messages.len() gte expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have more than or equal to #expectedCount# messages.";
                return false;
            }
            return true;
        }
    }

    function ToHaveAPIResponseWithMessagesCountLte( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !apiResponse.messages.len() lt expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have less than to #args.expectedCount# messages.";
                return false;
            }
            return true;
        } else {
            if ( apiResponse.messages.len() lt expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have less than to #expectedCount# messages.";
                return false;
            }
            return true;
        }
    }

    function ToHaveAPIResponseWithMessagesCountLTE( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }
        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !apiResponse.messages.len() lte expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you did not expect it to have less than or equal to #args.expectedCount# messages.";
                return false;
            }
            return true;
        } else {
            if ( apiResponse.messages.len() lte expectedCount ) {
                expectation.message = "The API Response contains [#apiResponse.messages.len()#] messages when you expected it to have less than or equal to #expectedCount# messages.";
                return false;
            }
            return true;
        }
    }


    // - ToHaveAPIResponseWithDataEmptyString()
    function toHaveAPIResponseWithDataEmptyString( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !isSimpleValue( apiResponse.data ) || !apiResponse.data.len() == 0 ) {
                expectation.message = "The API Response contains data of an empty string when you did not expect it to be a empty string.";
                return false;
            }
            return true;
        } else {
            if ( !isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not a simple value when you expected an empty string.";
                return false;
            } else if ( apiResponse.data.len() ) {
                expectation.message = "The API Response contains data  [#apiResponse.data#] with a length of [#apiResponse.data.len()#] characters when you expected it to have an empty string.";
                return false;
            }
            return true;
        }
    }

    // - TODO: ToHaveAPIResponseWithDataString()

    // - ToHaveAPIResponseWithDataNumeric()
    function toHaveAPIResponseWithDataNumeric( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( isSimpleValue( apiResponse.data ) && isNumeric( apiResponse.data ) ) {
                expectation.message = "The API Response contains data of a numeric type when you did not expect it to be numeric.";
                return false;
            }
            return true;
        } else {
            if ( !isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not a simple value when you expected it to be numeric.";
                return false;
            } else if ( !isNumeric( apiResponse.data ) ) {
                expectation.message = "The API Response contains data [#apiResponse.data#] which is not numeric when you expected it to be numeric.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArray()
    function toHaveAPIResponseWithDataArray( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data of array type when you did not expect it to be an array.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArrayCount()
    function toHaveAPIResponseWithDataArrayCount( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if (
                !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) && apiResponse.data.len() == args.expectedCount
            ) {
                expectation.message = "The API Response contains data of array type with a count of [#args.expectedCount#] when you did not expect it to be an array with a count of [#args.expectedCount#] items.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array with a count of [#args.expectedCount#] items.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array.";
                return false;
            } else if ( apiResponse.data.len() != args.expectedCount ) {
                expectation.message = "The API Response contains data which is an Array with [#apiResponse.data.len()#] items when you expected it to be an array with count of [#args.expectedCount#] items.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArrayCountGt()
    function toHaveAPIResponseWithDataArrayCountGt( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if (
                !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) && apiResponse.data.len() GT args.expectedCount
            ) {
                expectation.message = "The API Response contains data of array type with a count greater than [#args.expectedCount#] items when you did not expect it to be.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array with a count greater than [#args.expectedCount#] items.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array  with a count greater than [#args.expectedCount#] items.";
                return false;
            } else if ( apiResponse.data.len() != args.expectedCount ) {
                expectation.message = "The API Response contains data which is an Array with [#apiResponse.data.len()#] items when you expected it to be an array with count greater than [#args.expectedCount#] items.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArrayCountGte()
    function toHaveAPIResponseWithDataArrayCountGte( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if (
                !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) && apiResponse.data.len() GTE args.expectedCount
            ) {
                expectation.message = "The API Response contains data of array type with a count greater than or equal to [#args.expectedCount#] items when you did not expect it to be.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array with a count greater than or equal to [#args.expectedCount#] items.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array with a count greater than or equal to [#args.expectedCount#] items.";
                return false;
            } else if ( apiResponse.data.len() != args.expectedCount ) {
                expectation.message = "The API Response contains data which is an Array with [#apiResponse.data.len()#] items when you expected it to be an array with count greater than [#args.expectedCount#] items.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArrayCountLt()
    function toHaveAPIResponseWithDataArrayCountGt( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if (
                !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) && apiResponse.data.len() LT args.expectedCount
            ) {
                expectation.message = "The API Response contains data of array type with a count less than [#args.expectedCount#] items when you did not expect it to be.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array with a count less than [#args.expectedCount#] items.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array  with a count less than [#args.expectedCount#] items.";
                return false;
            } else if ( apiResponse.data.len() != args.expectedCount ) {
                expectation.message = "The API Response contains data which is an Array with [#apiResponse.data.len()#] items when you expected it to be an array with count less than [#args.expectedCount#] items.";
                return false;
            }
            return true;
        }
    }

    // - ToHaveAPIResponseWithDataArrayCountLte()
    function toHaveAPIResponseWithDataArrayCountGte( expectation, args = {} ) {
        param args.expectedCount = 0;
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedCount = args[ 1 ];
        }
        if ( structKeyExists( args, 2 ) ) {
            args.expectedMessage = args[ 2 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if (
                !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) && apiResponse.data.len() LTE args.expectedCount
            ) {
                expectation.message = "The API Response contains data of array type with a count less than or equal to [#args.expectedCount#] items when you did not expect it to be.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be an array with a count less than or equal to [#args.expectedCount#] items.";
                return false;
            } else if ( !isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Array when you expected it to be an array with a count less than or equal to [#args.expectedCount#] items.";
                return false;
            } else if ( apiResponse.data.len() != args.expectedCount ) {
                expectation.message = "The API Response contains data which is an Array with [#apiResponse.data.len()#] items when you expected it to be an array with count less than [#args.expectedCount#] items.";
                return false;
            }
            return true;
        }
    }


    // - ToHaveAPIResponseWithDataStruct()
    function toHaveAPIResponseWithDataStruct( expectation, args = {} ) {
        param args.expectedMessage = "";
        if ( structKeyExists( args, 1 ) ) {
            args.expectedMessage = args[ 1 ];
        }

        try {
            var apiResponse = helpers.getAPIResponse( expectation.actual );
        } catch ( any e ) {
            expectation.message = "Item passed may not be JSON, API Response Struct, or Event";
            return false;
        }
        if ( !toHaveAPIResponse( expectation, { "getAPIResponse": apiResponse } ) ) {
            return false;
        }

        if ( expectation.isNot ) {
            if ( !isSimpleValue( apiResponse.data ) && isArray( apiResponse.data ) ) {
                expectation.message = "The API Response contains data of struct type when you did not expect it to be a struct.";
                return false;
            }
            return true;
        } else {
            if ( isSimpleValue( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is a simple value [#apiResponse.data#] when you expected it to be a struct.";
                return false;
            } else if ( !isStruct( apiResponse.data ) ) {
                expectation.message = "The API Response contains data which is not an Struct when you expected it to be a Struct.";
                return false;
            }
            return true;
        }
    }


    /**
     * Private helper function
     */
    private function _toHaveKeyWithCase( expectation, subActual, args = {} ) {
        param args.key = "";
        if ( structKeyExists( args, 1 ) ) {
            args.key = args[ 1 ];
        }
        param args.message = "";
        if ( structKeyExists( args, 2 ) ) {
            args.message = args[ 2 ];
        }

        if ( args.key == "" ) {
            expectation.message = "No Key Provided.";
            return false;
        }

        if ( !listFind( subActual.keyList(), args.key ) ) {
            if ( listFindNoCase( subActual.keyList(), args.key ) ) {
                expectation.message = "The key(s) [#args.key#] does exist in the target object, but the Case is incorrect. Found keys are [#structKeyArray( subActual ).toString()#]";
            } else {
                expectation.message = "The key(s) [#args.key#] does not exist in the target object, with or without case sensitivity. Found keys are [#structKeyArray( subActual ).toString()#]";
            }
            return false;
        }
        return true;
    }

}
