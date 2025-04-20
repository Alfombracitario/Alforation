//Music
var music = irandom(7)

switch(music)
{
	case 0:
		audio_play_sound(musNight,0,0,global.musvol);
	break;
	
	case 1:
		audio_play_sound(musNight2,0,0,global.musvol);
	break;
	
	case 2:
		audio_play_sound(musUndersea,0,0,global.musvol);
		break;
		
	case 3:
		audio_play_sound(musDungeonA,0,0,global.musvol);
	break;
	
	case 4:
		audio_play_sound(musRain,0,0,global.musvol);
	break;
	
	case 5:
		audio_play_sound(musTitle,0,0,global.musvol);
	break;
	
	case 6:
		audio_play_sound(musUntitled,0,0,global.musvol);
	break;
    
    case 7:
		audio_play_sound(musInfluenza,0,0,global.musvol);
	break;
}

var atime = irandom_range(13000,15000);

alarm_set(11,atime);
