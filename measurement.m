function intensity=measurement(v,goal,robot)
    [X,Y]=meshgrid(v);
 
    dir=goal;
    H=[dir; dir; dir];
    sign_a=-dir(1)/abs(dir(1));
    sing_b=-dir(2)/abs(dir(2));    
    
    k=1000;scale=150;
    I1 = k*exp(sign_a*(X-H(1,1)).^2/scale+sing_b*(Y-H(1,2)).^2/scale);   % (0,0)
    I2 = k*exp(sign_a*(X-H(2,1)).^2/scale+sing_b*(Y-H(2,2)).^2/scale);   % (1,1)
    I3 = k*exp(sign_a*(X-H(3,1)).^2/scale+sing_b*(Y-H(3,2)).^2/scale);  % (-2,2)

    intensity=I1+I2+I3;
%     intensity=INV(intensity);
end
