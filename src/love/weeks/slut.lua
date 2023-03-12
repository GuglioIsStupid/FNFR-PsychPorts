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

		curWeek = "danTDM"

		song = songNum
		difficulty = songAppend

		enemyIcon:animate("drtrayaurus", false)

		if song == 1 then 
			trayBG = graphics.newImage(graphics.imagePath("slut/traybg"))
			slutbop = love.filesystem.load("sprites/slut/slutbop.lua")()
			slutbop.sizeX, slutbop.sizeY = 0.85, 0.85
			arrowbop = love.filesystem.load("sprites/slut/arrowbop.lua")()
			arrowbop.sizeX, arrowbop.sizeY = 0.85, 0.85

			trayBG.x = 430
			trayBG.y = 180
			trayBG.sizeX, trayBG.sizeY = 1.7, 1.7

			slutbop.x = 400
			arrowbop.x = 275

			slutbop.y = -175
			arrowbop.y = -75

			enemy = love.filesystem.load("sprites/slut/tray.lua")()

			enemy.sizeY=1.25
			enemy.sizeX = 1.25
			enemy.y = 75

			video = cutscene.video("videos/cutsceneslut.ogv")
			video:play()
			video.scale = 1.5
		else
			enemy = boyfriend
			bg = love.graphics.newVideo("videos/1.ogv")
		end

		camera.defaultZoom = 1

		boyfriendIcon:animate("dantdm")

		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 1 then
			inst = love.audio.newSource("songs/slut-and-homophobic/Inst.ogg", "stream")
			voices = love.audio.newSource("songs/slut-and-homophobic/Voices.ogg", "stream")
		else
			inst = nil
			voices = love.audio.newSource("songs/what-are-you-doing/Inst.ogg", "stream")
		end

		self:initUI()

		if not inCutscene then
			weeks:setupCountdown()
		end
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 1 then
			weeks:generateNotes("data/slut-and-homophobic/slut-and-homophobic.json")
		else
			weeks:generateNotes("data/what-are-you-doing/what-are-you-doing.json")
		end
	end,

	update = function(self, dt)
		weeks:update(dt)

		if inCutscene then
			if not video:isPlaying() then 
				inCutscene = false
				video:destroy()
				weeks:setupCountdown()
			end
		end

		if song == 1 then
			slutbop:update(dt)
			arrowbop:update(dt)

			if beatHandler.onBeat() then 
				if beatHandler.curBeat % 2 == 0 then
					slutbop:animate("anim")
					arrowbop:animate("anim")
				end
			end
			slutbop.y = -175 + math.sin(love.timer.getTime()) * 30
		end

		if health >= 1.595 then
			if enemyIcon:getAnimName() == "drtrayaurus" then
				enemyIcon:animate("drtrayaurus losing", false)
			end
		else
			if enemyIcon:getAnimName() == "drtrayaurus losing" then
				enemyIcon:animate("drtrayaurus", false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (voices:isPlaying()) and not paused and not inCutscene then
			if storyMode and song < 3 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics:fadeOutWipe(
					0.7,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		if inCutscene then 
			video:draw()
			return
		end
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(camera.zoom, camera.zoom)

			if song == 1 then
				trayBG:draw()
				arrowbop:draw()
				slutbop:draw()

				enemy:draw()

				weeks:drawRating(0.9)
			end
		love.graphics.pop()
		love.graphics.push()
			love.graphics.scale(camera.zoom, camera.zoom)

			if song == 2 then
				love.graphics.draw(bg, 13, 0, 0, 2.6, 2.6)

				weeks:drawRating(0.9)
			end
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		enemy = nil
		boyfriend = nil
		girlfriend = nil

		if song == 1 then 
			trayBG = nil
			slutbop = nil
			arrowbop = nil
		elseif song == 2 then 
			bg:release()
			bg = nil
		end

		graphics.clearCache()

		weeks:leave()
	end
}
