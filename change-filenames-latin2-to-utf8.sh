# migrate collation in filenames from latin2 to utf8
# very useful when migrating from old Samba to new one and change old FS like ext3 to newer like zfs/other

convmv -f iso-8859-2 -t utf8 -r ./directory
#if all is ok and You checked it then use --notest in upper cmd

#find and color aliens
find /folder -regex '.*[^%\]\[a-zA-Z0-9 ~_-.,ĄąĆćĘęŁłŃńÓóŚśŹźŻż)(].*' | grep --color=always -P '[^/\[\]a-zA-Z0-9 _\-\.\,ĄąĆćĘęŁłŃńÓóŚśŹźŻż~)(%]'
