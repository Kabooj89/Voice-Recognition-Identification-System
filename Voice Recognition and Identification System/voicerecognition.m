%% Project: Voice Recognition and Identification system
% By  Mohammad Kabajah
%
%--------------------------------------------------------------------------

%% Main Function Voice Recognition
function []=voicerecognition()
% For clear screen
clc;
% Ronaldo is a variable used to directly set the minimum distance for
% speech recognition.
ronaldo=10;
% Drogba is a variable used to directly set the maximum number of
% users stored in database
drogba=8;
% st, st1, st2, st3,  will be used for filenames related purposes reducing
% code redundancy.
char st; char st1; char st2; char st3;
disp('Project: Voice Recognition and Identification system');
disp('By  Mohammad Kabajah  ');
disp(' ');
pause(0.5);
disp('LOADING ');
pause(1);
disp('... ');
pause(1);
disp('... ');
pause(1);
disp('... ');
pause(1);
disp('... ');
msgbox('this Project belong to ENG.Mohammad Kabajah so have fun use it ');

% Preallocating array
str = {8}; fstr = {8}; nbtr = {8};
ste = {8}; fste = {8}; nbte = {8};
ctr = {8}; dtr={8};
cte = {8}; dte={8};
data = {drogba,4};
code = {8};

for i = 1:8

    % Read audio data from train folder for performing operations
    st=strcat('train\s',num2str(i),'.wav');
    [s1 fs1 nb1]=wavread(st);
    str{i} = s1; fstr{i} = fs1; nbtr{i} = nb1;

    % Read audio data from test folder for performing operations
    st = strcat('test\s',num2str(i),'.wav');
    [st1 fst1 nbt1] = wavread(st);
    ste{i} = st1; fste{i} = fst1; nbte{i} = nbt1;

    % Compute MFCC of the audio data to be used in Speech Processing for Train
    % Folder
    ctr{i} = mfcc(str{i},fstr{i});

    % Compute MFCC of the audio data to be used in Speech Processing for Test
    % Folder
    cte{i} = mfcc(ste{i},fste{i});

    % Compute Vector Quantization of the audio data to be used in Speech
    % Processing for Train Folder
    dtr{i} = vqlbg(ctr{i},16);

    % Compute Vector Quantization of the audio data to be used in Speech
    % Processing for Test Folder
    dte{i} = vqlbg(cte{i},16);
end

% For making Choice
ch=0;
poss=11;
while ch~=poss

    ch=menu('Speaker Recognition System','1: Human speaker recognition',...
        '2: Technical data of samples',...
        '3: Power Spectrum','4: Power Spectrum with different M and N',...
        '5: Mel-Spaced Filter Bank',...
        '6: Spectrum before and after Mel-Frequency wrapping',...
        '7: 2D plot of acoustic vectors',...
        '8: Plot of VQ codewords','9: Recognition rate of the computer',...
        '10: Test with other speech files','11: Exit');
    disp('                                                                  ');
    %----------------------------------------------------------------------

%% 1: Human speaker recognition
    

    if ch==1
        disp('>  1: Human speaker recognition');
        disp('Play each sound file in the TRAIN folder.');
        disp('Can you distinguish the voices of those eight speakers?');
        disp('Now play each sound in the TEST folder in a random order without looking at the file name ');
        disp('and try to identify the speaker using your knowledge of their voices that you have just heard,');
        disp('from the TRAIN folder. This is exactly what the computer will do in our system.');
        disp('                                                                                                  ');
        disp('                                                                                                   ');
        disp('All of us seem to be unable to recognise random people just by listening to their voice. ');
        disp('We also realize that we do not identify speakers by the frequencies with which they use to talk,  ');
        disp('but rather by other characteristics, like accent, speed, etc.');
        pause(1);

        ch2=0;
        while ch2~=4
            ch2=menu('Select Folder','Train','Test','User','Exit');

            if ch2==1

                ch3=0;
                while ch3~=9
                    ch3=menu('Train :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        p=audioplayer(str{ch3},fstr{ch3},nbtr{ch3});
                        play(p);
                    end
                end
            end

            if ch2==2

                ch3=0;
                while ch3~=9
                    ch3=menu('Test :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        p=audioplayer(ste{ch3},fste{ch3},nbte{ch3});
                        play(p);
                    end
                end
                close all;
            end

            if ch2==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a = str2double(an);

                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs nb]=wavread(st);
                                    p=audioplayer(s,fs,nb);
                                    play(p);

                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                        close all;
                    end

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%% 2: Technical data of samples
   

    if ch==2
        disp('> 2: Technical data of samples');

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss2=9;
                ch2=0;
                while ch2~=poss2
                    ch2=menu('Technical data of samples for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch2~=9
                        t = 0:1/fstr{ch2}:(length(str{ch2}) - 1)/fstr{ch2};
                        plot(t, str{ch2}), axis([0, (length(str{ch2}) - 1)/fstr{ch2} -0.4 0.5]);
                        st=sprintf('Plot of signal s%d.wav',ch2);
                        title(st);
                        xlabel('Time [s]');
                        ylabel('Amplitude (normalized)')
                    end
                end
                close all
            end

            if ch23==2
                poss2=9;
                ch2=0;
                while ch2~=poss2
                    ch2=menu('Technical data of samples for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch2~=9
                        t = 0:1/fste{ch2}:(length(ste{ch2}) - 1)/fste{ch2};
                        plot(t, ste{ch2}), axis([0, (length(ste{ch2}) - 1)/fste{ch2} -0.4 0.5]);
                        st=sprintf('Plot of signal s%d.wav',ch2);
                        title(st);
                        xlabel('Time [s]');
                        ylabel('Amplitude (normalized)')
                    end
                end
                close all
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a = str2double(an);

                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    t = 0:1/fs:(length(s) - 1)/fs;
                                    plot(t, s), axis([0, (length(s) - 1)/fs -0.4 0.5]);
                                    st=sprintf('Plot of signal %s',st);
                                    title(st);
                                    xlabel('Time [s]');
                                    ylabel('Amplitude (normalized)')

                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end

                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%% 3: linear and logarithmic power spectrum plot
  

    if ch==3
        M = 100;
        N = 256;
        disp('> 3: Power Spectrum Plot');
        disp('                                                      ');
        disp('>Linear and Logarithmic spectrum plot');

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Linear and Logarithmic Power Spectrum Plot for : ','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        % 3 (linear)
                        frames = blockFrames(str{ch3}, fstr{ch3}, M, N);
                        t = N / 2;
                        tm = length(str{ch3}) / fstr{ch3};
                        subplot(121);
                        imagesc([0 tm], [0 fstr{ch3}/2], abs(frames(1:t, :)).^2), axis xy;
                        title('Power Spectrum (M = 100, N = 256)');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        % 3 (logarithmic)
                        subplot(122);
                        imagesc([0 tm], [0 fstr{ch3}/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                        title('Logarithmic Power Spectrum (M = 100, N = 256)');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        % D=get(gcf,'Position');
                        % set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*2 D(4)*1.3]))
                    end
                end
                close all
            end

            if ch23==2
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Linear and Logarithmic Power Spectrum Plot for : ','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        % 3 (linear)
                        frames = blockFrames(ste{ch3}, fste{ch3}, M, N);
                        t = N / 2;
                        tm = length(ste{ch3}) / fste{ch3};
                        subplot(121);
                        imagesc([0 tm], [0 fste{ch3}/2], abs(frames(1:t, :)).^2), axis xy;
                        title('Power Spectrum (M = 100, N = 256)');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        % 3 (logarithmic)
                        subplot(122);
                        imagesc([0 tm], [0 fste{ch3}/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                        title('Logarithmic Power Spectrum (M = 100, N = 256)');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        % D=get(gcf,'Position');
                        % set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*2 D(4)*1.3]))
                    end
                end
                close all;
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a = str2double(an);

                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                st=strcat('u',num2str(an));
                                [s fs]=wavread(st);
                                frames = blockFrames(s, fs, M, N);
                                t = N / 2;
                                tm = length(s) / fs;
                                subplot(121);
                                imagesc([0 tm], [0 fs/2], abs(frames(1:t, :)).^2), axis xy;
                                title('Power Spectrum (M = 100, N = 256)');
                                xlabel('Time [s]');
                                ylabel('Frequency [Hz]');
                                colorbar;
                                %Question 3 (logarithmic)
                                subplot(122);
                                imagesc([0 tm], [0 fs/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                                title('Logarithmic Power Spectrum (M = 100, N = 256)');
                                xlabel('Time [s]');
                                ylabel('Frequency [Hz]');
                                colorbar;

                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%%  4: Plots for different values for N
   

    if ch==4
        disp('>  4: Plots for different values for M and N');
        lN = [128 256 512];

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Plots for different values of M and N for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        u=220;
                        for i = 1:length(lN)
                            N = lN(i);
                            M = round(N / 3);
                            frames = blockFrames(str{ch3}, fstr{ch3}, M, N);
                            t = N / 2;
                            tm = length(str{ch3}) / fstr{ch3};
                            temp = size(frames);
                            nbframes = temp(2);
                            u=u+1;
                            subplot(u)
                            imagesc([0 tm], [0 fstr{ch3}/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                            title(sprintf('Power Spectrum (M = %i, N = %i, frames = %i)', M, N, nbframes));
                            xlabel('Time [s]');
                            ylabel('Frequency [Hz]');
                            colorbar
                        end
                        % D=get(gcf,'Position');
                        % set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*1.5 D(4)*1.5]))
                    end
                end
                close all
            end

            if ch23==2
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Plots for different values of M and N for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        u=220;
                        for i = 1:length(lN)
                            N = lN(i);
                            M = round(N / 3);
                            frames = blockFrames(ste{ch3}, fste{ch3}, M, N);
                            t = N / 2;
                            tm = length(ste{ch3}) / fste{ch3};
                            temp = size(frames);
                            nbframes = temp(2);
                            u=u+1;
                            subplot(u)
                            imagesc([0 tm], [0 fste{ch3}/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                            title(sprintf('Power Spectrum (M = %i, N = %i, frames = %i)', M, N, nbframes));
                            xlabel('Time [s]');
                            ylabel('Frequency [Hz]');
                            colorbar
                        end
                        % D=get(gcf,'Position');
                        % set(gcf,'Position',round([D(1)*.5 D(2)*.5 D(3)*1.5 D(4)*1.5]))
                    end
                end
                close all;
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);                                    
                            a = str2double(an);

                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    u=220;
                                    for i = 1:length(lN)
                                        N = lN(i);
                                        M = round(N / 3);
                                        frames = blockFrames(s, fs, M, N);
                                        t = N / 2;
                                        tm = length(s) / fs;
                                        temp = size(frames);
                                        nbframes = temp(2);
                                        u=u+1;
                                        subplot(u)
                                        imagesc([0 tm], [0 fs/2], 20 * log10(abs(frames(1:t, :)).^2)), axis xy;
                                        title(sprintf('Power Spectrum (M = %i, N = %i, frames = %i)', M, N, nbframes));
                                        xlabel('Time [s]');
                                        ylabel('Frequency [Hz]');
                                        colorbar
                                    end
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                     end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end
        end
    end
    %----------------------------------------------------------------------

%%  5: Mel Space
   

    if ch==5
        disp('> 5: Mel Space');
        disp('                                                                 ');
        disp('Mel Space is function of sampling rate and since all signals ');
        disp('are recorded at same sampling rate so they have same Mel Space.');

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Mel Space for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        plot(linspace(0, (fstr{ch3}/2), 129), (melfb(20, 256, fstr{ch3})));
                        title('Mel-Spaced Filterbank');
                        xlabel('Frequency [Hz]');
                    end
                end
                close all
            end


            if ch23==2
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Mel Space for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        plot(linspace(0, (fste{ch3}/2), 129), (melfb(20, 256, fste{ch3})));
                        title('Mel-Spaced Filterbank');
                        xlabel('Frequency [Hz]');
                    end
                end
                close all;
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    plot(linspace(0, (fs/2), 129), (melfb(20, 256, fs)));
                                    title('Mel-Spaced Filterbank');
                                    xlabel('Frequency [Hz]');
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%%  6: Modified spectrum
   

    if ch==6
        disp('> 6: Modified spectrum');
        disp('                                                              ');
        disp('Spectrum before and after Mel-Frequency wrapping');
        M = 100;
        N = 256;
        n2 = 1 + floor(N / 2);

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Mel Space for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        frames = blockFrames(str{ch3}, fstr{ch3}, M, N);
                        m = melfb(20, N, fstr{ch3});
                        z = m * abs(frames(1:n2, :)).^2;
                        tm = length(str{ch3}) / fstr{ch3};
                        subplot(121)
                        imagesc([0 tm], [0 fstr{ch3}/2], abs(frames(1:n2, :)).^2), axis xy;
                        title('Power Spectrum unmodified');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        subplot(122)
                        imagesc([0 tm], [0 20], z), axis xy;
                        title('Power Spectrum modified through Mel Cepstrum filter');
                        xlabel('Time [s]');
                        ylabel('Number of Filter in Filter Bank');
                        % colorbar;D=get(gcf,'Position');
                        % set(gcf,'Position',[0 D(2) D(3)/2 D(4)])
                    end
                end
                close all
            end


            if ch23==2
                poss3=9;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('Mel Space for :','Signal 1','Signal 2','Signal 3',...
                        'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                    if ch3~=9
                        frames = blockFrames(str{ch3}, fstr{ch3}, M, N);
                        m = melfb(20, N, fstr{ch3});
                        z = m * abs(frames(1:n2, :)).^2;
                        tm = length(str{ch3}) / fstr{ch3};
                        subplot(121)
                        imagesc([0 tm], [0 fstr{ch3}/2], abs(frames(1:n2, :)).^2), axis xy;
                        title('Power Spectrum unmodified');
                        xlabel('Time [s]');
                        ylabel('Frequency [Hz]');
                        colorbar;
                        subplot(122)
                        imagesc([0 tm], [0 20], z), axis xy;
                        title('Power Spectrum modified through Mel Cepstrum filter');
                        xlabel('Time [s]');
                        ylabel('Number of Filter in Filter Bank');
                        % colorbar;D=get(gcf,'Position');
                        % set(gcf,'Position',[0 D(2) D(3)/2 D(4)])
                    end
                end
                close all;
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);                         
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    frames = blockFrames(s, fs, M, N);
                                    m = melfb(20, N, fs);
                                    z = m * abs(frames(1:n2, :)).^2;
                                    tm = length(s) / fs;
                                    subplot(121)
                                    imagesc([0 tm], [0 fs/2], abs(frames(1:n2, :)).^2), axis xy;
                                    title('Power Spectrum unmodified');
                                    xlabel('Time [s]');
                                    ylabel('Frequency [Hz]');
                                    colorbar;
                                    subplot(122)
                                    imagesc([0 tm], [0 20], z), axis xy;
                                    title('Power Spectrum modified through Mel Cepstrum filter');
                                    xlabel('Time [s]');
                                    ylabel('Number of Filter in Filter Bank');
                                    colorbar;
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%%  7: 2D plot of accustic vectors
   

    if ch==7
        disp('>  7: 2D plot of accustic vectors');

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=3;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('2D plot of accustic vectors representation : ','1. One Signal',...
                        '2. Two Signal','3. Exit');

                    if ch3==1
                        ch31=0;
                        while ch31~=9
                            ch31=menu('2D plot of accustic vectors for :','Signal 1','Signal 2','Signal 3',...
                                'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                            if ch31~=9
                                plot(ctr{ch31}(5, :), ctr{ch31}(6, :), 'or');
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Signal %d ',ch31);
                                legend(st);
                                title('2D plot of accoustic vectors');
                            end
                        end
                        close all;
                    end

                    if ch3==2
                        ch32=0;
                        while ch32~=8
                            ch32=menu('2D plot of accustic vectors for :','Signal 1 & Signal 2',...
                                'Signal 2 & Signal 3','Signal 3 & Signal 4','Signal 4 & Signal 5',...
                                'Signal 5 & Signal 6','Signal 6 & Signal 7','Signal 7 & Signal 8','Exit');
                            if ch32~=8
                                plot(ctr{ch32}(5, :), ctr{ch32}(6, :), 'or');
                                hold on;
                                plot(ctr{ch32+1}(5, :), ctr{ch32+1}(6, :), 'xb');
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Signal %d,',ch32);
                                st1=sprintf('Signal %d', (ch32+1) );
                                legend(st,st1);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                    end
                    close all
                end
            end

            if ch23==2
                poss3=3;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('2D plot of accustic vectors representation : ','1. One Signal',...
                        '2. Two Signal','3. Exit');

                    if ch3==1
                        ch31=0;
                        while ch31~=9
                            ch31=menu('2D plot of accustic vectors for :','Signal 1','Signal 2','Signal 3',...
                                'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');
                            if ch31~=9
                                plot(cte{ch31}(5, :), cte{ch31}(6, :), 'or');
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Signal %d ',ch31);
                                legend(st);
                                title('2D plot of accoustic vectors');
                            end
                        end
                        close all;
                    end

                    if ch3==2
                        ch32=0;
                        while ch32~=8
                            ch32=menu('2D plot of accustic vectors for :','Signal 1 & Signal 2',...
                                'Signal 2 & Signal 3','Signal 3 & Signal 4','Signal 4 & Signal 5',...
                                'Signal 5 & Signal 6','Signal 6 & Signal 7','Signal 7 & Signal 8','Exit');

                            if ch32~=8
                                plot(cte{ch32}(5, :), cte{ch32}(6, :), 'or');
                                hold on;
                                plot(cte{ch32+1}(5, :), cte{ch32+1}(6, :), 'xb');
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Signal %d,',ch32);
                                st1=sprintf('Signal %d', (ch32+1) );
                                legend(st,st1);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                    end
                    close all
                end
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    c = mfcc(s, fs);
                                    plot(c(5, :), c(6, :), 'or');
                                    xlabel('5th Dimension');
                                    ylabel('6th Dimension');
                                    st1=sprintf('Signal %s.wav',st);
                                    legend(st1);
                                    title('2D plot of accoustic vectors');
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%%  8: Plot of the 2D trained VQ codewords
   

    if ch==8
        disp('>  8: Plot of the 2D trained VQ codewords');

        ch23=0;
        while ch23~=4
            ch23=menu('Select Folder','Train','Test','User','Exit');

            if ch23==1
                poss3=3;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('2D plot of accustic vectors representation : ','1. One Signal',...
                        '2. Two Signal','3. Exit');

                    if ch3==1
                        ch31=0;
                        while ch31~=9
                            ch31=menu('2D plot of accustic vectors for :','Signal 1','Signal 2','Signal 3',...
                                'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');

                            if ch31~=9
                                plot(ctr{ch31}(5, :), ctr{ch31}(6, :), 'xr')
                                hold on
                                plot(dtr{ch31}(5, :), dtr{ch31}(6, :), 'vk')
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Speaker %d',ch31);
                                st1=sprintf('Codebook %d', (ch31) );
                                legend(st,st1);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                        close all
                    end

                    if ch3==2
                        ch32=0;
                        while ch32~=8
                            ch32=menu('2D plot of accustic vectors for :','Signal 1 & Signal 2',...
                                'Signal 2 & Signal 3','Signal 3 & Signal 4','Signal 4 & Signal 5',...
                                'Signal 5 & Signal 6','Signal 6 & Signal 7','Signal 7 & Signal 8','Exit');

                            if ch32~=8
                                plot(ctr{ch32}(5, :), ctr{ch32}(6, :), 'xr')
                                hold on
                                plot(dtr{ch32}(5, :), dtr{ch32}(6, :), 'vk')
                                plot(ctr{ch32+1}(5, :), ctr{ch32+1}(6, :), 'xb')
                                plot(dtr{ch32+1}(5, :), dtr{ch32+1}(6, :), '+k')
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Speaker %d',ch32);
                                st1=sprintf('Codebook %d',ch32 );
                                st2=sprintf('Speaker %d',(ch32+1) );
                                st3=sprintf('Codebook %d', (ch32+1) );
                                legend(st,st1,st2,st3);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                    end
                    close all
                end
            end

            if ch23==2
                poss3=3;
                ch3=0;
                while ch3~=poss3
                    ch3=menu('2D plot of accustic vectors representation : ','1. One Signal',...
                        '2. Two Signal','3. Exit');

                    if ch3==1
                        ch31=0;
                        while ch31~=9
                            ch31=menu('2D plot of accustic vectors for :','Signal 1','Signal 2','Signal 3',...
                                'Signal 4','Signal 5','Signal 6','Signal 7','Signal 8','Exit');

                            if ch31~=9
                                plot(cte{ch31}(5, :), cte{ch31}(6, :), 'xr')
                                hold on
                                plot(dte{ch31}(5, :), dte{ch31}(6, :), 'vk')
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Speaker %d',ch31);
                                st1=sprintf('Codebook %d', (ch31) );
                                legend(st,st1);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                        close all
                    end

                    if ch3==2
                        ch32=0;
                        while ch32~=8
                            ch32=menu('2D plot of accustic vectors for :','Signal 1 & Signal 2',...
                                'Signal 2 & Signal 3','Signal 3 & Signal 4','Signal 4 & Signal 5',...
                                'Signal 5 & Signal 6','Signal 6 & Signal 7','Signal 7 & Signal 8','Exit');

                            if ch32~=8
                                plot(cte{ch32}(5, :), cte{ch32}(6, :), 'xr')
                                hold on
                                plot(dte{ch32}(5, :), dte{ch32}(6, :), 'vk')
                                plot(cte{ch32+1}(5, :), cte{ch32+1}(6, :), 'xb')
                                plot(dte{ch32+1}(5, :), dte{ch32+1}(6, :), '+k')
                                xlabel('5th Dimension');
                                ylabel('6th Dimension');
                                st=sprintf('Speaker %d',ch32);
                                st1=sprintf('Codebook %d',ch32 );
                                st2=sprintf('Speaker %d', (ch32+1) );
                                st3=sprintf('Codebook %d', (ch32+1) );
                                legend(st,st1,st2,st3);
                                title('2D plot of accoustic vectors');
                                hold off
                            end
                        end
                    end
                    close all
                end
            end

            if ch23==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs]=wavread(st);
                                    c = mfcc(s, fs);
                                    d = vqlbg(c, 16);
                                    plot(c(5, :), c(6, :), 'xr');
                                    hold on
                                    plot(d(5, :), d(6, :), 'vk');
                                    xlabel('5th Dimension');
                                    ylabel('6th Dimension');
                                    st1=sprintf('Speaker %s',st);
                                    st2=sprintf('Codebook %s',st);
                                    legend(st1,st2);
                                    title('2D plot of accoustic vectors');
                                    hold off
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end
                    close all;

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end

        end
    end
    %----------------------------------------------------------------------

%%  9: Recognition rate of the computer
   

    if ch==9
        disp('> 9: Recognition rate of the computer')
        %----------------------------------------------------------------------

%% 9.1 Loading from Test Folder for Comparison
% All 8 samples data values are loaded in file sounddatabase1.dat.

        for sound_number = 1: 8
            if size(ste{sound_number},2)==2
                ste{sound_number}=ste{sound_number}(:,1);
            end
            ste{sound_number} = double( ste{sound_number} );
            data{sound_number,1} = ste{sound_number};
            data{sound_number,2} = sound_number;
            st = sprintf('s%d.wav',sound_number);
            data{sound_number,3} = st;
            data{sound_number,4} = 'Test';
            fs=fste{sound_number}; 
            nb=nbte{sound_number}; 
            if sound_number == 1;
                save('sound_database1.dat','data','sound_number','fs','nb');
            else
                save('sound_database1.dat','data','sound_number','fs','nb','-append');
            end
        end

        disp(' ');
        disp('Sounds From TEST added to database for comparison');
        disp(' ');
        %----------------------------------------------------------------------

%% 9.2 Comparing one by one data from TRAIN FOLDER


        disp('Comparing one by one data from TRAIN FOLDER');
        disp(' ');
        load('sound_database1.dat','-mat');
        k =16;
        for ii=1:sound_number
            % Compute MFCC cofficients for each sound present in database
            v = mfcc(data{ii,1}, fstr{ii});
            % Train VQ codebook
            code{ii} = vqlbg(v, k);
        end

        flag1 = 0;
        for classe = 1:8
            st = sprintf('Train\\S%d.wav to be compared',classe);
            disp(st);
            pause(0.5);
            if size(str{classe},2)==2
                str{classe}=str{classe}(:,1);
            end
            str{classe} = double(str{classe});
            %----- code for speaker recognition -------
            disp('MFCC cofficients computation and VQ codebook training in progress...');
            % Number of centroids required
            disp(' ');
            % Compute MFCC coefficients for input sound
            v = mfcc(str{classe},fstr{classe});
            % Current distance and sound ID initialization
            distmin = Inf;
            k1 = 0;
            for ii=1:sound_number
                d = disteu(v, code{ii});
                dist = sum(min(d,[],2)) / size(d,1);
                if dist < distmin
                    distmin = dist;
                    k1 = ii;
                end
            end
            min_index = k1;
            speech_id = data{min_index,2};
            %-----------------------------------------
            disp('Completed.');
            disp('Matching sound:');
            disp(' ');
            message=strcat('File:',data{min_index,3});
            disp(message);
            message=strcat('Location:',data{min_index,4});
            disp(message);
            message = strcat('Recognized speaker ID: ',num2str(speech_id));
            disp(message);
            disp(' ');
        if classe == speech_id
            flag1 = flag1 + 1;
        end
        end
        disp('                                                             ');
        pause(0.5)
        st1 = strcat('This prototype is', num2str(100*flag1/classe),'% efficient in recognising these 8 different stored sounds in TEST and TRAIN folders.');
        msgbox(st1,'Success','help'); 
end
    %----------------------------------------------------------------------

%% 9.3 Note: Test with other speech files
    % You can also test the system with your own speech files. Use the Windows
    % program Sound Recorder to record your own voice and your friends' voices
    % Each new speaker needs to pro vide one speech file for training and one
    % for testing. Can the system recognize your voice? Enjoy.
    %----------------------------------------------------------------------

%% 10: Voice Recognition by letting user enter into database and then compare
  
    


    if ch==10
        disp('> 10: Test with other speech files')
        pause(2);

        chos=0;
        possibility=5;
        while chos~=possibility,
            chos=menu('Speaker Recognition System','Add a new sound from microphone',...
                'Speaker recognition from microphone',...
                'Database Info','Delete database','Exit');

            %----------------------------------------------------------------------

%% 10.1 Add a new sound from microphone

            if chos==1

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');                   
                    classe = input('Insert a class number (sound ID) that will be used for recognition:');
                    if isempty(classe)
                        classe = sound_number+1;
                        disp( num2str(classe) );
                    end
                    message=('The following parameters will be used during recording:');
                    disp(message);
                    message=strcat('Sampling frequency',num2str(samplingfrequency));
                    disp(message);
                    message=strcat('Bits per sample',num2str(samplingbits));
                    disp(message);
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);
                    
                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y1 = getaudiodata(micrecorder);
                    y = getaudiodata(micrecorder, 'uint8');

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    sound_number = sound_number+1;
                    data{sound_number,1} = y;
                    data{sound_number,2} = classe;
                    data{sound_number,3} = 'Microphone';
                    data{sound_number,4} = 'Microphone';
                    st=strcat('u',num2str(sound_number));
                    wavwrite(y1,samplingfrequency,samplingbits,st)
                    save('sound_database.dat','data','sound_number','-append');
                    msgbox('Sound added to database','Database result','help');
                    disp('Sound added to database');

                else
                    classe = input('Insert a class number (sound ID) that will be used for recognition:');
                    if isempty(classe)
                        classe = 1;
                        disp( num2str(classe) );
                    end
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    samplingfrequency = input('Insert the sampling frequency (22050 recommended):');
                    if isempty(samplingfrequency )
                        samplingfrequency = 22050;
                        disp( num2str(samplingfrequency) );
                    end
                    samplingbits = input('Insert the number of bits per sample (8 recommended):');
                    if isempty(samplingbits )
                        samplingbits = 8;
                        disp( num2str(samplingbits) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);

                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y1 = getaudiodata(micrecorder);
                    y = getaudiodata(micrecorder, 'uint8');

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    sound_number = 1;
                    data{sound_number,1} = y;
                    data{sound_number,2} = classe;
                    data{sound_number,3} = 'Microphone';
                    data{sound_number,4} = 'Microphone';
                    st=strcat('u',num2str(sound_number));
                    wavwrite(y1,samplingfrequency,samplingbits,st)
                    save('sound_database.dat','data','sound_number','samplingfrequency','samplingbits');
                    msgbox('Sound added to database','Database result','help');
                    disp('Sound added to database');
                end
            end

            %----------------------------------------------------------------------

%% 10.2 Voice Recognition from microphone

            if chos==2

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');
                    Fs = samplingfrequency;
                    durata = input('Insert the duration of the recording (in seconds):');
                    if isempty(durata)
                        durata = 3;
                        disp( num2str(durata) );
                    end
                    micrecorder = audiorecorder(samplingfrequency,samplingbits,1);
                    disp('Now, speak into microphone...');
                    record(micrecorder,durata);

                    while (isrecording(micrecorder)==1)
                        disp('Recording...');
                        pause(0.5);
                    end
                    disp('Recording stopped.');
                    y = getaudiodata(micrecorder);
                    st='v';
                    wavwrite(y,samplingfrequency,samplingbits,st);
                    y = getaudiodata(micrecorder, 'uint8');
                    % if the input sound is not mono

                    if size(y,2)==2
                        y=y(:,1);
                    end
                    y = double(y);
                    %----- code for speaker recognition -------
                    disp('MFCC cofficients computation and VQ codebook training in progress...');
                    disp(' ');
                    % Number of centroids required
                    k =16;

                    for ii=1:sound_number
                        % Compute MFCC cofficients for each sound present in database
                        v = mfcc(data{ii,1}, Fs);
                        % Train VQ codebook
                        code{ii} = vqlbg(v, k);
                        disp('...');
                    end
                    disp('Completed.');
                    % Compute MFCC coefficients for input sound
                    v = mfcc(y,Fs);
                    % Current distance and sound ID initialization
                    distmin = Inf;
                    k1 = 0;

                    for ii=1:sound_number
                        d = disteu(v, code{ii});
                        dist = sum(min(d,[],2)) / size(d,1);
                        message=strcat('For User #',num2str(ii),' Dist : ',num2str(dist));
                        disp(message);
             
                        if dist < distmin
                            distmin = dist;
                            k1 = ii;
                        end
                    end

                    if distmin < ronaldo
                        min_index = k1;
                        speech_id = data{min_index,2};
                        %-----------------------------------------
                        disp('Matching sound:');
                        message=strcat('File:',data{min_index,3});
                        disp(message);  
                        message=strcat('Location:',data{min_index,4});
                        disp(message);
                        message = strcat('Recognized speaker ID: ',num2str(speech_id));
                        disp(message);
                        msgbox(message,'Matching result','help');

                        ch3=0;
                        while ch3~=3
                            ch3=menu('Matched result verification:','Recognized Sound','Recorded sound','Exit');

                            if ch3==1
                                st=strcat('u',num2str(speech_id));
                                [s fs nb]=wavread(st);
                                p=audioplayer(s,fs,nb);
                                play(p);
                            end

                            if ch3==2
                                [s fs nb]=wavread('v');
                                p=audioplayer(s,fs,nb);
                                play(p);
                            end
                        end

                    else
                        warndlg('Wrong User . No matching Result.',' Warning ')
                    end
                else
                    warndlg('Database is empty. No matching is possible.',' Warning ')
                end
            end
            %----------------------------------------------------------------------

%% 10.3 Database Info

            if chos==3

                if (exist('sound_database.dat','file')==2)
                    load('sound_database.dat','-mat');
                    message=strcat('Database has #',num2str(sound_number),'words:');
                    disp(message);
                    disp(' ');

                    for ii=1:sound_number
                        message=strcat('Location:',data{ii,3});
                        disp(message);
                        message=strcat('File:',data{ii,4});
                        disp(message);
                        message=strcat('Sound ID:',num2str(data{ii,2}));
                        disp(message);
                        disp('-');
                    end

                    ch32=0;
                    while ch32 ~=2
                        ch32=menu('Database Information','Database','Exit');

                        if ch32==1
                            st=strcat('Sound Database has : #',num2str(sound_number),'words. Enter a database number : #');
                            prompt = {st};
                            dlg_title = 'Database Information';
                            num_lines = 1;
                            def = {'1'};
                            options.Resize='on';
                            options.WindowStyle='normal';
                            options.Interpreter='tex';
                            an = inputdlg(prompt,dlg_title,num_lines,def);
                            an=cell2mat(an);
                            a=str2double(an);
                            
                            if (isempty(an))

                            else

                                if (a <= sound_number)
                                    st=strcat('u',num2str(an));
                                    [s fs nb]=wavread(st);
                                    p=audioplayer(s,fs,nb);
                                    play(p);
                                else
                                    warndlg('Invalid Word ','Warning');
                                end
                            end
                        end
                    end

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end
            %----------------------------------------------------------------------

%% 10.4 Delete database

            if chos==4
                %clc;
                close all;

                if (exist('sound_database.dat','file')==2)
                    button = questdlg('Do you really want to remove the Database?');

                    if strcmp(button,'Yes')
                        load('sound_database.dat','-mat');

                        for ii=1:sound_number
                            st=strcat('u',num2str(ii),'.wav');
                            delete(st);
                        end

                        if (exist('v.wav','file')==2)
                            delete('v.wav');
                        end

                        delete('sound_database.dat');
                        msgbox('Database was succesfully removed from the current directory.','Database removed','help');
                    end

                else
                    warndlg('Database is empty.',' Warning ')
                end
            end
        end
    end

end
close all;
end
%--------------------------------------------------------------------------

%% blockFrames Function
% blockFrames: Puts the signal into frames
%
% Inputs: s contains the signal to analize
% fs is the sampling rate of the signal
% m is the distance between the beginnings of two frames
% n is the number of samples per frame
%
% Output: M3 is a matrix containing all the frames

function M3 = blockFrames(s, fs, m, n)
l = length(s);
nbFrame = floor((l - n) / m) + 1; %nearest to close integer if complex deal seperatly 
for i = 1:n
    for j = 1:nbFrame
        M(i, j) = s(((j - 1) * m) + i); %#ok<AGROW>%matrix 256*n
    end
end
h = hamming(n);% make hamming to signal to keep the main feature 
M2 = diag(h) * M;%4444444444444444444444
for i = 1:nbFrame
    M3(:, i) = fft(M2(:, i)); %#ok<AGROW>%fft matrix 
end
end
%--------------------------------------------------------------------------

%% MFCC Function
% MFCC
%
% Inputs: s contains the signal to analize
% fs is the sampling rate of the signal
%
% Output: r contains the transformed signal

function r = mfcc(s, fs)
m = 100;
n = 256;
frame=blockFrames(s, fs, m, n);
m = melfb(20, n, fs);%power spectrum 
n2 = 1 + floor(n / 2);
z = m * abs(frame(1:n2, :)).^2;%we take absolute since the spectrum is symmetric  tkbeeeeer el power 
r = dct(log(z));
end
%--------------------------------------------------------------------------

%% VQLBG Vector quantization using the Linde-Buzo-Gray algorithm
% VQLBG Vector quantization using the Linde-Buzo-Gray algorithm
%
% Inputs: d contains training data vectors (one per column)
% k is number of centroids required
%
% Output: r contains the result VQ codebook (k columns, one for each  centroids)

function r = vqlbg(d,k)
e = .01;
r = mean(d, 2);
dpr = 10000;
for i = 1:log2(k) % we make four region at start not just two
    r = [r*(1+e), r*(1-e)]; %four region by add 0.01 and subtract 
    while (1 == 1)
        z = disteu(d, r);%matrix of distances 20*n
        [m,ind] = min(z, [], 2);
        t = 0;
        for j = 1:2^i
            r(:, j) = mean(d(:, find(ind == j)), 2); %#ok<FNDSB>(get the mean to each colomn that represent the M to make clustering 
            x = disteu(d(:, find(ind == j)), r(:, j)); %#ok<FNDSB>(el masafeh beeen el colomn fee el matrix d wel colomn elle b3aber 3n el M)
            for q = 1:length(x)  
                t = t + x(q);
            end
        end
        if (((dpr - t)/t) < e)%treqet t2seeeem el region fee hada el algorithm
            break;
        else
            dpr = t;
        end
    end
end
end
%--------------------------------------------------------------------------
