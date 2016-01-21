obs = {};
feelings = {'joie';'degout';'surprise';'joie';'neutre';'peur';'tristesse';
            'tristesse';'degout';'joie';'joie';'peur';'degout';'surprise';
            'tristesse';'surprise';'degout';'joie';'neutre';'colere';'degout';
            'tristesse';'degout';'degout';'joie';'tristesse';'joie';'joie';
            'joie';'neutre';'peur'};
field1='data';
field2='apexlm';
figure(1);
for i=1:31
    img = imread(strcat(num2str(i),'.png'));
    imshow(img, []);
    pause(0.01);
    img=double(img);
    img2=reshape(img,4050,1);
    s =struct(field1, {img2}, field2, {img});
    obs = [obs; s];
end
clear img img2 field1 field2 i data apexlm s;
num_observations = 31;
imgwidth = 81;
imglen = 50;
disp('fini');
save learning3.mat