echo "[*] Executant script per realitzar els checks"
IP="10.7.9." # Introduir el primers 3 bits de la ip
echo -e "[*] CHECK Gateway"

INT=$(ip a | grep "$IP*/24" -B 2 | head -1 | awk '{print $2}' | tr -d ":")

echo "[*] CHECK - GATEWAY Y IP"
if [[ $INT ]];then 
    echo "[Y] Sortida del check"
    route -n | head -2|tail -1 ; route -n | grep $INT
    ip a list $INT
else 
    echo "[N] ERROR no ha agafat la ip"
fi

echo "[*] CHECK - utilitzant la comanda dig"

echo -e "router.mhr.itb\nbdd.mhr.itb \neq1.mhr.itb \neq2.mhr.itb" > names_dns.txt
echo "[Y] Sortida del check"
dig router.mhr.itb

for nom in $(cat names_dns.txt); do echo -n "$nom ---> "; dig $nom +short;done

echo "[*] CHECK - wget www.itb.cat"
wget www.itb.cat && cat index.html | head

echo "[*] CHECK - Obrint pagina web"

firefox https://teamshadowdc.github.io/ &
firefox https://github.com/ & 

