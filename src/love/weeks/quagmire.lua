--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

local difficulty

local stageBack, stageFront, curtains
local timer

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		curWeek = "quagmire"

		song = songNum
		difficulty = songAppend

        boyfriendIcon:animate("quagbf", false)
		enemyIcon:animate("quagmire", false)

        boyfriend = love.filesystem.load("sprites/quagmire/quagbf.lua")()
		enemy = love.filesystem.load("sprites/quagmire/quagmire.lua")()

        fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")()

        enemy.x = -400
        boyfriend.x = 400
        boyfriend.y = 75

        camera.defaultZoom = 0.8

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("songs/quagin/Inst.ogg", "stream")
		voices = love.audio.newSource("songs/quagin/Voices.ogg", "stream")

		self:initUI()

		if not inCutscene then
			weeks:setupCountdown()
		end
	end,

	initUI = function(self)
		weeks:initUI()

        if difficulty == "-easy" then 
            difficulty = ""
        end
		weeks:generateNotes("data/quagin/quagin" .. difficulty .. ".json")
	end,

	update = function(self, dt)
		weeks:update(dt)

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "quagmire" then
				enemyIcon:animate("quagmire losing", false)
			end
		else
			if enemyIcon:getAnimName() == "quagmire losing" then
				enemyIcon:animate("quagmire", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (voices:isPlaying()) and not paused and not inCutscene then
			status.setLoading(true)

			graphics:fadeOutWipe(
				0.7,
				function()
					Gamestate.switch(menu)

					status.setLoading(false)
				end
			)
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(camera.zoom, camera.zoom)

            love.graphics.rectangle("fill", -1000, -1000, 10000, 10000)

            enemy:draw()
            boyfriend:draw()
			
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		enemy = nil
		boyfriend = nil
		girlfriend = nil

		graphics.clearCache()

		weeks:leave()
	end
}
