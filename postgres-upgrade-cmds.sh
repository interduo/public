#Przegląd baz na portach
#!/bin/bash
for port in 5432 5433 5434 5435; do
    echo "===== PORT $port ====="
    runuser -u postgres -- psql -p "$port" -Atc \
        "SELECT datname FROM pg_database WHERE NOT datistemplate ORDER BY datname;" \
        || echo "(no cluster responding on port $port)"
done

#Upgrade postgresa np.
pg_upgradecluster -v 15 --method=upgrade 11 main
