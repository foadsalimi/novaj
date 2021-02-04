#!/bin/bash
echo ""
wget -q -O /tmp/ssr https://raw.githubusercontent.com/EVAIAhiqnhaijai/novaj/Master/ensayar/cgh/msg-bar/msg 
cat /tmp/ssr > /tmp/ssrrmu.sh
wget -q -O /tmp/ssr https://www.dropbox.com/s/8ouea8bnmc4n2mi/C-SSR.sh
cat /tmp/ssr >> /tmp/ssrrmu.sh
#curl  https://www.dropbox.com/s/re3lbbkxro23h4g/C-SSR.sh >> 
sed -i "s;VPS•MX;ChumoGH-ADM;g" /tmp/ssrrmu.sh
sed -i "s;@Kalix1;ChumoGH;g" /tmp/ssrrmu.sh
sed -i "s;VPS-MX;chumogh;g" /tmp/ssrrmu.sh
chmod +x /tmp/ssrrmu.sh && bash /tmp/ssrrmu.sh
#sed '/gnula.sh/ d' /tmp/ssrrmu.sh > /bin/ejecutar/crontab
