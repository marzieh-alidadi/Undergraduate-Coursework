clear;
clc;
close all;
%..........................................................................
load('testimage.mat')
image_Orginal = im2double(original);
image_noisy = im2double(noisy);
figure(1) ;
imshow(image_Orginal) ;
figure(2) ;
imshow(image_noisy) ;
[m,n] = size(image_noisy);
%..........................................................................
y11 = medfilt1(image_noisy);
figure(3) ;
imshow(y11) ;
%..........................................................................
y12 = [] ;
for i=1:m
    for j=1:n
        if j==1
            y12(i,j) = median([image_noisy(i,j),image_noisy(i,j+1)]) ;
        elseif j==n
            y12(i,j) = median([image_noisy(i,j-1),image_noisy(i,j)]) ;
        else
            y12(i,j) = median([image_noisy(i,j-1),image_noisy(i,j),image_noisy(i,j+1)]) ;
        end
    end
end
figure(4) ;
imshow(y12) ;
%..........................................................................
counter = -10 ;
i = 1 ;
y1_step = [] ;
y1_impulse = [] ;
n = -10:1:10;
while counter<11
    y1_step(i) = median([heaviside(counter-1),heaviside(counter),heaviside(counter+1)]);
    y1_impulse(i) = median([dirac(counter-1),dirac(counter),dirac(counter+1)]);
    i = i+1;
    counter = counter + 1;
end
figure(5) ;
subplot(211) ;
stem(n,y1_step,'b') ;
xlabel('N') ;
ylabel('Step Response Filter1') ;
subplot(212) ;
stem(n,y1_impulse,'r') ;
xlabel('N') ;
ylabel('impulse Response Filter1') ;
%..........................................................................