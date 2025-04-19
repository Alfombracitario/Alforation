function add_xp(amount)
{
    with(objPlayer)
    {
        experience += amount;
        if(experience >= xp_need)
        {
            audio_play_sound(sndLevelup,0,0);
            level++;
            experience-=xp_need;
            xp_need = floor(25 * level * power(1.1, level));
        }
        else
        {
            var _pitch = 1+(experience/xp_need);
            audio_play_sound(sndExperience,0,0,1,0,_pitch);
        }
    }
}