/**
 * Inherits Main apps's Application.cfc settings
 *
 * (Change only what's needed for testing)
 */
component extends="../Application"{

    this.ormsettings = {
        cfclocation="../home/model/beans",
    };

    // set a datasource exclusively for tests
    //this.datasource = this.datasource & "_tests";

}
