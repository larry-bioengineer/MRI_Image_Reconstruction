% Larry To
% Created: 10/5/2017
% BIOEN 599 L Assignment 2
% Purpose: import a MRI data set and plot the transverse, saggital and
% coronal planes. Then, plot the frequency distribution of the image
% values. 
%% Import Data
fileName = 'MRI_cubic_uint8_be.raw';
fid = fopen(fileName, 'r');
if fid == -1
  error('Cannot open file: %s', FileName);
end
data = fread(fid, 158*199*213, 'uint8', 'b');
fclose(fid);
data = reshape(data, [158, 199, 213]);

%% Part 1
% Plotting transverse, saggital, and coronal
figure()
subplot(1,3,1)
imagesc(rot90(data(:,:,round(213/2)),-1))
colormap(gray)
title('Transverse Plane','fontsize',15)

% figure()
subplot(1,3,2)
imagesc(rot90(squeeze(data(round(153/2),:,:)),-1))
colormap(gray)
title('Saggital Plane','fontsize',15)

% figure()
subplot(1,3,3)
imagesc(rot90(squeeze(data(:,round(199/2),:)),-1))
colormap(gray)
title('Coronal Plane','fontsize',15)

%% Part 2
% Plotting all slices in each plane 
mapVec = (linspace(0,1,256))';
map = [mapVec mapVec mapVec];
% Transverse
dataTran = reshape(data,158,199,1,213);
figure()        
montage(rot90(dataTran,-1),map)
title('Transverse Plane','fontsize',15)

% Saggital
dataSagg = reshape(permute(data,[2 3 1]),199,213,1,158);
figure()
montage(rot90(dataSagg,-1),map)
title('Saggital Plane','fontsize',15)

% Coronal
dataCor = reshape(permute(data,[1 3 2]),158,213,1,199);
figure()
montage(rot90(dataCor,-1),map)
title('Coronal Plane','fontsize',15)

%% Part 3
% Calculate field of view, number of voxels, range of values in the image
% volume.

%% Part 4
% Plot the frequency distribution of the image values 
% Selecting the middle slides at the transverse plane. 
figure()
subplot(1,2,1)
imagesc(rot90(data(:,:,round(213/2)),-1))
colormap(gray)
title(['Original image (Slice' ' ' num2str(round(213/2)) 'th ' ...
    'at Transverse Plane)'])

subplot(1,2,2)
midSlice = round(213/2);
imhist(data(:,:,midSlice),map)
title('Frequency Distribution')
ylabel('Count (n)')




    