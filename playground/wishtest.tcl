#!/opt/local/bin/wish -f

# Label-Widget namens .l erzeugen
label .l -text "Filename:"
# Eingabe-Widget namens .e erzeugen
entry .e -relief sunken -width 30 -textvariable fname

# Beide Widgets im Fenster der Anwendung plazieren
pack .l -side left
pack .e -side left -padx 1m -pady 1m

# Nach RETURN im Eingabefenster, xterm starten
bind .e <Return> {
 exec xterm -e vi $fname
}

