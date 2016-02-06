echo "*** 1 ***"
echo "BANNER=\"WARNING:Authorized use only.\n\"" > /etc/issue.net
cat /etc/issue.net
echo ""
sleep 1

echo "*** 2 ***"
sed -i '/PermitRootLogin yes/c\PermitRootLogin without-password' /etc/ssh/sshd_config
grep PermitRootLogin /etc/pam.d/login
echo ""
sleep 1

echo "*** 3 ***"
if [ -f /etc/securetty ]; then
  mv /etc/securetty /etc/securetty.bak
fi
echo ""
sleep 1

echo "*** 4 ***"
sed -i '/pam_securetty.so/c\auth [success=ok new_authtok_reqd=ok ignore=ignore user_unknown=ignore default=bad] pam_securetty.so' /etc/pam.d/login
grep pam_securetty.so /etc/pam.d/login
echo ""
sleep 1

set_passwd_expire() {
  USER_ID=$1
  CNT=`grep -c $USER_ID /etc/passwd`
  if [ $CNT == "1" ]; then
    passwd -x 90 $USER_ID
  fi
}

echo "*** 5 ***"
passwd -x 90 root
set_passwd_expire root
set_passwd_expire cloudapp
set_passwd_expire nfv
set_passwd_expire onebox
echo ""
sleep 1

echo "*** 6 ***"
sed -i '/pam_unix.so/c\password        [success=1 default=ignore]      pam_unix.so minlen=8 obscure sha512' /etc/pam.d/common-password
grep pam_unix.so /etc/pam.d/common-password
echo ""
sleep 1

add_group_wheel() {
  CNT=`grep -c wheel /etc/group`
  if [ $CNT == "0" ]; then
    groupadd wheel
  fi
  grep wheel /etc/group
}

add_to_wheel_group() {
  USER_ID=$1
  CNT=`grep -c $USER_ID /etc/passwd`
  if [ $CNT == "1" ]; then
    usermod -G wheel $USER_ID
  fi
}
echo "*** 7 ***"
echo "groupadd"
add_group_wheel
echo "usermod"
add_to_wheel_group cloudapp
add_to_wheel_group nfv
add_to_wheel_group onebox

CNT=`grep -c "^auth      required  pam_wheel.so group=wheel" /etc/pam.d/su`
if [ $CNT == "0" ]; then
  sed -i '/pam_wheel.so/c\auth      required  pam_wheel.so group=wheel' /etc/pam.d/su
fi
grep pam_wheel.so /etc/pam.d/su
echo ""
sleep 1

echo "*** 8 ***"
CNT=`grep -c "TMOUT" /etc/profile`

if [ $CNT == "0" ]; then
  export TMOUT=900 > /etc/profile
fi
grep TMOUT /etc/profile
echo ""
sleep 1

echo "*** 9 ***"
echo "chmod 755 /tmp"
chmod 755 /tmp
chmod 755 /var/tmp
chmod 755 /dev/shm
chmod 400 /etc/shadow
echo ""
sleep 1

echo "*** 10 ***"
cat /etc/passwd | awk -F: '{printf(" %-20s %-50s\n", $1,$6)}' | grep -wv "\/" | sort -u | xargs -n 2 sh -c 'ls -ald $1' 2> /dev/null | awk '{ printf(" %-20s %-10s %-10s %-10s\n", $1,$3,$4,$9)}'
echo ""
sleep 1

echo "*** 11 ***"
CNT=`grep -c "PASS_MAX_DAYS  90" /etc/login.defs`
if [ $CNT == "0" ]; then
  sed -i '/PASS_MAX_DAYS/c\PASS_MAX_DAYS  90' /etc/login.defs
fi
grep PASS_MAX_DAYS /etc/login.defs
echo ""
sleep 1

echo "*** 12 ***"
CNT=`grep -c "PASS_MIN_DAYS  1" /etc/login.defs`
if [ $CNT == "0" ]; then
  sed -i '/PASS_MIN_DAYS/c\PASS_MIN_DAYS  1' /etc/login.defs
fi
grep PASS_MIN_DAYS /etc/login.defs
echo ""
sleep 1
