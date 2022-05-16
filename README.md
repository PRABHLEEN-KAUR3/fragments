# fragments
My repository for CCP555 (cloud computing) project.

--- LAB 01 ---

Instructions on how to run various scripts I created using:

1. lint: I first installed the ESLint using npm as "npm install eslint --save-dev" and used it as development dependency. Then, after setting up the configuration file, I created a eslintrc.js file and added my lint script into it. To run the script, I used "npm run lint" on integrated vs terminal and hit enter and made sure there were no errors.

2. start: To start the server, I installed nodemon package using npm along with --save-dev. I added the start script into scripts in package.json file. Further, I run "npm start" in integrated terminal of visual studio code. After I hit enter, the log level information appeared. On running curl command as "curl http://localhost:8080" on powershell, I got all the log information on integrated terminal about what happened.

3. dev: I added the dev script to package.json and used cross-env package for setting LOG_LEVEL before starting nodemon. I run "npm run dev" in the integrated vs terminal, it printed the message of server started in color codes. Further, on running the curl command on powershell, displays the same log information in vs terminal.

4. debug: Similar to dev, I used cross env package for setting LOG_LEVEL before starting nodemon in its script. Else it would give errors that " 'LOG_LEVEL' is not recognized as an internal or external command, operable program or batch file." Further, to use "node run debug", by setting breakpoints in vs terminal, I enabled Toggle Auto Attach debugger by setting it to 'smart' in the vs code settings. Activating auto attach will automatically attach node debugger to node.js processes being debugged.
