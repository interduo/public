for d in /sys/kernel/iommu_groups/*/devices/*; do n=${d#*/iommu_groups/*}; n=${n%%/*}; printf 'IOMMU group %s ' "$n"; lspci -nns "${d##*/}"; done | grep 'Ethernet' | sort

exit;

IOMMU group 100 88:00.0 Ethernet controller [0200]: Mellanox Technologies MT27500 Family [ConnectX-3] [15b3:1003]
IOMMU group 35 02:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
IOMMU group 35 02:00.1 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
IOMMU group 35 02:00.2 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
IOMMU group 35 02:00.3 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
IOMMU group 37 08:00.0 Ethernet controller [0200]: Mellanox Technologies MT27500 Family [ConnectX-3] [15b3:1003]
IOMMU group 98 81:00.0 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection [8086:10fb] (rev 01)
IOMMU group 99 81:00.1 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection [8086:10fb] (rev 01)
