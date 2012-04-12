Running BlogEngine.NET 1.4.5 using SQLite:

If you wish to use SQLite to store all your blog data, this is the guide for you.
Included in this folder is a default SQLite database, that you can use to get you 
started with your blog.  In addition, you will find a sample web.config file with
the needed changes to use SQLite and an upgrade script for current SQLite users 
who wish to upgrade from 1.4 to 1.4.5

Instructions for new setup:

1. Download the SQLite ADO Providers Binaries from the ADO.NET 2.0 Provider for 
SQLite project. http://sourceforge.net/projects/sqlite-dotnet2
2. Find the System.Data.SQLite.DLL from the download and copy it to your blog's bin folder.
3. Copy BlogEngine.s3db from the SQLite folder to your App_Data folder.
4. Rename SQLiteWeb.Config to Web.config and copy it to your blog folder.  (This will
overwrite your existing web.config file.  If this is not a new installation, make sure 
you have a backup.)
5. Surf out to your Blog and see the welcome post.
6. Login with the username Admin and password admin.  Change the password.  Note: This 
data is case sensitive.

Upgrading from 1.4.0

1. If you don't already have SQLite Admin tool installed, you'll need to get one. SQLite
Admin has worked great for me.  (http://sqliteadmin.orbmu2k.de/)
2. Open your BlogEngine.s3db database.  (You will likely need to copy your BlogEngine.s3db
file from your web server, perform the update, and copy it back out after these changes
depending on your setup.)
3. You will need to manually edit the be_DataStoreSettings table.  Change the field 
"Settings" to be of type TEXT.
4. Then, Execute the upgrade script against the database.  
5. The web.config file has changed from 1.4.0 to 1.4.5.  It will likely be easiest to start
with the sample web.config file as described above, but if you have other changes in it, 
you'll need to merge them.

Important Upgrade Note: Upgrading will cause you to lose setting in your extensions and 
widget framework.  Please make note of these so you can put them back in place after 
the upgrade.

Additional information can be found at http://dotnetblogengine.net