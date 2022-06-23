Config        = {}
Config.Locale = 'es'

Config.EnableESXIdentity = false -- only turn this on if you are using esx_identity and want to use RP names
Config.OnlyFirstname     = false
Config.EnableOneSyncInfinity = false
Config.reportCooldown = 60 --seconds
Config.warnMax = 3  --how many warn player can get before getting kicked?
Config.adminRanks = { -- change this as your server ranking ( default are : superadmin | admin | moderator )
				'superadmin',
				'admin',
				'moderator',
				--'jradmin',
				--'sradmin',
				--'headadmin',
				--'moderator',
				--'manager',
				--'owner',
				--'developer',
            }