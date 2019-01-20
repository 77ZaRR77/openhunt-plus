MOST IMPORTANT FIRST TO MOVE INTO NEWEST GAMECODE
 BASEQ3E FOR EXAMPLE OR ioq3 then bugfix and others.

#### BUGS n FIX


* PunkBuster in ui_servers2.c should be pwnd
* fix the bug in UI both skirmish and from multiplayer changing ADVANCED OPTIONS simply not applying to game
probably same goes to game templates
* fix fov by standart, not only with cfg (moving into baseq3e/ioq3/mint-arena gamecode would fix it, probably that would be in next repo)
* fix the bug with grapplinghook, while crounching it will brake.
Probably because shooting entry is too low from player,
also possible to change grapplinghook type by cvar.


#### FEATURES

* include g_unlagged.c
* More agressive/fast reaction monsters, especially guard type
* look if possible to make monster-bots and bots separate so real bots can be added
* investigate more about mapping for gamemode "Escape from Hell" (EFH).


#### Addons were made 

* autoexec.cfg fix fov
* small fov fix thanks to ZTM for 1.29h in autoexec.cfg file, in-game player need to press "z" for one time.
* zzz-hunt_patch.pk3  for fixing gfx in ffa gamemode
* replacement for - hunt.pk3 and hunt_hellmodels.pk3, now it's red blood (still needs improvement a bit) 
both .pk3s gfx blood textures and models/gibs texture


#### Additional info
Thoose two files made by the original author from his website are missed.
If first file is probably not necessary because of new improved q3tools by Eugene C., 
then second would be very useful, though searching didn't give any results nor webarchive.

![screenshot](/docs/JUHOX_files.JPG)

I've made a test EFH map without the mentioned file though, needs more investigation to make it work fine and write mini-instuction.


