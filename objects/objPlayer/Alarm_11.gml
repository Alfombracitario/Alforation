//Music

var music = irandom(3)

switch(music)
{
	case 0:
		audio_play_sound(musNight,0,0);
	break;
	
	case 1:
		audio_play_sound(musNight2,0,0);
	break;
	
	case 2:
		audio_play_sound(musUndersea,0,0);
		break;
		
	case 3:
		audio_play_sound(musDungeonA,0,0);
	break;
}

var atime = irandom_range(10000,20000);

alarm_set(11,atime);
