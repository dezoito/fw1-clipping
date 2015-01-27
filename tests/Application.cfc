/**
 * Inherits Main apps's Application.cfc settings
 *
 * (Change only what's needed for testing)
 */
component extends="../Application"{

    // sets datasource to a test database
    this.datasource = this.datasource & "_test";
    application.datasource = this.datasource;

    this.ormsettings = {
        cfclocation="../home/model/beans",
    };


    this.triggerDataMember = true // so we can access properties directly (no need for getters and setters)


}
