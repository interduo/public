#Przegląd baz na portach
for port in 5432 5433 5434; do
    echo "===== PORT $port ====="
    sudo -u postgres psql -p "$port" -Atc \
      "SELECT datname FROM pg_database WHERE NOT datistemplate ORDER BY datname;"
done

#Upgrade postgresa np.
pg_upgradecluster -v 15 --method=upgrade 11 main
