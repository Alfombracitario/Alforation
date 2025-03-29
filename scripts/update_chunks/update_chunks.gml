function update_chunks() {
	var rd = global.render_distance;

    if (pcx != last_pcx || pcy != last_pcy) {
        last_pcx = pcx;
        last_pcy = pcy;
        
		ini_open(working_directory+global.worldname+"data.ini");
		with(all)
		{
			event_user(0);
		}
		
        for (var dx = -rd; dx <= rd; dx++) {
            for (var dy = -rd; dy <= rd; dy++) {
                var cx = pcx + dx;
                var cy = pcy + dy;
                
                load_chunk_ini(cx, cy);
				
            }
        }
		ini_close();
    }
	
}
