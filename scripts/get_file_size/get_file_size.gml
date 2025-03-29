function get_file_size(file_path) {
    var file = file_bin_open(file_path, 0);
    if (file < 0) return 0;
    
    var size = file_bin_size(file);
    file_bin_close(file);
    
    return size;
}
