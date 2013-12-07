" Custom vim syntax file for XML

if !has('conceal')
    finish
endif

syn match Conceal /<\/.*>/ conceal cchar=□  "▪•¬
set conceallevel=2
