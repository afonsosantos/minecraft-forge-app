# Steps to update:
1) Download the server JAR file here: https://files.minecraftforge.net/
2) Run the .jar file and choose to "Install Server"
3) Go to the directory you installed the server to and copy the contents into the "forge" directory in this repository
4) Update the minecraft and forge versions in the Dockerfile

# Adding Mods:
To add mods, first download a mod from here (must be built for Forge.): https://www.curseforge.com/minecraft/mc-mods?filter-game-version=2020709689%3A7498&filter-sort=4

Add the jar files for the mod to your /app/data/mods folder and add the corresponding jar files to youe minecraft forge client.