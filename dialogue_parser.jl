using DataFrames

for f in readdir(".")
  !contains(f,".txt") && continue
  dialogue = filter(line -> length(line) != 0, split(readall(f), r"\r|\n"))
  ps,ts,us = [],[],[]
  for u in dialogue
    u = rstrip(u)
    seg = split(u, "\t")
    if length(seg) != 2
      @show "error"
      exit() 
    end
    pt, u = seg
    p, t = split(pt, r"\s+")
    push!(ps, p), push!(ts, t), push!(us, u)
  end
  df = DataFrame(person = ps, time = ts, utterance = us)
  writetable("df_"*f, df, separator = '\t', header = true)
end
