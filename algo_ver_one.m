I = imread('Test Images\leaf.jpg');
I_bw = rgb2gray(I);

L_I = imresize(I,2,'lanczos2');

[LoD HiD] = wfilters('haar','d');
[a b c d] = dwt2(I,LoD,HiD);

a = uint8(a);
b = uint8(b);
c = uint8(c);
d = uint8(d);

S_I = edge(I_bw,'sobel');

diff = imabsdiff(I, imresize(a,2,'lanczos2'));

b_subband = imadd(rgb2gray(imresize(imadd(diff, imresize(b,2,'lanczos2')),2,'nearest')),imresize(S_I,2,'nearest'));
c_subband = imadd(rgb2gray(imresize(imadd(diff, imresize(c,2,'lanczos2')),2,'nearest')),imresize(S_I,2,'nearest'));
d_subband = imadd(rgb2gray(imresize(imadd(diff, imresize(d,2,'lanczos2')),2,'nearest')),imresize(S_I,2,'nearest'));

final_rose = idwt2(L_I, b_subband, c_subband, d_subband, LoD, HiD);

imwrite(final_rose, 'Result Images\final.jpg');
