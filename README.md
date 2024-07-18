## What Is This Project
This project is a version of [TwitchDownloader](https://github.com/lay295/TwitchDownloader), which now has graphical UI for MacOS built on SwiftUI! UI part communicates with original C# library using Web API.
## What happened to Twitch Downloader's original code
Some of the original code for the CLI was changed to account that all the commands will be received via POST requests through Web API and not via command line. This means that this code will not support newer versions of Twitch Downloader, as with Web API support being added, some principles of libraries were changed. Additionally, this version supports some new functions original library doesn't offer.
## New functions of the library
- Folder for file download can be specified
## Project's To-Do list
- [x] Correctly send data from client to server 
- [ ] Change how data is sent, as now it is transferred as a plain string which is passed as an argument into main function (essentially acting like a CLI input)
- [ ] Made library send data back as well, as currently data can't be sent back from the library, so it is a one-way communication, only client -> server
- [ ] Don't stop server on error, just throw message back to client
- [ ] Implement all the modes of the original library
- [x] Create a proper build configuration to compile C# and Swift parts into a single .app file
- [ ] Cool UI
