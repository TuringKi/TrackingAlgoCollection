format long;
clear;
gtpathFormat = 'sequences/%s/%s_gt.mat';
obspathFormat = 'results/%s.txt';
 TEST_SETS = {'woman_sequence' ...
     'davidin300'  'Face' 'board' };
  gt_path = '';
  obs_path = '';
  
 for i = 1:length(TEST_SETS)
       gt_path = sprintf(gtpathFormat,TEST_SETS{i},TEST_SETS{i}); 
       obs_path = sprintf(obspathFormat,TEST_SETS{i}); 
      load(gt_path);
      obs_data = load(obs_path);
      
      fragCenterAll = cell(size(gtCenterAll));
     
      tCornersAll = cell(size(gtCornersAll));
    
      fragCornersAll = cell(size(gtCornersAll));
      
      cx = 0;cy = 0;t = 0;all_time = 0;w = 0;h = 0;
      x1 = [0,0]';
      x2 = [0,0]';
      x3 = [0,0]';
      x4 = [0,0]';
      for j = 1:length(obs_data)
       

          
       cx =  obs_data(j,1);
       cy =  obs_data(j,2);
       w = obs_data(j,3);
       h = obs_data(j,4);
       t= obs_data(j,5);
       
       x1 = [cx - w/2,cy - h/2]';
       x2 = [cx + w/2,cy - h/2]';
        x3 = [cx - w/2,cy + h/2]';
        x4 = [cx + w/2,cy + h/2]';
        tCornersAll{1,j} = [x1,x3,x4,x2,x1];
        
        fragCornersAll{1,j} = tCornersAll{1,j};
        
        all_time = all_time + t;
       fragCenterAll{1,j} = [cx,cy]';
      
      end
      fps = length(frameIndex)/all_time;
     save([ 'outputdata/' TEST_SETS{i} '_frag_rs.mat'], 'fragCenterAll', 'fragCornersAll', 'fps')
      
 end

 