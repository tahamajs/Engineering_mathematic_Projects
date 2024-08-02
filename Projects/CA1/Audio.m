[audio_data, fs] = audioread('ABITW.mp3');


new_fs_double = 2 * fs;



new_fs_half = fs / 2;

audiowrite('audio_double_fs.wav', audio_data, new_fs_double);


audiowrite('audio_half_fs.wav', audio_data, new_fs_half);

[audio_data_half, fs_half] = audioread('audio_half_fs.wav');
sound(audio_data_half, fs_half);
