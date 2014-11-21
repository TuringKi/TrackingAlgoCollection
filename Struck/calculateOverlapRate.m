function overlapRate = calculateOverlapRate(region1, region2, option)
%%function overlapRate = calculateOverlapRate(region1, region2, option)
%%Calculate Overlap Rate Between Two Regions.
%%Version 1.0
%%
%%Input:
%%  region1:        the parameters of region one
%%  region2:        the parameters of region two
%%  option:         describe special meanings of 'region1' and 'region2' 
%%      'quadrilateral':    default
%%                          use a 2x5 matrix depict a quadrilateral region
%%                          [ r1 r2 r3 r4 r1...
%%                           c1 c2 c3 c4 c1 ]
%%              For Simple Test:
%%              region1 = [ 100 150 150 100 100 ; 200 200 300 300 200 ];
%%              region2 = [ 50 120 120 50 50 ;    210 210 300 300 210 ];
%%              overlapRate = calculateOverlapRate(region1, region2, 'quadrilateral')
%%      'ellipse':          will be implemented when neccessary
%%      
%%Output:
%%  overlapRate:    the overlap rate between two regions
%%Authour:
%%  Dong Wang-IIAU LAB-2011,05,10
%%  http://ice.dlut.edu.cn/lu/index.html
%%V1.0 (2011,05,10): Calculate Overlap Rate Between Two Quadrilateral Regions
%%

if  isempty(option)
    option = 'quadrilateral';
end

if  strcmp(option, 'quadrilateral')
    %%NaN
    if  (sum(sum(isnan(region1)))~=0) || (sum(sum(isnan(region2))~=0))
        overlapRate = 0.0;
        return;
    end    
%%Step (1): Compute Bounding Boxes and Centers of Two Quadrilateral Regions
    %%Bounding Box of region 1
    r1Min = min(region1(1,:));  r1Max = max(region1(1,:));
    c1Min = min(region1(2,:));  c1Max = max(region1(2,:));
    %%Height and Width of Bounding Box 1
    h1 = (r1Max-r1Min+1);       w1 = (c1Max-c1Min+1);
    %%Bounding Box of region 2
    r2Min = min(region2(1,:));  r2Max = max(region2(1,:));
    c2Min = min(region2(2,:));  c2Max = max(region2(2,:));
    %%Height and Width of Bounding Box 1
    h2 = (r2Max-r2Min+1);       w2 = (c2Max-c2Min+1);
    %%Center of region 1
    r1Cen = (r1Min+r1Max)/2;    c1Cen = (c1Min+c1Max)/2;
    %%Center of region 1
    r2Cen = (r2Min+r2Max)/2;    c2Cen = (c2Min+c2Max)/2;
%%Step (2): Overlap or Not
    if  abs(r1Cen-r2Cen)>((h1+h2)/2) || abs(c1Cen-c2Cen)>((w1+w2)/2)
        overlapRate = 0.0;
    else
%%Step (3): Compute Overlap Rate 
    %%Big Bounding Box For two regions
    roMin = round(min(r1Min,r2Min));   roMax = round(max(r1Max,r2Max));
    coMin = round(min(c1Min,c2Min));   coMax = round(max(c1Max,c2Max));
    %%X and Y Coordinates of Big Bounding Box
    y = repmat([roMin:roMax]', 1, coMax-coMin+1);
    y = y(:);
    x = repmat([coMin:coMax], roMax-roMin+1, 1);
    x = x(:);
    %%Map1
    map1 = inpolygon(x, y, region1(2,:), region1(1,:));
    %%Map2
    map2 = inpolygon(x, y, region2(2,:), region2(1,:));
    %%OverlapRate
    map = map1+map2;
    overlapRate = (sum(map==2))/(sum(map>0));
    end
end

