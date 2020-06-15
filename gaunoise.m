I=imread('gn.jpg');
I=imnoise(I,'gaussian',0,.02);
imwrite(I,'gn_0_.02.jpg','jpg');
figure,imshow(I)