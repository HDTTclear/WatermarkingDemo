%������1024*1024��ͼƬ
[X,map]=imread('2732x2048-Background-HD-Wallpaper-104.jpg');
%X=X(:,:,2);
X=X(1:1024,1:1024,:);
X_origin=X;
%ȡ��ɫ��ͨ��
X_mark=X(1:1024,1:1024,2);
%ȡˮӡ
[marking map]=imread('D:\HDTT\marking\HDTT_water_1024_2.png');
%ϵ����ģʽ��ѹ������
coff = 4;mode=0;pixel_target=720;
%���ˮӡ
inverse_figure=mark_the_figure_1024(X_mark,marking,coff);
%ѹ������
inverse_figure_resized=imresize(inverse_figure,pixel_target/1024);    
inverse_figure_resized=imresize(inverse_figure_resized,1024/pixel_target);
%��ȡˮӡ
marking=decomposed_the_marking_1024(inverse_figure_resized,coff,mode,X_origin(:,:,2));
X(:,:,2)=inverse_figure;

figure,set(gcf,'unit','normalized','position',[0,0,0.9,0.9]);
subplot(1,3,1),imshow(X_origin);title('ԭͼ')
subplot(1,3,2),imshow(X);title('��ˮӡ���ͼ');
subplot(1,3,3),imshow(imresize(marking,1024/32));title('��ȡˮӡ');

%�����Ǵ�����Ƶ�ķ������룬������ȡ��Ƶ֡��ˮӡ
%figure,imshow(X)
%{
v = VideoReader('��Ĳ��� �\ Made with Clipchamp.mp4');
coff = 8;%ǿ��
pixel_target=720;%ѹ����Ĵ�С
mode=0;%ģʽ,0��ʹ��ԭͼ��1ʹ��ԭͼ

for i = 1:200:2000
    frame = read(v,i);%��ȡ֡
    
    frame_mark_zone = frame(28:28+1023,448:448+1023,:);%��ȡ1920*1080��1024*1024����
    frame_mark_zone_marked = frame_mark_zone(:,:,2);%����2ͨ����
    %���ˮӡ
    inverse_figure=mark_the_figure_1024(frame_mark_zone_marked,marking,coff);
    %ѹ������
    inverse_figure_resized=imresize(inverse_figure,pixel_target/1024);    
    inverse_figure_resized=imresize(inverse_figure_resized,1024/pixel_target);
    %��ȡˮӡ
    marking_inverse=decomposed_the_marking_1024(inverse_figure_resized,coff,mode,frame_mark_zone_marked);
    %figure,imshow(marking_inverse);
    frame_mark_zone(:,:,2)=inverse_figure;
    frame_marked=frame;
    frame_marked(28:28+1023,448:448+1023,:)=frame_mark_zone;
    figure,set(gcf,'unit','normalized','position',[0,0,0.9,0.9]);
    suptitle(["��";string(i);"��"])
    subplot(2,2,3),imshow(frame_marked);title('��ˮӡͼ')
    subplot(2,2,1),imshow(frame);title('ԭͼ')
    subplot(2,2,[2 4]),imshow(imresize(marking_inverse,1024/64));title('��ȡ��ˮӡ')
end
%}