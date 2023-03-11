function onSongStart()
	noteTweenY("NoteMove1", 0, -(getPropertyFromGroup('playerStrums', 0, 'y') - 200) * 10, 2, elasticIn)
	noteTweenY("NoteMove2", 1, -(getPropertyFromGroup('playerStrums', 1, 'y') - 200) * 10, 2, elasticIn)
	noteTweenY("NoteMove3", 2, -(getPropertyFromGroup('playerStrums', 2, 'y') - 200) * 10, 2, elasticIn)
	noteTweenY("NoteMove4", 3, -(getPropertyFromGroup('playerStrums', 3, 'y') - 200) * 10, 2, elasticIn)
end