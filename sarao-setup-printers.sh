#!/bin/bash
lpadmin -p LH2-West  -E -v lpd://katscan.kat.ac.za/print    -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House 2nd Floor West"    -D "LH2-West"
lpadmin -p LH2-East  -E -v lpd://katscan3.kat.ac.za/print   -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House 2nd Floor East"    -D "LH2-East"
lpadmin -p LH1-East  -E -v lpd://katscan4.kat.ac.za/print   -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House 1st Floor East"    -D "LH1-East"
lpadmin -p LH0-East  -E -v lpd://katscan1.kat.ac.za/print   -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House Ground Floor East" -D "LH0-East"
lpadmin -p LH0-West  -E -v lpd://katscan2.kat.ac.za/print   -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House Ground Floor West" -D "LH0-West"
lpadmin -p LH1-West  -E -v lpd://katscanfin.kat.ac.za/print -P /usr/local/share/sarao-printers/KOC751iUX.ppd -L "Liesbeek House 1st Floor West"    -D "LH1-West"
