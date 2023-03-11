return graphics.newSprite(
    images.icons,
	{
		{x = 0, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend
		{x = 150, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Boyfriend Losing
		{x = 300, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: DanTDM
		{x = 450, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: DanTDM Losing
		{x = 600, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: DrTrayaurus
		{x = 750, y = 0, width = 150, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: DrTrayaurus Losing
	},
	{
		["boyfriend"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["boyfriend losing"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["dantdm"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["dantdm losing"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["drtrayaurus"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0},
		["drtrayaurus losing"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},
	},
	"boyfriend",
	false
)
