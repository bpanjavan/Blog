Running BlogEngine.NET 1.4.5 using VistaDB Express:

If you wish to use VistaDB or VistaDB Express to store all your blog data, this is 
where you want to be.  Included in this folder is a default VistaDB database, that 
you can use to get you started with your blog.  In addition, you will find a sample
web.config file with the needed changes to use VistaDB and an upgrade script for 
current VistaDB users who wish to upgrade from 1.4 to 1.4.5

Instructions for new setup:

1. If you don't already have VistaDB or VistaDB Express installed locally, download 
VistaDB Express from vistadb.net and install it locally.
2. Find VistaDB.NET20.dll on your PC and copy it to your blog's Bin folder. 
3. Copy BlogEngine.vdb3 from the VistaDB folder to your App_Data folder.
4. Rename VistaDBWeb.Config to Web.config and copy it to your blog folder.  (This will
overwrite your existing web.config file.  If this is not a new installation, make sure 
you have a backup.)
5. Surf out to your Blog and see the welcome post.
6. Login with the username admin and password admin.  Change the password.

Upgrading from 1.4.0

1. If you don't already have VistaDB or VistaDB Express installed locally, download 
VistaDB Express from vistadb.net and install it locally.
2. Open your BlogEngine.vdb3 database and execute the upgrade script against it.  (You will 
likely need to copy your BlogEngine.vdb3 file from your web server, perform the update, and 
copy it back out depending on your setup.
3. The web.config file has changed from 1.4.0 to 1.4.5.  It will likely be easiest to start
with the sample web.config file as described above, but if you have other changes in it, 
you'll need to merge them.

Important Upgrade Note: Upgrading will cause you to lose setting in your extensions and 
widget framework.  Please make note of these so you can put them back in place after 
the upgrade.

Additional information can be found at http://dotnetblogengine.net

Notice:

While BlogEngine.NET is open source and VistaDB Express is free to use, there are a few restrictions.  
VistaDB Express is only free to use for non commercial uses.  If you are commercial, you will need to 
purchase a license to use it.  In addition, the VistaDB Express license requires that you place a link 
back to them in your product.  A link back the vistadb.net in your page footer or side bar would show 
your appreciation.