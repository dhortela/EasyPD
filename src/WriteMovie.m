function [moviefilepath] = WriteMovie(numframes,frameext,outputsmovieframespath, ...
                                      outputsmoviepath,moviename,movieext)
    
    % Extract frame images from file to create movie:
    images = cell(numframes,1);
    maxdims = [0 0];
    for f = 1:numframes
        readfile = append(outputsmovieframespath, ...
                          'frame', num2str(f), frameext);
        images{f} = imread(readfile);
        
        % Update maximum dimension sizes of images:
        if size(images{f},1) > maxdims(1)
            maxdims(1) = size(images{f},1);
        end
        if size(images{f},2) > maxdims(2)
            maxdims(2) = size(images{f},2);
        end
    end
    
    % Resize images to maximum dimension sizes:
    for f = 1:numframes
        if size(images{f},1:2) ~= maxdims
            images{f} = imresize(images{f},maxdims);
        end
    end
    
    % Create video writer:
    moviefilepath = append(outputsmoviepath, moviename, movieext);
    vidWrite = VideoWriter(moviefilepath,'MPEG-4');
    %vidWrite = VideoWriter(moviefilepath);
    vidWrite.Quality = 100;
    vidWrite.FrameRate = 7;
    
    open(vidWrite); % Enable access
    
    % Write frames to video:
    for f = 1:numframes
        
        % Convert images to frames:
        frame = im2frame(images{f});
        % Write video to video writer:
        writeVideo(vidWrite, frame);
    end
    
    close(vidWrite); % Disable access
end