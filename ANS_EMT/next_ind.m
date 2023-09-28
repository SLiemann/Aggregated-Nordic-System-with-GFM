function [flag_end,flag_dir,indr,indx,r,x] = next_ind(start_ind,flag_dir,XR,Rv,Xv,indr,indx,r,x)
    flag_end = false;
    ind = [-1 0;0 1;1 0;0 -1];
    lenx = size(XR,1);
    lenr = size(XR,2);
    if length(r)==14
        a=1;
    end

    for i=start_ind:start_ind+3
        dx = 0;
        dy = 0;
        if mod(i,4) == 0
            dx = ind(4,1);
            dr = ind(4,2);
        else
            dx = ind(mod(i,4),1);
            dr = ind(mod(i,4),2);
        end

        if indr+dr == 0 || indr+dr > lenr || indx+dx > lenx 
            %skip boundarys
        elseif indx + dx == 1 && XR(indx+ dx,indr+dr) == 1 
            indr = indr + dr;
            indx = indx + dx;
            r = [r;Rv(indr)];
            x = [x;Xv(indx)];
            indr = indr -1;
            
            while indr ~= 0 && XR(indx,indr) == 1  % go x-axis to zero 
                r = [r;Rv(indr)];
                x = [x;Xv(indx)];
                indr = indr -1;
            end
            flag_end = true;
            break;
        elseif XR(indx+dx,indr+dr) ~= 1 
            %skip unstable case
        elseif XR(indx+dx,indr+dr) == 1
            indr = indr + dr;
            indx = indx + dx;
            r = [r;Rv(indr)];
            x = [x;Xv(indx)];

            if mod(i,4) == 1
               flag_dir = "bottom";
               break;
            elseif mod(i,4) == 2
               flag_dir = "left";
               break;
            elseif mod(i,4) == 3
                flag_dir = "top";
                break;
            elseif mod(i,4) == 0
                flag_dir = "right";
                break;
            else
                error("error2")
            end
        end 
    end
end

