#Those options are problematic during migration (they didnt exists in newer versions)
grep -rnE '^(shared_preload_libraries|ssl_cert_file|ssl_key_file|stats_temp_directory)' /etc/postgresql/11/main/

#See databases on each instances
#!/bin/bash
for port in 5432 5433 5434 5435; do
    echo "===== PORT $port ====="
    runuser -u postgres -- psql -p "$port" -Atc \
        "SELECT datname FROM pg_database WHERE NOT datistemplate ORDER BY datname;" \
        || echo "(no cluster responding on port $port)"
done

#Upgrading clusters
#FOR BIG DB TRY --method=link
pg_upgradecluster -v 15 --method=upgrade 11 main
