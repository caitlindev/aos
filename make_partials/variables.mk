# This is the name of your module (used in the .tar.bz2 file ONLY)
#MODULE=g4plus_aircraft_admin
MODULE=g4plus_change_to_module_name

# This is the PATH for deployment
#TARGET=ac/admin/aircraft/tails
TARGET=module/path/goes/here

# This is where this module should be deployed
DEPLOY_TARGET=/var/www/g4plus_portal

# This is a summary of the module
#SUMMARY=G4Plus / Aircraft Administration
SUMMARY=G4Plus / Change to Module Name

#DESCRIPTION=The Aircraft Administration module
DESCRIPTION=This should be changed to a description of the module

# How times should we attempt to install bower modules and node modules before giving up
RETRY_AMOUNT=5

# These are shared variables that are generally not overridden
RELEASE_CURRENT=current.tar.bz2
RELEASE_PREVIOUS=previous.tar.bz2

DEPLOY_USER=deploy
DEPLOY_GROUP=web_users
