component {

    property name="controller" inject="coldbox";
    /***
     * Helper method to simply a "clean" reload of a wirebox mapping from the file system
     **/
    function reloadModule( required string moduleName ) {
        variables.controller.getServices().moduleService.reload( moduleName );
    }

    /**
     * Helper method to simplify replacing mappings in Wirebox, helpful in mocking in integration testing
     **/
    function replaceMapping( required string mapping, required target ) {
        variables.controller
            .getWireBox()
            .getBinder()
            .unmap( mapping );
        variables.controller
            .getWireBox()
            .getBinder()
            .map( mapping )
            .toValue( target );
    }


    /***
     * Accepts a mapping name and stores the mapping from WireBox in the variables scope in order to be restored later.
     *
     **/
    function storeOriginalMapping( mappingName ) {
        variables.originalMappings = variables.keyExists( "originalMappings" ) ? variables.originalMappings : {};
        var binder = variables.controller.getWireBox().getBinder();
        variables.controller.getWirebox().getInstance( mappingName );
        variables.originalMappings[ mappingName ] = variables.controller
            .getWireBox()
            .getBinder()
            .getMapping( mappingName );
    }

    /***
     * Loops through the stored mappings and restores them to WireBox
     *
     **/
    function restoreMappings() {
        variables.originalMappings.each( function( mapping, comp ) {
            variables.controller
                .getWireBox()
                .getBinder()
                .setMapping( mapping, comp );
        } );
    }

    /***
     * Accepts a struct of mappings and a callback function. The struct of mappings has the name of the mapping as the key and the target as the value. WhileSwapped
     * stores the original mapping from Wirebox in the Variables Scope, swaps the mapping for the submitted value, runs the callback and then restores the original mapping to WireBox.
     *
     * @mappings - A struct with the name of the mapping as the key and the target as the value
     * @callback - The function to run between mappings
     * @verifyMappingExists - whether or not the function should verify if the mapping exists in WireBox before trying to swap the mappings.
     **/
    function whileSwapped( struct mappings = {}, any callback, boolean verifyMappingExists = true ) {
        var binder = getWireBox().getBinder();
        var originalMappings = {};
        mappings.each( function( mapping, componentCFC ) {
            if ( verifyMappingExists ) {
                expect( binder.mappingExists( mapping ) ).toBeTrue( "No #mapping# already configured in WireBox" );
            }
            originalMappings[ mapping ] = binder.getMapping( mapping );
            binder.map( alias = mapping, force = true ).toValue( componentCFC );
        } );

        try {
            callback();
        } catch ( any e ) {
            rethrow;
        } finally {
            originalMappings.each( function( mapping, componentCFC ) {
                binder.setMapping( mapping, componentCFC );
            } );
        }
    }

    /***
     * Clears all stored mappings from this cfc's variable scope.
     *
     **/
    function clearStoredMappings() {
        variables.originalMappings = {};
    }

}
