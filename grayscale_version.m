% Implementation of the Algorithm in the paper : https://ieeexplore.ieee.org/document/6622152

% For Grayscale Images

% To add explanation for variables

I = rgb2gray(imread('Test Images\leaf.jpgg'));

%I_bw = rgb2gray(I);

L_I = imresize(I,2,'lanczos2');

S_I = edge(I_bw,'sobel');
S_I = im2uint8(S_I);

[LoD HiD] = wfilters('haar','d');

[a b c d] = dwt2(I,LoD,HiD);
a = uint8(a);
b = uint8(b);
c = uint8(c);
d = uint8(d);

L_a = imresize(a,2,'lanczos2');
L_b = imresize(b,2,'lanczos2');
L_c = imresize(c,2,'lanczos2');
L_d = imresize(d,2,'lanczos2');
diff = imabsdiff(I,L_a);
diff_L_b = imadd(diff,L_b);
diff_L_c = imadd(diff,L_c);
diff_L_d = imadd(diff,L_d);

NNI_diff_L_b = imresize(diff_L_b,2,'nearest');
NNI_diff_L_c = imresize(diff_L_c,2,'nearest');
NNI_diff_L_d = imresize(diff_L_d,2,'nearest');
NNI_S_I = imresize(S_I,2,'nearest');

%NNI_diff_L_b_bw = rgb2gray(NNI_diff_L_b);
%NNI_diff_L_c_bw = rgb2gray(NNI_diff_L_c);
%NNI_diff_L_d_bw = rgb2gray(NNI_diff_L_d);

b_subband = imadd(NNI_diff_L_b,NNI_S_I);
c_subband = imadd(NNI_diff_L_c,NNI_S_I);
d_subband = imadd(NNI_diff_L_d,NNI_S_I);

final = idwt2(L_I,b_subband,c_subband,d_subband,LoD,HiD);
final = uint8(final);

imshow(final);
imwrite(final,'Result Images\final.jpg');
