function to_simulink = calc_saturation()

    SG10 = 0.1;
    SG12= 0.3;
    
    ifd = 0:0.05:4.0;
    Vn = zeros(length(ifd),1);
    q = log(1.2*SG12/SG10)/log(1.2);
    
    % ifd = Vt + SG10*Vt^q; taken from PowerFactory and Weber;
    
    for i = 1:length(ifd)
        x0 = ifd(i);
        func = @(x) x + SG10*x^q -ifd(i);
        Vn(i) = fzero(func,x0);
    end
    
    %plot(ifd,Vn)
    
    to_simulink = [ifd; Vn'];

end