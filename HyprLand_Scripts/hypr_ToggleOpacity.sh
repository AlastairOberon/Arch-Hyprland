# Get the address of the focused window
addr=$(hyprctl activewindow -j | jq -r '.address')

# Get current opacity (default to 1 if undefined)
current_opacity=$(hyprctl getoption "opacity.$addr" -j | jq -r '.float')

# Toggle
if [[ "$current_opacity" == "1" ]]; then
    hyprctl dispatch opacity "$addr" 0.8 0.6
else
    hyprctl dispatch opacity "$addr" 1.0 1.0
fi