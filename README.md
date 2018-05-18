# Superheroes
App developed following MVVM architecture, using Auto Layout with constraints and Swift 4.1 and Xcode 9.3.1 as environment without any third party library. 

The app is composed of a table view populated via REST API call to fetch JSON data and a detail view which is showed after pressing each cell.

Table view has been developed with a Pull-to-Refresh control in order to update contents of the table and a loading images asynchronously class with catching through NSCache object.
