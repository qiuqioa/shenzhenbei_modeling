clc
clear
observed_points = [
    110.241*97.304, 27.204*111.263, 0.824;
    110.780*97.304, 27.456*111.263, 0.727;
    110.712*97.304, 27.785*111.263, 0.742;
    110.251*97.304, 27.825*111.263, 0.850;
    110.524*97.304, 27.617*111.263, 0.786;
    110.467*97.304, 27.921*111.263, 0.678;
    110.047*97.304, 27.121*111.263, 0.575
];

reached_time_2=[
    110.767,164.229,214.850,270.065;
    92.453,112.220,169.362,196.583;
    75.560,110.696,156.936,188.020;
    94.653,141.409,196.517,258.985;
    78.600,86.216,118.443,126.669;
    67.274,166.270,175.482,266.871;
    103.738,163.024,206.789,210.306
    ];


dd=reached_time_2;%这里每一行作为一个数组；便于书写，如果长度不一，可以直接复制给下面的aaa元胞数组

    nx=size(dd,1);
    ny=size(dd,2);
        
    for i=1:nx
        [aaa{i} ]=sort_change( dd(i,:) );
    end
      
    xxx=1 ; %行数
    yyy=[];
    global nnn;    %组合序号
    nnn=1;
    global zuhe;   %存放所有组合
    zuhe={};
    temp=zeros(1,nx); 
    for i=aaa{xxx}     
        yyy(xxx)=i    ;   
        diedai(  aaa, xxx,  nx, yyy);
    end

    time_reached_combination=cell2mat(zuhe);
    time_reached_combinations=reshape(time_reached_combination,[7,16384])';

function []=diedai(aaa,xxx,nx,yyy)
   global zuhe
   global nnn
   xxx=xxx+1;;
    for i=aaa{xxx}

        yyy(xxx)=i;
        
        if length(yyy)-length(unique(yyy))>0
            continue;
        end
        if xxx<nx
            diedai(aaa,xxx,nx,yyy);
        end    
        if xxx==nx
            zuhe{nnn}=yyy;
            nnn=nnn+1;   
        end
            
    end   
end


function [ shu]=sort_change(temp)

    [a,b]=sort(temp) ;
    shu=a;
%     shunxu=b(1:3)
end
