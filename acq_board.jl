
using StatPlots
using JuliaDBMeta
using TableView
using GroupedErrors

# Changes the working path to the data folder


cd("/home/quendera/Documents/CCU/Albino/CR_TMS_Analysis/")
board_raw = "patientzero2018-06-25T17_15_46.bin"

function read_bin(path)

    data = open(read, path)

    if isodd(size(data)[1])
        df = reshape(data,:,6)
        tt = table((df[:, i] for i in 1:6)..., names = Symbol.(["A$j" for j in 1:6]))

    else
        df = reshape(data,:,7)
        n = ["x$j" for j in 1:7]
        tt = table((df[:, i] for i in 1:7)..., names = Symbol.(["A$j" for j in 1:7]))
    end
    tt
end

t = read_bin(board_raw)

using Distributions

plotlyjs()
@apply t begin
    @transform_vec {idx = (1:length(_))}
    @df plot(:A6)
end


TableView.showtable(t, rows = 1:4500)

using Images

sig = cos.(linspace(0, 10pi, 2000))
maxs_cart = findlocalmaxima(sig)
maxs = [idx[1] for idx in maxs_cart]
plot(sig)

a = table(sig, names = [:hello])
maxs

bb = @apply a begin
    @transform_vec {idx = (1:length(_))}#if a.inde}
    @transform {stim_on = (:idx == i for i in [1,2,3])}
end

x = [1,2,3,4]
plot(x, x*3)

@> t begin
 @x _.A1
 @plot
end

TableView.showtable(bb)


2S$ohNSFZp7TG](d

using HTTP

r = HTTP.post("10.20.22.246")

println(r.status)
println(String(r.body))
