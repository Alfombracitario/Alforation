if(global.floor > 1)
{
    instance_destroy();
    room_goto(cave);
    global.floor--;
}
else
{
    instance_destroy();
    room_goto(game);
}
