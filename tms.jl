#using DataFrames
using JuliaDBMeta
using StatPlots
#=
Get the settings from the TMS machine
=#
#
# function arr2df(data)
#     names = [:Layout, :Session, :Entry, :Year, :Month, :Day, :Hour, :Minute, :Second, :EventType, :Lenght, :Curr_Session, :Log, :Train, :Mode, :Time, :A_amp, :B_amp]
#
#     df = DataFrame()
#
#     i = size(data)[1]
#
#     for (ind,val) in enumerate(names)
#         df[val] = [data[i,ind] for i in 1:i]
#     end
#
#     return df
# end


#=
Convert data from crazy TMS machine format to a df
=#
test = loadtable("/home/quendera/Documents/CCU/Albino/data/Patient0/tms/R30 SN0/MEP data/MEP Data (10-1).csv")

a = loadtable("/home/quendera/Documents/CCU/Albino/data/Patient0/tms/R30 SN0/MEP data/MEP Data (10-1).csv", delim=';', colnames = ["MEP$j" for j in 1:11], header_exists = false, skiplines_begin=19)

t = table(a)

colnames(t)



using TableView

TableView.showtable(a)
@apply t begin
    @select(t, mean(cols(t)))
end

#use walkdir() to iterate paths

dd = "/home/quendera/Documents/CCU/Albino/data/retreat/"
for i in readdir(dir)
    for j in readdir(dir*i)
        println(a)
        a = loadtable("/home/quendera/Documents/CCU/Albino/data/Patient0/tms/R30 SN0/MEP data/MEP Data (10-1).csv", delim=';', colnames = ["MEP$j" for j in 1:11], header_exists = false, skiplines_begin=19)
        table(a)
        renamecol(a, :MEP1, :Time)
        #t = setcol(table(a), :Session, [j])
        j =+ 1
    end
    i =+1
end


for (root, dirs, files) in walkdir(dd)
    println("Directories in $root")
    for dir in dirs
        println(joinpath(root, dir)) # path to directories
    end
    println("Files in $root")
    for file in files
        println(joinpath(root, file)) # path to files
    end
end



function read_tms(path)

    data = open(read, path)

    if isodd(size(data)[1])
        df = reshape(data,:,6)
        tt = table((df[:, i] for i in 1:6)..., names = Symbol.(["x$j" for j in 1:6]))

    else
        df = reshape(data,:,7)
        n = ["x$j" for j in 1:7]
        tt = table((df[:, i] for i in 1:7)..., names = [:n, :n2, :n3 ,:n4, :n5, :n6, :n7])
    end
    tt
end

read_tms(t)
