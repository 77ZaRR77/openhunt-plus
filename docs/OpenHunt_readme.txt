***          OpenHunt Mod         *** 
***                               *** 
***         by J. Hoffmann        *** 
***  www.planetquake.com/modifia  *** 
***     juhox@planetquake.com     *** 



Introduction

   This package contains the source code of the Q3A modification
   "OpenHunt". It's of no use for you unless you're a programmer.

   OpenHunt is nearly identical to Hunt, so this source code can
   be regarded as Hunt's source code. The differences between
   Hunt and OpenHunt are as follows.

      - OpenHunt can't create gamestamps.

      - OpenHunt is incompatible to Hunt. That is, an OpenHunt
        client can't connect to a Hunt server, and vice versa.
      
      - OpenHunt doesn't contain any countermeasures against
        cheating.

      - Some strings have been changed from "Hunt" to "OpenHunt".

   The changes mainly intend to prevent cheating in Hunt. All the
   interesting features of the original code, like monsters, the
   map generator, the bot AI enhancements, the special effects,
   etc., are still present. When playing OpenHunt you'll hardly
   notice any change.

   This also means that any bugs you find in the OpenHunt source
   are likely to be found in the Hunt source too. So, please
   report them to me (juhox@planetquake.com).


Requirements

   - Quake III Arena 1.32

   - tools to compile the source code

   - the appropriate version of the Hunt mod (this is needed for
     the media, as they're not included in this package).


Installation

   The following brief instructions assume you're familiar with
   creating Q3A mods. Visit www.planetquake.com/code3arena if you
   don't know the basics.

   1. Install the Hunt mod, if you haven't done that yet. See
      Hunt's readme.txt for installation instructions.

   2. Create a copy of the Quake3 1.29h source code. This is
      needed because some unchanged source files are not included
      in this package.

   3. Copy the OpenHunt source files over the original files (in
      your duplicated source directory, of course).

   4. Compile the OpenHunt source code.

   5. Put the *.qvm files in "openhunt.pk3".

   6. Duplicate your Hunt installation directory. Call the new
      directory "OpenHunt".

   7. Copy "openhunt.pk3" into the "OpenHunt" folder.

   8. Run the OpenHunt mod. Verify that the title screen says
      "OpenHunt Mod". If it says "Hunt Mod", then there's
      something wrong with your openhunt.pk3. Make sure its
      contents are exactly as follows:

         vm/cgame.qvm
         vm/qagame.qvm
         vm/ui.qvm

   
   If you've trouble with one of these steps, ask for help at the
   Hunt forum at www.planetquake.com/modifia
