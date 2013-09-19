## Skapa projekt

I ett terminalfönster/kommandotolk skriv:

    openfl create project HaxeSpel
    cd HaxeSpel
    openfl test flash

Kör igång ett tomt vitt "spel" i din webbläsare.

## Ställ in din utvecklingsmiljö

### IntelliJ

Öppna IntelliJ. Välj File ➤ Import Project... Leta upp HaxeSpel och välj OK. "Create project from existing sources" är valt, klicka på Next, Next. Om HaxeSpel/Export/flash/haxe är med i listan klicka bort den, det är bara HaxeSpel/Source som ska va iklickad. Klicka på Next, Next, Next. Välj Haxe som SDK. Klicka på Next, Finish. Nu ska du ha ett projekt öppet.

I listan till vänster kan vi leta upp källkoden till vårt "spel", klicka på ➤HaxeSpel, ➤Source, Main.hx. Som du ser är den ganska tom.

Nu behöver vi säga åt IntelliJ att det är ett OpenFL projekt (den vet bara att det är ett Haxe projekt, inte att det är OpenFL vi vill använda). File ➤ Project Structure... I dialogen välj Modules, HaxeSpel, Haxe. Här är nog "Haxe compiler" ifyllt. Välj "OpenFL" och klicka på OK.

Snart klara, vi behöver bara säga åt IntelliJ hur den ska köra vårt spel. Run ➤ Edit Configurations... Längst uppe till vänster i dialogen finns en plus knapp, klicka på den och välj Haxe Application. Ändra namnet från "Unnamed" till "HaxeSpel". Klicka på knappen till höger om Module: och välj HaxeSpel. Klicka på OK.

Nu kan du köra "spelet" genom att klicka på den gröna spela knappen, eller välja Run ➤ Run 'HaxeSpel'. Den gör samma sak som `openfl test flash` som vi använde tidigare, men det är lite smidigare.
