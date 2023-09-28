function getVoltageSymbolPositions(pg::PowerGrid)
    n = map(x->PowerDynamics.variable_index(pg.nodes,x,:u_r),collect(keys(pg.nodes)))
    append!(n,map(x->PowerDynamics.variable_index(pg.nodes,x,:u_i),collect(keys(pg.nodes))))
end

function getComplexBusVoltage(pg::PowerGrid,ic::Array{Float64,1})
    ind = sort(getVoltageSymbolPositions(pg))
    Uc = Complex.(zeros(Int(length(ind)/2)))
    for (i,val) in enumerate(ind[1:2:length(ind)])
        Uc[i] = ic[val] + 1im*ic[val+1]
    end
    return Uc
end

function getallParameters(node)
    cond = true
    i = 1
    param = Vector{Float64}()
    while cond
        try
            tmp = getfield(node,i)
            append!(param,tmp)
            i += 1
        catch
            cond = false
        end
    end
    param[1:end-1] #last entry is Y_n from PowerDynamics
end


function DetermineBoundary(XR,Rv,Xv)
    r = Vector{Float64}()
    x = Vector{Float64}()
    flag_dir = "left"
    flag_end = false
    ind = [(-1,0);(0,1);(1,0);(0,-1)]

    XR = reverse(XR)'
    Rv = reverse(Rv)
    Xv = reverse(Xv)

    lenx = size(XR)[1]
    lenr = size(XR)[2]

    #starting indices
    indr = 1
    indx = findfirst(k->k==1,XR[:,1])

    #saving first entry
    push!(r,Rv[indr])
    push!(x,Xv[indx])

    function next_ind(start_ind,r,x)
        for i=start_ind:start_ind+3
            if mod(i,4) == 0
                dx = ind[4][1]
                dr = ind[4][2]
            else
                dx = ind[mod(i,4)][1]
                dr = ind[mod(i,4)][2]
            end

            if indr+dr == 0 || indr+dr > lenr || indx+dx > lenx 
                #skip boundarys
            elseif indx + dx == 1  && XR[indx,indr] == 1 
                indr = indr + dr
                indx = indx + dx
                push!(r,Rv[indr])
                push!(x,Xv[indx])
                indr = indr -1
                
                while indr != 0 && XR[indx,indr] == 1  # go x-axis to zero 
                    push!(r,Rv[indr])
                    push!(x,Xv[indx])
                    indr = indr -1
                end
                flag_end = true
                break;
            elseif XR[indx+dx,indr+dr] != 1 
                #skip unstable case
            elseif XR[indx + dx,indr + dr] == 1
                indr = indr + dr
                indx = indx + dx
                push!(r,Rv[indr])
                push!(x,Xv[indx])

                if mod(i,4) == 1
                   flag_dir = "bottom"
                   break;
                elseif mod(i,4) == 2
                   flag_dir = "left"
                   break;
                elseif mod(i,4) == 3
                    flag_dir = "top"
                    break;
                elseif mod(i,4) == 0
                    flag_dir = "right"
                    break;
                else
                    error("error2")
                end
            end 
        end
        return flag_end,flag_dir,r,x
    end    
    counter = 0;

    while flag_end == false && counter < 1e4
        if flag_dir == "top"
            flag_end,flag_dir,r,x = next_ind(2,r,x)
        elseif flag_dir == "left"
            flag_end,flag_dir,r,x = next_ind(1,r,x)
        elseif flag_dir == "bottom"
            flag_end,flag_dir,r,x = next_ind(4,r,x)
        elseif flag_dir == "right"
            flag_end,flag_dir,r,x = next_ind(3,r,x)
        else
            error("error")
        end
        counter = counter + 1
    end
    if counter == 1e4
        error("Counter reached 1e4")
    end
    return r,x
end

function CompareXRResults(obj::Array{String})
    sc = Vector{GenericTrace}()
    for i in obj
        data = load(i)
        Rv= data["Rverlauf"];
        Xv = data["Xverlauf"];
        XRv= data["XR"];
        x,y = DetermineBoundary(XRv,Rv,Xv)
        tmp_sc = scatter(x=x,y=y,name=i)
        push!(sc,tmp_sc)
    end
    display(plot(sc))
end


# The following PiModel function is copied from the actual PowerDynamics package, Michael
function PiModel(y, y_shunt_km, y_shunt_mk, t_km, t_mk)
    Π = Matrix{Any}(undef,2,2)#zeros(Complex{Float64}, 2, 2)
    Π[1, 1] = - abs2(t_km) * (y + y_shunt_km) # Our sign convention is opposite for the source of the edge
    Π[1, 2] = conj(t_km) * t_mk * y # Our sign convention is opposite for the source of the edge
    Π[2, 1] = - conj(t_mk) * t_km * y
    Π[2, 2] = abs2(t_mk) * (y + y_shunt_mk)
    Π
end

function getPreFaultAlgebraicStates(pg::PowerGrid,ic_prefault::Array{Float64,1},ic_endfault::Array{Float64,1})
    prob = ODEFunction(rhs(pg))
    ind = findall(x-> iszero(x),diag(prob.mass_matrix))
    ic_endfault[ind] = ic_prefault[ind]
    return ic_endfault
end