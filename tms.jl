using DataFrames

function arr2df(data)
    names = [:Layout, :Session, :Entry, :Year, :Month, :Day, :Hour, :Minute, :Second, :EventType, :Lenght, :Curr_Session, :Log, :Train, :Mode, :Time, :A_amp, :B_amp]

    df = DataFrame()

    i = size(data)[1]

    for (ind,val) in enumerate(names)
        df[val] = [data[i,ind] for i in 1:i]
    end

    return df
end
