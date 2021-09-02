list_x = [0,0.05,0.1,0.125,0.15,0.2,0.25,0.3];
list_y = [0,0.02,0.04,0.1,0.2];%[0,0.02,0.04,0.08,0.1,0.15,0.2,0.25];
list_phi = [0,pi/4,pi/3,pi/2];

est_ef = [];
normB = [];

for k=1:length(list_phi)
    for i=1:length(list_x)
        for j=1:length(list_y)
            if list_y(j)==0 && list_x(i)<0.1
                continue
            end
            model.param.set('x1',list_x(i));
            model.param.set('y1',list_y(j));
            model.param.set('phi1',list_phi(k));
            simulate;
            gobj1 = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset2'));
            est_ef(end+1) = gobj1(1)
            iobj1 = mpheval(model,'sens2.iobj1','dataonly','on','dataset','dset2');
            normB(end+1) = iobj1(1);
        end
    end
end

%est_ef =

%  Columns 1 through 10

 %   0.5586    0.5861    0.5386    0.5356    0.2737    0.3263    0.5877    0.5849    0.4544    0.4314

  %Columns 11 through 14

   % 0.3975    0.6592    0.5850    0.6754