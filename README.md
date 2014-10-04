AngularJS code example - Allegiant AOS (aircraft out-of-service) MX application
=======================================

This is a project I am currently working on for Allegiant. The current state of this application is somewhere in between prototype and integration. Please consider the following notes before running the application:

- Being that this is a prototype and I'm still working on it, please bare in mind that there are still cross-browser issues, the unit tests are out-of-date, and the code needs major refactoring in many areas. It's certainly not responsive yet, either.

- I have mocked most of the web services I am using, though some parts of the application may be trying to call live services which you won't have access to outside of Allegiant's network.

- I would noramlly create a gitignore on the bower components and node modules, but due to lack of network I have included these directories in my commit.

- No, I did not write all of these components, but I wrote a few.




You shouldn't have to compile or install anything, so running the server shell script from within the project folder:

./scripts/server.sh

...should start the project.