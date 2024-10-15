Config = {
    lang = 'it',
    framework = 'qb', --qb/esx/standalone (only used for item) -- if "standalone" is selected you should use /headbag command
    itemname = 'head_bag', -- add it to your framework items or use one you already have (not available in standalone)
    command = {
        enabled = false, -- set to true if you want to use command instead of item - LEAVE FALSE if you're using framework = "standalone"
        commandname = "headbag" -- only available is command is enabled = true or if framework = "standalone"
    }
}

Locales = {
    en = {
        nohandsup = "Player needs to have hands up to do it",
        nobag = "You can remove a headbag only to a player who already have it",
        noonenearby = "No Player Nearby"
    },
    it = {
        nohandsup = "Il giocatore deve avere le mani in alto o deve essere ammanettato per farlo",
        nobag = "Puoi togliere il sacchetto solo a chi lo hai gia messo",
        noonenearby = "Nessun giocatore vicino"
    },
}