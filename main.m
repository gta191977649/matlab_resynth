h5_input_path = '/Users/nurupo/Desktop/dev/Music-Outlier-Browser/dataset/data/europe/h5'; 
wav_output_path = '/Users/nurupo/Desktop/dev/Music-Outlier-Browser/dataset/data/europe/wav'; 

if ~exist(wav_output_path, 'dir')
    mkdir(wav_output_path);
end

h5_files = dir(fullfile(h5_input_path, '*.h5'));

% Loop through each .h5 file
for i = 1:length(h5_files)
    % Full path to the current .h5 file
    h5_file_path = fullfile(h5_files(i).folder, h5_files(i).name);
    
    dur = h5.get_duration(); 
    sr = 16000; 
    % fprintf(h5_file_path)
    h5 = HDF5_Song_File_Reader(h5_file_path);
    
    fprintf(h5.get_title()+"\n")

    x = en_resynth(h5, dur, sr,0);
    
    x = x / max(abs(x));
    
    [~, name, ~] = fileparts(h5_files(i).name);
    wav_file_path = fullfile(wav_output_path, [name '.wav']);
    
    audiowrite(wav_file_path, x, sr);
    
    fprintf('Processed and wrote %s\n', wav_file_path);
end

% Print completion message
fprintf('Finished processing all .h5 files.\n');
