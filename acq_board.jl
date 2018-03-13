using DataFrames

function read_bin(path)

    data = open(read, path)

    if isodd(size(data)[1])
        df = reshape(data,6,:)
    else
        df = reshape(data,7,:)
    end

    return df
end
