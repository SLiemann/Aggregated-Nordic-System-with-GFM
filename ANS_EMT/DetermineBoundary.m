function [r,x] = DetermineBoundary(XR,Rv,Xv)

    r = [];
    x = [];
    flag_dir = "left";
    flag_end = false;

    XR = XR';
    Rv = Rv(1,:);
    Xv = Xv(:,1);

    lenx = size(XR,1);
    lenr = size(XR,2);

    %starting indices
    indr = 1;
    indx = 0;
    for i=1:size(XR,1)
        if XR(i,1) == 1
            indx =i;
            break
        end
    end

    %saving first entry
    r = [r;Rv(indr)];
    x = [x;Xv(indx)];
     
    counter = 0;

    while flag_end == false && counter < 1e4
        if flag_dir == "top"
            [flag_end,flag_dir,indr,indx,r,x] = next_ind(2,flag_dir,XR,Rv,Xv,indr,indx,r,x);
        elseif flag_dir == "left"
            [flag_end,flag_dir,indr,indx,r,x] = next_ind(1,flag_dir,XR,Rv,Xv,indr,indx,r,x);
        elseif flag_dir == "bottom"
            [flag_end,flag_dir,indr,indx,r,x] = next_ind(4,flag_dir,XR,Rv,Xv,indr,indx,r,x);
        elseif flag_dir == "right"
            [flag_end,flag_dir,indr,indx,r,x] = next_ind(3,flag_dir,XR,Rv,Xv,indr,indx,r,x);
        else
            error("error")
        end
        counter = counter + 1;
    end
    if counter == 1e4
        error("Counter reached 1e4")
    end
end

