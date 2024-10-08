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
M21 = 5 ;
y21 = [];
s21 = 0;
k = 0;
for i=1:m
    for j=1:n
        while k<(M21+1)
          if j-k>0
              s21 = s21 + image_noisy(i,j-k);
          end
          k = k+1 ;
        end
      y21(i,j) = (1/(M21+1))*s21;
      s21 = 0;
      k = 0;
    end
end
figure(3) ;
imshow(y21) ;
%..........................................................................
M22 = 15 ;
y22 = [];
s22 = 0;
k = 0;
for i=1:m
    for j=1:n
        while k<(M22+1)
          if j-k>0
              s22 = s22 + image_noisy(i,j-k);
          end
          k = k+1 ;
        end
      y22(i,j) = (1/(M22+1))*s22;
      s22 = 0;
      k = 0;
    end
end
figure(4) ;
imshow(y22) ;
%..........................................................................
M23 = 30 ;
y23 = [];
s23 = 0;
k = 0;
for i=1:m
    for j=1:n
        while k<(M23+1)
          if j-k>0
              s23 = s23 + image_noisy(i,j-k);
          end
          k = k+1 ;
        end
      y23(i,j) = (1/(M23+1))*s23;
      s23 = 0;
      k = 0;
    end
end
figure(5) ;
imshow(y23) ;
%..........................................................................
%if M1<=0 and M2=>0
counter = -15 ;
i = 1 ;
y21_step = [] ;
y21_impulse = [] ;
n = -15:1:15;
M11 = -1 ;
M21 = 10 ;
s21_step = 0 ;
s21_impulse = 0;
while counter<16
    for k=(-M11):M21
        s21_step = s21_step + heaviside(counter-k);
        s21_impulse = s21_impulse + dirac(counter-k);
    end
    y21_step(i) = (1/(1+M11+M21))*s21_step ;
    y21_impulse(i) = (1/(1+M11+M21))*s21_impulse ;
    i = i + 1 ;
    counter = counter + 1 ;
    s21_step = 0;
    s21_impulse = 0;
end
figure(6) ;
subplot(211) ;
stem(n,y21_step,'b') ;
xlabel('n') ;
ylabel('Step Response Filter2') ;
title('M1<=0 and M2=>0') ;
subplot(212) ;
stem(n,y21_impulse,'r') ;
xlabel('n') ;
ylabel('impulse Response Filter2') ;
%..........................................................................
%if M1=0 and M2=>0
counter = -15 ;
i = 1 ;
y22_step = [] ;
y22_impulse = [] ;
n = -15:1:15;
M12 = 0 ;
M22 = 10 ;
s22_step = 0 ;
s22_impulse = 0;
k = 0;
while counter<16
    while k<(M22+1)
        s22_step = s22_step + heaviside(counter-k);
        s22_impulse = s22_impulse + dirac(counter-k);
        k = k+1;
    end
    y22_step(i) = (1/(1+M12+M22))*s22_step ;
    y22_impulse(i) = (1/(1+M12+M22))*s22_impulse ;
    i = i + 1 ;
    counter = counter + 1 ;
    s22_step = 0;
    s22_impulse = 0;
    k = 0;
end
figure(7) ;
subplot(211) ;
stem(n,y22_step,'b') ;
xlabel('n') ;
ylabel('Step Response Filter2') ;
title('M1=0 and M2=>0') ;
subplot(212) ;
stem(n,y22_impulse,'r') ;
xlabel('n') ;
ylabel('impulse Response Filter2') ;
%..........................................................................
%if M1=>0 and M2=>0
counter = -15 ;
i = 1 ;
y23_step = [] ;
y23_impulse = [] ;
n = -15:1:15;
M13 = 3 ;
M23 = 10 ;
s23_step = 0 ;
s23_impulse = 0;
k = -M13;
while counter<16
    while k<(M23+1)
        s23_step = s23_step + heaviside(counter-k);
        s23_impulse = s23_impulse + dirac(counter-k);
        k = k+1;
    end
    y23_step(i) = (1/(1+M13+M23))*s23_step ;
    y23_impulse(i) = (1/(1+M13+M23))*s23_impulse ;
    i = i + 1 ;
    counter = counter + 1 ;
    s23_step = 0;
    s23_impulse = 0;
    k = 0;
end
figure(8) ;
subplot(211) ;
stem(n,y23_step,'b') ;
xlabel('n') ;
ylabel('Step Response Filter2') ;
title('M1=>0 and M2=>0') ;
subplot(212) ;
stem(n,y23_impulse,'r') ;
xlabel('n') ;
ylabel('impulse Response Filter2') ;
%..........................................................................