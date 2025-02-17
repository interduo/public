# migrate collation in filenames from latin2 to utf8
# very useful when migrating from old Samba to new one and change old FS like ext3 to newer like zfs/other

convmv -f iso-8859-2 -t utf8 -r ./directory --notest
