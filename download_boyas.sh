SHOST="ftp.pmel.noaa.gov"
SUSER="taopmelftp"
SPASSWD="G10b@LCh@Ng3"

cd ~/mnt/d/CIO/Kelvin-cromwell/boyas
ftp -n $SHOST << GETBOUYS
	quote USER $SUSER
	quote PASS $SPASSWD
	prompt
	passive
	binary
	cd cdf/sites/daily
	mget t[0][n]*w*
  mget t[0][n]*e*
	quit
GETBOUYS

exit 0
