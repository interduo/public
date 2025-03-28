#COPY FROM https://gist.github.com/h3ssan/9510fbb2291d41b090cf52adb2edd1c4#file-jetbrains-trial-reset-md

#In some cases, only these lines will work
for product in IntelliJIdea WebStorm DataGrip PhpStorm CLion PyCharm GoLand RubyMine; do
    rm -rf ~/.config/$product*/eval 2> /dev/null
    rm -rf ~/.config/JetBrains/$product*/eval 2> /dev/null
done

#But if not, try these

for product in IntelliJIdea WebStorm DataGrip PhpStorm CLion PyCharm GoLand RubyMine; do
    echo "[+] Resetting trial period for $product"

    echo "[+] Removing Evaluation Key..."
    rm -rf ~/.config/$product*/eval 2> /dev/null

    # Above path not working on latest version, Fixed below
    rm -rf ~/.config/JetBrains/$product*/eval 2> /dev/null

    echo "[+] Removing all evlsprt properties in options.xml..."
    sed -i 's/evlsprt//' ~/.config/$product*/options/other.xml 2> /dev/null

    # Above path not working on latest version, Fixed below
    sed -i 's/evlsprt//' ~/.config/JetBrains/$product*/options/other.xml 2> /dev/null

    echo
done

echo "Removing userPrefs files..."
rm -rf ~/.java/.userPrefs 2> /dev/null

