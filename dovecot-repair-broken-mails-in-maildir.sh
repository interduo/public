#!/bin/bash
# Skrypt do naprawy niezgodnych rozmiarów S= w nazwach plików Maildir
# + sprawdzanie atrybutów pliku
# + automatyczny resync Dovecota
# Autor: Jarosław Kłopotek <jkl@interduo.pl>
# Użycie: ./fix-maildir-sizes.sh /ścieżka/do/Maildir adres_email

MAILDIR="$1"
USER="$2"

if [ -z "$MAILDIR" ] || [ -z "$USER" ]; then
  echo "Użycie: $0 /ścieżka/do/Maildir adres_email"
  exit 1
fi

if [ ! -d "$MAILDIR" ]; then
  echo "Błąd: katalog $MAILDIR nie istnieje"
  exit 1
fi

echo "===> Sprawdzanie Maildir: $MAILDIR dla użytkownika $USER"

# Znajdź wszystkie pliki z parametrem S=
find "$MAILDIR" -type f -regex '.*S=[0-9]+.*' | while read -r FILE; do
    REALSIZE=$(stat -c %s "$FILE")
    BASENAME=$(basename "$FILE")
    DIRNAME=$(dirname "$FILE")

    # Wyciągnij aktualny S= z nazwy
    CURRENT_S=$(echo "$BASENAME" | grep -o 'S=[0-9]\+')
    CURRENT_S_VAL=${CURRENT_S#S=}

    if [ "$REALSIZE" -ne "$CURRENT_S_VAL" ]; then
        # Atrybuty pliku (zachowamy je po zmianie nazwy)
        OWNER=$(stat -c %U "$FILE")
        GROUP=$(stat -c %G "$FILE")
        PERMS=$(stat -c %a "$FILE")

        # Nowa nazwa z poprawnym S=
        NEWNAME=$(echo "$BASENAME" | sed "s/S=$CURRENT_S_VAL/S=$REALSIZE/")

        echo "Naprawa: $BASENAME  (S=$CURRENT_S_VAL → $REALSIZE)"
        echo "  Atrybuty: właściciel=$OWNER grupa=$GROUP prawa=$PERMS"

        mv "$DIRNAME/$BASENAME" "$DIRNAME/$NEWNAME"

        # Przywróć właściciela i prawa
        chown "$OWNER:$GROUP" "$DIRNAME/$NEWNAME"
        chmod "$PERMS" "$DIRNAME/$NEWNAME"
    fi
done

echo "===> Zakończono naprawę nazw plików Maildir."

# Resync Dovecota
echo "===> Wymuszanie resync Dovecota dla skrzynki $USER"
doveadm force-resync -u "$USER" '*'

echo "===> Gotowe."
