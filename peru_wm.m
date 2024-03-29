
%% colorbar 
    m=0.2;
    ASS=[35:0.1:35.5]';
    ACF=[34.8:0.07:35.1]';
    AES=[33.8:0.07:34.9]';
    ATS=[33:0.07:33.9]';

    n=0;
    for i=1:1:size(ASS,1)

        mymapA0=[1-(n/10) 1-(n/2) 0+(n/5)];
        n=n+m;
        mymapA(i,1:1:size(mymapA0,2))=mymapA0;
        myA=flip(mymapA);

    end
    % 
    m1=0.2;
    n=0;
    for i=1:1:size(ACF,1)
        mymapB0=[0 1-(n/3) 1-(n/3)];
        n=n+m1;
        mymapB(i,1:1:size(mymapB0,2))=mymapB0;
        myB=flip(mymapB);

    end

    m2=0.05;
    n=0;
    for i=1:1:size(AES,1)

        mymapC0=[0.75-(n/2.5) 0+(n/4) 0.75-(n/4)];
        n=n+m2;
        mymapC(i,1:1:size(mymapC0,2))=mymapC0;
        myC=flip(mymapC);

    end

    m3=0.05;
    n=0;
    for i=1:1:size(ATS,1)

        mymapD0=[0.6+(n/1.5) 0+n 0+n];
        n=n+m3;
        mymapD(i,1:1:size(mymapD0,2))=mymapD0;
        myD=flip(mymapD);

    end


    peru_wm=cat(1,myD,myC,myB,myA);
     colormap(peru_wm)

 save('MA_peru','peru_wm');