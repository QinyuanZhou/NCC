%ªÒ»°I∫ÕT
clc;
clear;
template_rgb=imread('TT.png');
src_rgb=imread('II.png');
template=rgb2gray(template_rgb);
src=rgb2gray(src_rgb);
T=im2double(template);
I=im2double(src);

%qinyuan
