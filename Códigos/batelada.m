phi = [60,55];

%phi =30: [0.025,0.05,0.075,0.1,0.125,0.145]


%mag_ef =

%    0.2633    0.4607    0.6147    0.7304    0.8175    0.8749    0.5854    0.7799    0.6137


%est_ef =

 %   0.6981    0.7489    0.7777    0.8073    0.8381    0.8735    0.4657    0.4857    0.7829

 
 
%phi=15: w = [0.025,0.05,0.075];

est_ef = [];
mag_ef = [];
disp = [];

for k=1:length(phi)
            %model.param.set('w_mag',w(k));
            model.param.set('phi3',strcat(num2str(phi(k)),'[deg]'));
            simulate;
            gobj1 = (mpheval(model,'sens2.gobj1','dataonly','on','dataset','dset2'));
            mag_ef(end+1) = gobj1(1)
            gobj2 = mpheval(model,'sens2.gobj2','dataonly','on','dataset','dset2');
            est_ef(end+1) = gobj2(1)
            
            disp1 = mpheval(model,'sens2.iobj4','dataonly','on','dataset','dset2');
            disp2 = mpheval(model,'sens2.iobj5','dataonly','on','dataset','dset2');
            disp3 = mpheval(model,'sens2.iobj6','dataonly','on','dataset','dset2');
            disp4 = mpheval(model,'sens2.iobj7','dataonly','on','dataset','dset2');
            disp5 = mpheval(model,'sens2.iobj8','dataonly','on','dataset','dset2');
            
            disp(k,1) = disp1(1);
            disp(k,2) = disp2(1);
            disp(k,3) = disp3(1);
            disp(k,4) = disp4(1);
            disp(k,5) = disp5(1)
end