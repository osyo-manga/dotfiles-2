
# profile

# set the right color profile according to ambient light
# works only with iTerm2

if [ `$(dirname $0)/light` -ge 120000 ]; then
    echo -ne "\033]50;SetProfile=Day\a"
else
    echo -ne "\033]50;SetProfile=Night\a"
fi
