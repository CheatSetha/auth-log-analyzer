#analyze .gz files; check with your script all the (.gz) files and find the number of lines containing 'Failed password'
#!/bin/bash

for file in *.gz
do
    echo "Analyzing $file..."
    zcat "$file" >> all_auth.txt
    # echo $(gunzip -c "$file" | grep "Failed password" | wc -l)
    

done

echo "Total lines containing 'Failed password': $(grep "Failed password" all_auth.txt | wc -l)"
echo "Most IP address occurred in failed attempts: $(grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1)" #185.223.124.30
echo "Top 3rd username with failed attempts: $(grep "Failed password" all_auth.txt | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | tail -n 3 | head -n 1)" #ubuntu
echo "Number of Ip that failed more than 10 times: $(grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{if($1>10) print $1}' | wc -l)" # 1
# echo "Failed more than 100 times: $(grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{if($1>100) print $1}' )" 
# e 9 need to put all 3 ip of russia
# ips_100failed = $(grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{if($1>100) print $2}')
# for ip in $ips_100failed;
# do
#     geoiplookup $ip 
# done

echo "Number of IP associated with Accepted password: $(grep "Accepted password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | wc -l)" # 
# E11 (put all ip)
echo "Ip that associated with Accepted password: $(grep "Accepted password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c)" #
# E12 : answer: 2d4bf2b591ce8332bc29c38b657891b8
# grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{if($1>500) print $2}' >> unsucess_attempt
echo $(grep "Failed password" all_auth.txt | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{if($1>500) print $2}' >> ip500failed.txt)
# convert file ip_500failed.txt to md5
md5sum ip500failed.txt
rm ip500failed.txt #remove the file to prevent redundancy when running the script again
# E13: answer: 764618
echo "Total number of entries in all_auth.txt: $(wc -l all_auth.txt)" # 764618

#E14: find duplicate entries
echo "uplicate entries: $(sort all_auth.txt | uniq -d)" # Oct 29 18:10:07 ip-172-31-5-50 sshd[1302819]: Failed password for invalid user ubnt from 221.159.44.18 port 63504 ssh2

rm all_auth.txt #remove the file to prevent redundancy when running the script again