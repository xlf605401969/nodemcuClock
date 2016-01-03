module(..., package.seeall)

function BCDtoNumber(data)
    local bcd,numh,numl
    
    if type(data) == "string" then
        bcd = string.byte(data)
    else
        bcd = data
    end

    numh = math.floor(bcd/16)
    numl = bcd%16
    return numh*10 + numl
end 
        
    
